const std = @import("std");
const base = @import("base.zig");
const Square = base.Square;
const Board = base.Board;
const BoardPiece = base.BoardPiece;
const BoardStatus = base.BoardStatus;
const Map = base.Map;
const Bit = base.Bit;
const Fen = base.Fen;
const squareOf = base.squareOf;

const Movemap = @import("movemap.zig");
const Movegen = @import("movegen.zig");
const ChessLookup = @import("chesslookup.zig");
 
const Movestack = struct {
    var attack_king: [32]Square = undefined;
    var attack_enemy_king: [32]Square = undefined;
    var check_status: [32]Map = undefined;
};

const Movelist = struct {
    pub var en_passant_target: Map = 0;
    pub var rook_pin: Map = 0;
    pub var bishop_pin: Map = 0;

    pub fn initStack(comptime status: BoardStatus, comptime depth: u32, brd: Board) void {
        const white = status.white_move;
        const enemy = !status.white_move;
        Movestack.attack_king[depth] = Movemap.LookupPext.king(squareOf(Movegen.king(white, brd)));
        Movestack.attack_enemy_king[depth] = Movemap.LookupPext.king(squareOf(Movegen.king(enemy, brd)));
        {
            const pl = Movegen.pawnAttackLeft(enemy, Movegen.pawns(enemy, brd) & Movegen.pawnsNotLeft());
            const pr = Movegen.pawnAttackRight(enemy, Movegen.pawns(enemy, brd) & Movegen.pawnsNotRight());

            if ((pl & Movegen.king(white, brd)) != 0) {
                Movestack.check_status[depth] = Movegen.pawnAttackRight(white, Movegen.king(white, brd));
            } else if ((pr & Movegen.king(white, brd)) != 0) {
                Movestack.check_status[depth] = Movegen.pawnAttackLeft(white, Movegen.king(white, brd));
            } else {
                Movestack.check_status[depth] = 0xFFFF_FFFF_FFFF_FFFF;
            }
        }

        {
            const knight_check = Movemap.LookupPext.knight(squareOf(Movegen.king(white, brd))) & Movegen.knights(enemy, brd);
            if (knight_check != 0) {
                Movestack.check_status[depth] = knight_check;
            }
        }
    }

    pub inline fn init(ep_init: Map) void {
        en_passant_target = ep_init;
        rook_pin = 0;
        bishop_pin = 0;
    }

    pub inline fn registerPinD12(comptime status: BoardStatus, king: Square, enemy: Square, brd: Board, ep_target: *Map) void {
        const pinmask = ChessLookup.pin_between[king * 64 + enemy];

        if (status.has_ep_pawn) {
            if ((pinmask & ep_target.*) != 0) {
                ep_target.* = 0;
            }
        }

        if ((pinmask & Movegen.ownColor(status.white_move, brd)) != 0) {
            bishop_pin |= pinmask;
        }
    }

    pub inline fn registerPinHV(comptime status: BoardStatus, king: Square, enemy: Square, brd: Board) void {
        const pinmask = ChessLookup.pin_between[king * 64 + enemy];

        if ((pinmask & Movegen.ownColor(status.white_move, brd)) != 0) {
            rook_pin |= pinmask;
        }
    }

    pub inline fn epRank(is_white: bool) Map {
        return if (is_white) 0xFF << 32 else 0xFF << 24;
    }

    pub fn registerPinEP(comptime status: BoardStatus, king_square: Square, king: Bit, enemy_rq: Map, brd: Board) void {
        const white = status.white_move;
        const pawns = Movegen.pawns(status.white_move, brd);

        if ((epRank(white) & king) != 0 and (epRank(white) & enemy_rq) != 0 and (epRank(white) & pawns) != 0) {
            const epl_pawn = pawns & ((en_passant_target & Movegen.pawnsNotRight()) >> 1);
            const epr_pawn = pawns & ((en_passant_target & Movegen.pawnsNotLeft()) << 1);

            if (epl_pawn != 0) {
                const after_ep_occ = brd.occ & ~(en_passant_target | epl_pawn);
                if (((Movemap.LookupPext.rook(king_square, after_ep_occ) & epRank(white)) & enemy_rq) != 0) {
                    en_passant_target = 0;
                }
            }
            if (epr_pawn != 0) {
                const after_ep_occ = brd.occ & ~(en_passant_target | epr_pawn);
                if (((Movemap.LookupPext.rook(king_square, after_ep_occ) & epRank(white)) & enemy_rq) != 0) {
                    en_passant_target = 0;
                }
            }
        }
    }

    pub inline fn checkBySlider(king: Square, enemy: Square, king_ban: *Map, check_mask: *Map) void {
        if (check_mask.* == 0xFFFF_FFFF_FFFF_FFFF) {
            check_mask.* = ChessLookup.pin_between[king * 64 + enemy];
        } else {
            check_mask.* = 0;
        }
        king_ban.* |= ChessLookup.check_between[king * 64 + enemy];
    }

    pub fn refresh(comptime status: BoardStatus, depth: u32, brd: Board, king_ban: *Map, check_mask: *Map) Map {
        const white = status.white_move;
        const enemy = !status.white_move;
        const king = Movegen.king(white, brd);
        const king_sq = squareOf(king);

        {
            rook_pin = 0;
            bishop_pin = 0;

            if ((Movemap.rook_mask[king_sq] & Movegen.enemyRookQueen(white, brd)) != 0) {
                var atk_hv = Movemap.LookupPext.rook(king_sq, brd.occ) & Movegen.enemyRookQueen(white, brd);
                while (atk_hv != 0) {
                    const square = squareOf(atk_hv);
                    checkBySlider(king_sq, square, king_ban, check_mask);
                    atk_hv &= atk_hv - 1;
                }

                var pinners_hv = Movemap.LookupPext.rookXRay(king_sq, brd.occ) & Movegen.enemyRookQueen(white, brd);
                while (pinners_hv != 0) {
                    registerPinHV(status, king_sq, squareOf(pinners_hv), brd);
                    pinners_hv &= pinners_hv - 1;
                }
            }
            if ((Movemap.bishop_mask[king_sq] & Movegen.enemyBishopQueen(white, brd)) != 0) {
                var atk_d12 = Movemap.LookupPext.bishop(king_sq, brd.occ) & Movegen.enemyBishopQueen(white, brd);
                while (atk_d12 != 0) {
                    const sq = squareOf(atk_d12);
                    checkBySlider(king_sq, sq, king_ban, check_mask);
                    atk_d12 &= atk_d12 - 1;
                }

                var pinners_d12 = Movemap.LookupPext.bishopXRay(king_sq, brd.occ) & Movegen.enemyBishopQueen(white, brd);
                while (pinners_d12 != 0) {
                    registerPinD12(status, king_sq, squareOf(pinners_d12), brd, &Movelist.en_passant_target);
                    pinners_d12 &= pinners_d12 - 1;
                }
            }

            if (status.has_ep_pawn) {
                registerPinEP(status, king_sq, king, Movegen.enemyRookQueen(white, brd), brd);
            }
        }

        Movestack.check_status[depth - 1] = 0xFFFF_FFFF_FFFF_FFFF;

        const king_atk = Movestack.attack_king[depth] & Movegen.enemyOrEmpty(status.white_move, brd) & ~king_ban.*;
        if (king_atk == 0) {
            return 0;
        }

        {
            var knights = Movegen.knights(enemy, brd);
            while (knights != 0) {
                king_ban.* |= Movemap.LookupPext.knight(squareOf(knights));
                knights &= knights - 1;
            }
        }

        {
            const pl = Movegen.pawnAttackLeft(enemy, Movegen.pawns(enemy, brd) & Movegen.pawnsNotLeft());
            const pr = Movegen.pawnAttackRight(enemy, Movegen.pawns(enemy, brd) & Movegen.pawnsNotRight());

            king_ban.* |= (pl | pr);
        }

        {
            var bishops = Movegen.bishopQueen(enemy, brd);
            while (bishops != 0) {
                const sq = squareOf(bishops);
                const atk = Movemap.LookupPext.bishop(sq, brd.occ);
                king_ban.* |= atk;
                bishops &= bishops - 1;
            }
        }

        {
            var rooks = Movegen.rookQueen(enemy, brd);
            while (rooks != 0) {
                const sq = squareOf(rooks);
                const atk = Movemap.LookupPext.rook(sq, brd.occ);
                king_ban.* |= atk;
                rooks &= rooks - 1;
            }
        }

        return king_atk & ~king_ban.*;
    }

    pub inline fn pawnPruneLeft(comptime is_white: bool, pawn: *Map, pin_d1_d2: Map) void {
        const pinned = pawn.* & Movegen.pawnInvertLeft(is_white, pin_d1_d2 & Movegen.pawnsNotRight());
        const unpinned = pawn.* & ~pin_d1_d2;

        pawn.* = (pinned | unpinned);
    }

    pub inline fn pawnPruneRight(comptime is_white: bool, pawn: *Map, pin_d1_d2: Map) void {
        const pinned = pawn.* & Movegen.pawnInvertRight(is_white, pin_d1_d2 & Movegen.pawnsNotLeft());
        const unpinned = pawn.* & ~pin_d1_d2;

        pawn.* = (pinned | unpinned);
    }

    pub inline fn pawnPruneLeftEP(comptime is_white: bool, pawn: *Map, pin_d1_d2: Map) void {
        const pinned = pawn.* & Movegen.pawnInvertLeft(is_white, pin_d1_d2 & Movegen.pawnsNotRight());
        const unpinned = pawn.* & ~pin_d1_d2;

        pawn.* = (pinned | unpinned);
    }

    pub inline fn pawnPruneRightEP(comptime is_white: bool, pawn: *Map, pin_d1_d2: Map) void {
        const pinned = pawn.* & Movegen.pawnInvertRight(is_white, pin_d1_d2 & Movegen.pawnsNotLeft());
        const unpinned = pawn.* & ~pin_d1_d2;

        pawn.* = (pinned | unpinned);
    }

    pub inline fn pawnPruneMove(comptime is_white: bool, pawn: *Map, pin_hv: Map) void {
        const pinned = pawn.* & Movegen.pawnBackward(is_white, pin_hv);
        const unpinned = pawn.* & ~pin_hv;

        pawn.* = (pinned | unpinned);
    }

    pub inline fn pawnPruneMove2(comptime is_white: bool, pawn: *Map, pin_hv: Map) void {
        const pinned = pawn.* & Movegen.pawnBackward2(is_white, pin_hv);
        const unpinned = pawn.* & ~pin_hv;

        pawn.* = (pinned | unpinned);
    }

    pub fn _enumerate(comptime status: BoardStatus, comptime just_count: bool, comptime depth: u32, brd: Board, king_atk: Map, king_ban: Map, check_mask: Map) u64 {
        // const just_count = CallbackMove == VoidClass;
        const white = status.white_move;
        const no_check = (check_mask == 0xFFFF_FFFF_FFFF_FFFF);
        var move_cnt: u64 = 0;

        const pin_hv = rook_pin;
        const pin_d12 = bishop_pin;
        const movable_square = Movegen.enemyOrEmpty(white, brd) & check_mask;
        const ep_target = en_passant_target;

        var ka = king_atk;

        {
            if (just_count) {
                move_cnt += @popCount(ka);
            } else {
                while (ka != 0) {
                    const sq = squareOf(ka);
                    Movestack.attack_enemy_king[depth - 1] = Movemap.LookupPext.king(sq);
                    MoveReceiver.kingMove(status, depth, brd, Movegen.king(white, brd), @as(u64, 1) << @intCast(u6, sq));
                    ka &= ka - 1;
                }
            }

            if (status.canCastleL()) {
                if (no_check and status.canCastleLeft(king_ban, brd.occ, Movegen.rooks(white, brd))) {
                    if (just_count) {
                        move_cnt += 1;
                    } else {
                        Movestack.attack_enemy_king[depth - 1] = Movemap.LookupPext.king(squareOf(Movegen.king(white, brd) << 2));
                        MoveReceiver.kingCastle(status, depth, brd, (Movegen.king(white, brd) | (Movegen.king(white, brd) << 2)), status.castleRookSwitchL());
                    }
                }
            }

            if (status.canCastleR()) {
                if (no_check and status.canCastleRight(king_ban, brd.occ, Movegen.rooks(white, brd))) {
                    if (just_count) {
                        move_cnt += 1;
                    } else {
                        Movestack.attack_enemy_king[depth - 1] = Movemap.LookupPext.king(squareOf(Movegen.king(white, brd) >> 2));
                        MoveReceiver.kingCastle(status, depth, brd, (Movegen.king(white, brd) | (Movegen.king(white, brd) >> 2)), status.castleRookSwitchR());
                    }
                }
            }
            Movestack.attack_enemy_king[depth - 1] = Movestack.attack_king[depth];
        }

        {
            const pawns_lr = Movegen.pawns(white, brd) & ~pin_hv;
            const pawns_hv = Movegen.pawns(white, brd) & ~pin_d12;

            var l_pawns = pawns_lr & Movegen.pawnInvertLeft(white, Movegen.enemy(white, brd) & Movegen.pawnsNotRight() & check_mask);
            var r_pawns = pawns_lr & Movegen.pawnInvertRight(white, Movegen.enemy(white, brd) & Movegen.pawnsNotLeft() & check_mask);
            var f_pawns = pawns_hv & Movegen.pawnBackward(white, Movegen.empty(brd));
            var p_pawns = f_pawns & Movegen.pawnsFirstRank(white) & Movegen.pawnBackward2(white, Movegen.empty(brd) & check_mask);

            f_pawns &= Movegen.pawnBackward(white, check_mask);

            pawnPruneLeft(white, &l_pawns, pin_d12);
            pawnPruneRight(white, &r_pawns, pin_d12);
            pawnPruneMove(white, &f_pawns, pin_hv);
            pawnPruneMove2(white, &p_pawns, pin_hv);

            if (status.has_ep_pawn) {
                var ep_l_pawn = pawns_lr & Movegen.pawnsNotLeft() & ((ep_target & check_mask) >> 1);
                var ep_r_pawn = pawns_lr & Movegen.pawnsNotRight() & ((ep_target & check_mask) << 1);

                if ((ep_l_pawn | ep_r_pawn) != 0) {
                    pawnPruneLeftEP(white, &ep_l_pawn, pin_d12);
                    pawnPruneRightEP(white, &ep_r_pawn, pin_d12);

                    if (just_count) {
                        if (ep_l_pawn != 0) {
                            move_cnt += 1;
                        }
                        if (ep_r_pawn != 0) {
                            move_cnt += 1;
                        }
                    } else {
                        if (ep_l_pawn != 0) {
                            MoveReceiver.pawnEnpassantTake(status, depth, brd, ep_l_pawn, ep_l_pawn << 1, Movegen.pawnAttackLeft(white, ep_l_pawn));
                        }
                        if (ep_r_pawn != 0) {
                            MoveReceiver.pawnEnpassantTake(status, depth, brd, ep_r_pawn, ep_r_pawn >> 1, Movegen.pawnAttackRight(white, ep_r_pawn));
                        }
                    }
                }
            }

            if (((l_pawns | r_pawns | f_pawns) & Movegen.pawnsLastRank(white)) != 0) {
                var promote_left = l_pawns & Movegen.pawnsLastRank(white);
                var promote_right = r_pawns & Movegen.pawnsLastRank(white);
                var promote_move = f_pawns & Movegen.pawnsLastRank(white);

                var no_promote_left = l_pawns & ~Movegen.pawnsLastRank(white);
                var no_promote_right = r_pawns & ~Movegen.pawnsLastRank(white);
                var no_promote_move = f_pawns & ~Movegen.pawnsLastRank(white);

                if (just_count) {
                    move_cnt += 4 * @popCount(promote_left);
                    move_cnt += 4 * @popCount(promote_right);
                    move_cnt += 4 * @popCount(promote_move);

                    move_cnt += @popCount(no_promote_left);
                    move_cnt += @popCount(no_promote_right);
                    move_cnt += @popCount(no_promote_move);
                    move_cnt += @popCount(p_pawns);
                } else {
                    while (promote_left != 0) {
                        const pos = base.popBit(&promote_left);
                        MoveReceiver.pawnPromote(status, depth, brd, pos, Movegen.pawnAttackLeft(white, pos));
                    }
                    while (promote_right != 0) {
                        const pos = base.popBit(&promote_right);
                        MoveReceiver.pawnPromote(status, depth, brd, pos, Movegen.pawnAttackRight(white, pos));
                    }
                    while (promote_move != 0) {
                        const pos = base.popBit(&promote_move);
                        MoveReceiver.pawnPromote(status, depth, brd, pos, Movegen.pawnForward(white, pos));
                    }
                    while (no_promote_left != 0) {
                        const pos = base.popBit(&no_promote_left);
                        MoveReceiver.pawnAtk(status, depth, brd, pos, Movegen.pawnAttackLeft(white, pos));
                    }
                    while (no_promote_right != 0) {
                        const pos = base.popBit(&no_promote_right);
                        MoveReceiver.pawnAtk(status, depth, brd, pos, Movegen.pawnAttackRight(white, pos));
                    }
                    while (no_promote_move != 0) {
                        const pos = base.popBit(&no_promote_move);
                        MoveReceiver.pawnMove(status, depth, brd, pos, Movegen.pawnForward(white, pos));
                    }
                    while (p_pawns != 0) {
                        const pos = base.popBit(&p_pawns);
                        MoveReceiver.pawnPush(status, depth, brd, pos, Movegen.pawnForward2(white, pos));
                    }
                }
            } else {
                if (just_count) {
                    move_cnt += @popCount(l_pawns);
                    move_cnt += @popCount(r_pawns);
                    move_cnt += @popCount(f_pawns);
                    move_cnt += @popCount(p_pawns);
                } else {
                    while (l_pawns != 0) {
                        const pos = base.popBit(&l_pawns);
                        MoveReceiver.pawnAtk(status, depth, brd, pos, Movegen.pawnAttackLeft(white, pos));
                    }
                    while (r_pawns != 0) {
                        const pos = base.popBit(&r_pawns);
                        MoveReceiver.pawnAtk(status, depth, brd, pos, Movegen.pawnAttackRight(white, pos));
                    }
                    while (f_pawns != 0) {
                        const pos = base.popBit(&f_pawns);
                        MoveReceiver.pawnMove(status, depth, brd, pos, Movegen.pawnForward(white, pos));
                    }
                    while (p_pawns != 0) {
                        const pos = base.popBit(&p_pawns);
                        MoveReceiver.pawnPush(status, depth, brd, pos, Movegen.pawnForward2(white, pos));
                    }
                }
            }
        }

        {
            var knights = Movegen.knights(white, brd) & ~(pin_hv | pin_d12);
            while (knights != 0) {
                const sq = squareOf(knights);
                var move = Movemap.LookupPext.knight(sq) & movable_square;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    while (move != 0) {
                        const to = base.popBit(&move);
                        MoveReceiver.knightMove(status, depth, brd, @as(u64, 1) << @intCast(u6, sq), to);
                    }
                }

                knights &= knights - 1;
            }
        }

        const queens = Movegen.queens(white, brd);
        {
            const bishops = Movegen.bishops(white, brd) & ~pin_hv;

            var bish_pinned = (bishops | queens) & pin_d12;
            var bish_no_pin = bishops & ~pin_d12;
            while (bish_pinned != 0) {
                const sq = squareOf(bish_pinned);
                var move = Movemap.LookupPext.bishop(sq, brd.occ) & movable_square & pin_d12;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    const pos = @as(u64, 1) << @intCast(u6, sq);
                    if ((pos & queens) != 0) {
                        while (move != 0) {
                            const to = base.popBit(&move);
                            MoveReceiver.queenMove(status, depth, brd, pos, to);
                        }
                    } else {
                        while (move != 0) {
                            const to = base.popBit(&move);
                            MoveReceiver.bishopMove(status, depth, brd, pos, to);
                        }
                    }
                }
                bish_pinned &= bish_pinned - 1;
            }
            while (bish_no_pin != 0) {
                const sq = squareOf(bish_no_pin);
                var move = Movemap.LookupPext.bishop(sq, brd.occ) & movable_square;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    while (move != 0) {
                        const to = base.popBit(&move);
                        MoveReceiver.bishopMove(status, depth, brd, @as(u64, 1) << @intCast(u6, sq), to);
                    }
                }
                bish_no_pin &= bish_no_pin - 1;
            }
        }

        {
            const rooks = Movegen.rooks(white, brd) & ~pin_d12;

            var rook_pinned = (rooks | queens) & pin_hv;
            var rook_no_pin = rooks & ~pin_hv;

            while (rook_pinned != 0) {
                const sq = squareOf(rook_pinned);
                var move = Movemap.LookupPext.rook(sq, brd.occ) & movable_square & pin_hv;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    const pos = @as(u64, 1) << @intCast(u6, sq);
                    if ((pos & queens) != 0) {
                        while (move != 0) {
                            const to = base.popBit(&move);
                            MoveReceiver.queenMove(status, depth, brd, pos, to);
                        }
                    } else {
                        while (move != 0) {
                            const to = base.popBit(&move);
                            MoveReceiver.rookMove(status, depth, brd, pos, to);
                        }
                    }
                }
                rook_pinned &= rook_pinned - 1;
            }
            while (rook_no_pin != 0) {
                const sq = squareOf(rook_no_pin);
                var move = Movemap.LookupPext.rook(sq, brd.occ) & movable_square;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    while (move != 0) {
                        const to = base.popBit(&move);
                        MoveReceiver.rookMove(status, depth, brd, @as(u64, 1) << @intCast(u6, sq), to);
                    }
                }
                rook_no_pin &= rook_no_pin - 1;
            }
        }

        {
            var qs = queens & ~(pin_hv | pin_d12);
            while (qs != 0) {
                const sq = squareOf(qs);
                const atk = Movemap.LookupPext.queen(sq, brd.occ);

                var move = atk & movable_square;

                if (just_count) {
                    move_cnt += @popCount(move);
                } else {
                    while (move != 0) {
                        const to = base.popBit(&move);
                        MoveReceiver.queenMove(status, depth, brd, @as(u64, 1) << @intCast(u6, sq), to);
                    }
                }
                qs &= qs - 1;
            }
        }

        if (just_count) {
            return move_cnt;
        } else {
            return 0;
        }
    }

    pub inline fn enumerateMoves(comptime status: BoardStatus, comptime just_count: bool, comptime depth: u32, brd: Board) void {
        var check_mask = Movestack.check_status[depth];
        var king_ban = Movestack.attack_enemy_king[depth];
        Movestack.attack_king[depth - 1] = Movestack.attack_enemy_king[depth];
        var king_atk = refresh(status, depth, brd, &king_ban, &check_mask);

        if (check_mask != 0) {
            _ = _enumerate(status, just_count, depth, brd, king_atk, king_ban, check_mask);
        } else {
            while (king_atk != 0) {
                const sq = squareOf(king_atk);
                Movestack.attack_enemy_king[depth - 1] = Movemap.LookupPext.king(sq);
                MoveReceiver.kingMove(status, depth, brd, Movegen.king(status.white_move, brd), @as(u64, 1) << @intCast(u6, sq));
                king_atk &= king_atk - 1;
            }
        }
    }

    pub inline fn count(comptime status: BoardStatus, brd: Board) u64 {
        var check_mask = Movestack.check_status[1];
        var king_ban = Movestack.attack_enemy_king[1];
        const king_atk = refresh(status, 1, brd, &king_ban, &check_mask);

        if (check_mask != 0) {
            return _enumerate(status, true, 1, brd, king_atk, king_ban, check_mask);
        } else {
            return @popCount(king_atk);
        }
    }
};

pub const MoveReceiver = struct {
    pub var nodes: u64 = 0;

    pub inline fn init() void {
        nodes = 0;
    }

    pub inline fn perfT0() void {
        nodes += 1;
    }

    pub inline fn perfT1(comptime status: BoardStatus, brd: Board) void {
        nodes += Movelist.count(status, brd);
    }

    pub inline fn perfT(comptime status: BoardStatus, comptime depth: u32, brd: Board) void {
        if (depth == 1) {
            perfT1(status, brd);
        } else {
            Movelist.enumerateMoves(status, false, depth, brd);
        }
    }

    pub fn kingMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.move(.king, status.white_move, brd, from, to, to & Movegen.enemy(status.white_move, brd) != 0);
        perfT(status.kingMove(), depth - 1, next);
    }

    pub fn kingCastle(comptime status: BoardStatus, comptime depth: u32, brd: Board, king_switch: u64, rook_switch: u64) void {
        const next = Board.moveCastle(status.white_move, brd, king_switch, rook_switch);
        perfT(status.kingMove(), depth - 1, next);
    }

    pub fn pawnCheck(comptime status: BoardStatus, comptime depth: u32, e_king: Map, to: u64) void {
        const white = status.white_move;
        const pl = Movegen.pawnAttackLeft(white, to & Movegen.pawnsNotLeft());
        const pr = Movegen.pawnAttackRight(white, to & Movegen.pawnsNotRight());

        if (e_king & (pl | pr) != 0) {
            Movestack.check_status[depth - 1] = to;
        }
    }

    pub fn knightCheck(comptime status: BoardStatus, comptime depth: u32, e_king: Map, to: u64) void {
        _ = status;
        if (Movemap.LookupPext.knight(squareOf(e_king)) & to != 0) {
            Movestack.check_status[depth - 1] = to;
        }
    }

    pub fn pawnMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.moveComp(.pawn, status.white_move, false, brd, from, to);
        pawnCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.silentMove(), depth - 1, next);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;
    }

    pub fn pawnAtk(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.moveComp(.pawn, status.white_move, true, brd, from, to);
        pawnCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.silentMove(), depth - 1, next);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;
    }

    pub fn pawnEnpassantTake(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, enemy: u64, to: u64) void {
        const next = Board.moveEP(status.white_move, brd, from, enemy, to);

        pawnCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.silentMove(), depth - 1, next);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;
    }

    pub fn pawnPush(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.moveComp(.pawn, status.white_move, false, brd, from, to);
        Movelist.en_passant_target = to;
        pawnCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.pawnPush(), depth - 1, next);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;
    }

    pub fn pawnPromote(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next1 = Board.movePromote(.queen, status.white_move, brd, from, to);
        perfT(status.silentMove(), depth - 1, next1);

        const next2 = Board.movePromote(.knight, status.white_move, brd, from, to);
        knightCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.silentMove(), depth - 1, next2);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;

        const next3 = Board.movePromote(.bishop, status.white_move, brd, from, to);
        perfT(status.silentMove(), depth - 1, next3);
        const next4 = Board.movePromote(.rook, status.white_move, brd, from, to);
        perfT(status.silentMove(), depth - 1, next4);
    }

    pub fn knightMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.move(.knight, status.white_move, brd, from, to, to & Movegen.enemy(status.white_move, brd) != 0);
        knightCheck(status, depth, Movegen.enemyKing(status.white_move, brd), to);
        perfT(status.silentMove(), depth - 1, next);
        Movestack.check_status[depth - 1] = 0xffff_ffff_ffff_ffff;
    }

    pub fn bishopMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.move(.bishop, status.white_move, brd, from, to, to & Movegen.enemy(status.white_move, brd) != 0);
        perfT(status.silentMove(), depth - 1, next);
    }

    pub fn rookMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.move(.rook, status.white_move, brd, from, to, to & Movegen.enemy(status.white_move, brd) != 0);

        if (status.canCastle()) {
            if (status.isLeftRook(from)) {
                perfT(status.rookMoveLeft(), depth - 1, next);
            } else if (status.isRightRook(from)) {
                perfT(status.rookMoveRight(), depth - 1, next);
            } else {
                perfT(status.silentMove(), depth - 1, next);
            }
        } else {
            perfT(status.silentMove(), depth - 1, next);
        }
    }

    pub fn queenMove(comptime status: BoardStatus, comptime depth: u32, brd: Board, from: u64, to: u64) void {
        const next = Board.move(.queen, status.white_move, brd, from, to, to & Movegen.enemy(status.white_move, brd) != 0);
        perfT(status.silentMove(), depth - 1, next);
    }
};

pub fn Perft(comptime status: BoardStatus, def: []const u8, brd: Board, depth: u32) void {
    MoveReceiver.init();
    Movelist.init(Fen.fenEnpassant(def));

    switch (depth) {
        0 => {
            Movelist.initStack(status, 0, brd);
            MoveReceiver.perfT0();
        },
        1 => {
            Movelist.initStack(status, 1, brd);
            MoveReceiver.perfT1(status, brd);
        },
        2 => {
            Movelist.initStack(status, 2, brd);
            MoveReceiver.perfT(status, 2, brd);
        },
        3 => {
            Movelist.initStack(status, 3, brd);
            MoveReceiver.perfT(status, 3, brd);
        },
        4 => {
            Movelist.initStack(status, 4, brd);
            MoveReceiver.perfT(status, 4, brd);
        },
        5 => {
            Movelist.initStack(status, 5, brd);
            MoveReceiver.perfT(status, 5, brd);
        },
        6 => {
            Movelist.initStack(status, 6, brd);
            MoveReceiver.perfT(status, 6, brd);
        },
        7 => {
            Movelist.initStack(status, 7, brd);
            MoveReceiver.perfT(status, 7, brd);
        },
        8 => {
            Movelist.initStack(status, 8, brd);
            MoveReceiver.perfT(status, 8, brd);
        },
        9 => {
            Movelist.initStack(status, 9, brd);
            MoveReceiver.perfT(status, 9, brd);
        },
        10 => {
            Movelist.initStack(status, 10, brd);
            MoveReceiver.perfT(status, 10, brd);
        },
        11 => {
            Movelist.initStack(status, 11, brd);
            MoveReceiver.perfT(status, 11, brd);
        },
        12 => {
            Movelist.initStack(status, 12, brd);
            MoveReceiver.perfT(status, 12, brd);
        },
        13 => {
            Movelist.initStack(status, 13, brd);
            MoveReceiver.perfT(status, 13, brd);
        },
        14 => {
            Movelist.initStack(status, 14, brd);
            MoveReceiver.perfT(status, 14, brd);
        },
        15 => {
            Movelist.initStack(status, 15, brd);
            MoveReceiver.perfT(status, 15, brd);
        },
        16 => {
            Movelist.initStack(status, 16, brd);
            MoveReceiver.perfT(status, 16, brd);
        },
        17 => {
            Movelist.initStack(status, 17, brd);
            MoveReceiver.perfT(status, 17, brd);
        },
        18 => {
            Movelist.initStack(status, 18, brd);
            MoveReceiver.perfT(status, 18, brd);
        },
        else => {
            return;
        },
    }
}

pub fn _Perft(pos: []const u8, depth: u32) void {
    const wh = Fen.fenInfo(.white, pos);
    const ep = Fen.fenInfo(.has_ep, pos);
    const bl = Fen.fenInfo(.black_castle_l, pos);
    const br = Fen.fenInfo(.black_castle_r, pos);
    const wl = Fen.fenInfo(.white_castle_l, pos);
    const wr = Fen.fenInfo(.white_castle_r, pos);
    const brd = Board.initFromFEN(pos);
    if ( wh and  ep and  wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b111111), pos, brd, depth); }
    if ( wh and  ep and  wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b111110), pos, brd, depth); }
    if ( wh and  ep and  wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b111101), pos, brd, depth); }
    if ( wh and  ep and  wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b111100), pos, brd, depth); }
    if ( wh and  ep and  wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b111011), pos, brd, depth); }
    if ( wh and  ep and  wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b111010), pos, brd, depth); }
    if ( wh and  ep and  wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b111001), pos, brd, depth); }
    if ( wh and  ep and  wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b111000), pos, brd, depth); }
    if ( wh and  ep and !wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b110111), pos, brd, depth); }
    if ( wh and  ep and !wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b110110), pos, brd, depth); }
    if ( wh and  ep and !wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b110101), pos, brd, depth); }
    if ( wh and  ep and !wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b110100), pos, brd, depth); }
    if ( wh and  ep and !wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b110011), pos, brd, depth); }
    if ( wh and  ep and !wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b110010), pos, brd, depth); }
    if ( wh and  ep and !wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b110001), pos, brd, depth); }
    if ( wh and  ep and !wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b110000), pos, brd, depth); }
    if ( wh and !ep and  wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b101111), pos, brd, depth); }
    if ( wh and !ep and  wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b101110), pos, brd, depth); }
    if ( wh and !ep and  wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b101101), pos, brd, depth); }
    if ( wh and !ep and  wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b101100), pos, brd, depth); }
    if ( wh and !ep and  wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b101011), pos, brd, depth); }
    if ( wh and !ep and  wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b101010), pos, brd, depth); }
    if ( wh and !ep and  wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b101001), pos, brd, depth); }
    if ( wh and !ep and  wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b101000), pos, brd, depth); }
    if ( wh and !ep and !wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b100111), pos, brd, depth); }
    if ( wh and !ep and !wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b100110), pos, brd, depth); }
    if ( wh and !ep and !wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b100101), pos, brd, depth); }
    if ( wh and !ep and !wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b100100), pos, brd, depth); }
    if ( wh and !ep and !wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b100011), pos, brd, depth); }
    if ( wh and !ep and !wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b100010), pos, brd, depth); }
    if ( wh and !ep and !wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b100001), pos, brd, depth); }
    if ( wh and !ep and !wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b100000), pos, brd, depth); }
    if (!wh and  ep and  wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b011111), pos, brd, depth); }
    if (!wh and  ep and  wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b011110), pos, brd, depth); }
    if (!wh and  ep and  wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b011101), pos, brd, depth); }
    if (!wh and  ep and  wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b011100), pos, brd, depth); }
    if (!wh and  ep and  wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b011011), pos, brd, depth); }
    if (!wh and  ep and  wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b011010), pos, brd, depth); }
    if (!wh and  ep and  wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b011001), pos, brd, depth); }
    if (!wh and  ep and  wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b011000), pos, brd, depth); }
    if (!wh and  ep and !wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b010111), pos, brd, depth); }
    if (!wh and  ep and !wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b010110), pos, brd, depth); }
    if (!wh and  ep and !wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b010101), pos, brd, depth); }
    if (!wh and  ep and !wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b010100), pos, brd, depth); }
    if (!wh and  ep and !wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b010011), pos, brd, depth); }
    if (!wh and  ep and !wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b010010), pos, brd, depth); }
    if (!wh and  ep and !wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b010001), pos, brd, depth); }
    if (!wh and  ep and !wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b010000), pos, brd, depth); }
    if (!wh and !ep and  wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b001111), pos, brd, depth); }
    if (!wh and !ep and  wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b001110), pos, brd, depth); }
    if (!wh and !ep and  wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b001101), pos, brd, depth); }
    if (!wh and !ep and  wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b001100), pos, brd, depth); }
    if (!wh and !ep and  wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b001011), pos, brd, depth); }
    if (!wh and !ep and  wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b001010), pos, brd, depth); }
    if (!wh and !ep and  wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b001001), pos, brd, depth); }
    if (!wh and !ep and  wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b001000), pos, brd, depth); }
    if (!wh and !ep and !wl and   wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b000111), pos, brd, depth); }
    if (!wh and !ep and !wl and   wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b000110), pos, brd, depth); }
    if (!wh and !ep and !wl and   wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b000101), pos, brd, depth); }
    if (!wh and !ep and !wl and   wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b000100), pos, brd, depth); }
    if (!wh and !ep and !wl and  !wr and  bl and  br) { return Perft(BoardStatus.initByPat(0b000011), pos, brd, depth); }
    if (!wh and !ep and !wl and  !wr and  bl and !br) { return Perft(BoardStatus.initByPat(0b000010), pos, brd, depth); }
    if (!wh and !ep and !wl and  !wr and !bl and  br) { return Perft(BoardStatus.initByPat(0b000001), pos, brd, depth); }
    if (!wh and !ep and !wl and  !wr and !bl and !br) { return Perft(BoardStatus.initByPat(0b000000), pos, brd, depth); }
    return Perft(BoardStatus.default(), pos, brd, depth);
}
