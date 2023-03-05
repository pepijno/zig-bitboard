const std = @import("std");

const Movemap = @import("movemap.zig");

const Lookup = Movemap.LookupPext;
pub const Bit = u64;
pub const Square = u64;
pub const Map = u64;

pub inline fn squareOf(x: u64) u64 {
    return @ctz(x);
}

pub inline fn popBit(x: *u64) Bit {
    const lsb = @ctz(x.*);
    x.* &= x.* - 1;
    return @as(u64, 1) << @intCast(u6, lsb);
}

pub const BoardStatus = struct {
    const w_not_occupied_l: u64 = 0b01110000;
    const w_not_attacked_l: u64 = 0b00111000;

    const w_not_occupied_r: u64 = 0b00000110;
    const w_not_attacked_r: u64 = 0b00001110;

    const b_not_occupied_l: u64 = 0b01110000 << 56;
    const b_not_attacked_l: u64 = 0b00111000 << 56;

    const b_not_occupied_r: u64 = 0b00000110 << 56;
    const b_not_attacked_r: u64 = 0b00001110 << 56;

    const w_rook_l_change: u64 = 0b11111000;
    const b_rook_l_change: u64 = 0b11111000 << 56;
    const w_rook_r_change: u64 = 0b00001111;
    const b_rook_r_change: u64 = 0b00001111 << 56;

    const w_rook_l: u64 = 0b10000000;
    const b_rook_l: u64 = 0b10000000 << 56;
    const w_rook_r: u64 = 0b00000001;
    const b_rook_r: u64 = 0b00000001 << 56;

    white_move: bool,
    has_ep_pawn: bool,

    white_castle_l: bool,
    white_castle_r: bool,

    black_castle_l: bool,
    black_castle_r: bool,

    pub inline fn init(white: bool, ep: bool, white_castle_left: bool, white_castle_right: bool, black_castle_left: bool, black_castle_right: bool) @This() {
        return .{
            .white_move = white,
            .has_ep_pawn = ep,
            .white_castle_l = white_castle_left,
            .white_castle_r = white_castle_right,
            .black_castle_l = black_castle_left,
            .black_castle_r = black_castle_right,
        };
    }

    pub inline fn initByPat(pat: u32) @This() {
        return .{
            .white_move     = (pat & 0b100000) != 0,
            .has_ep_pawn    = (pat & 0b010000) != 0,
            .white_castle_l = (pat & 0b001000) != 0,
            .white_castle_r = (pat & 0b000100) != 0,
            .black_castle_l = (pat & 0b000010) != 0,
            .black_castle_r = (pat & 0b000001) != 0,
        };
    }

    pub inline fn canCastle(self: @This()) bool {
        if (self.white_move) {
            return self.white_castle_l or self.white_castle_r;
        } else {
            return self.black_castle_l or self.black_castle_r;
        }
    }

    pub inline fn canCastleL(self: @This()) bool {
        return if (self.white_move) self.white_castle_l else self.black_castle_l;
    }

    pub inline fn canCastleR(self: @This()) bool {
        return if (self.white_move) self.white_castle_r else self.black_castle_r;
    }

    pub inline fn castleRookSwitchR(self: @This()) u64 {
        return if (self.white_move) 0b00000101 else (0b00000101 << 56);
    }

    pub inline fn castleRookSwitchL(self: @This()) u64 {
        return if (self.white_move) 0b10010000 else (0b10010000 << 56);
    }

    pub inline fn canCastleLeft(self: @This(), attacked: Map, occupied: Map, rook: Map) bool {
        if (self.white_move and self.white_castle_l) {
            if ((occupied & w_not_occupied_l) != 0) {
                return false;
            }
            if ((attacked & w_not_attacked_l) != 0) {
                return false;
            }
            if ((rook & w_rook_l) != 0) {
                return true;
            }
            return false;
        } else if (self.black_castle_l) {
            if ((occupied & b_not_occupied_l) != 0) {
                return false;
            }
            if ((attacked & b_not_attacked_l) != 0) {
                return false;
            }
            if ((rook & b_rook_l) != 0) {
                return true;
            }
            return false;
        }
        return false;
    }

    pub inline fn canCastleRight(self: @This(), attacked: Map, occupied: Map, rook: Map) bool {
        if (self.white_move and self.white_castle_r) {
            if ((occupied & w_not_occupied_r) != 0) {
                return false;
            }
            if ((attacked & w_not_attacked_r) != 0) {
                return false;
            }
            if ((rook & w_rook_r) != 0) {
                return true;
            }
            return false;
        } else if (self.black_castle_r) {
            if ((occupied & b_not_occupied_r) != 0) {
                return false;
            }
            if ((attacked & b_not_attacked_r) != 0) {
                return false;
            }
            if ((rook & b_rook_r) != 0) {
                return true;
            }
            return false;
        }
        return false;
    }

    pub inline fn isLeftRook(self: @This(), rook: Bit) bool {
        return if (self.white_move) w_rook_l == rook else b_rook_l == rook;
    }

    pub inline fn isRightRook(self: @This(), rook: Bit) bool {
        return if (self.white_move) w_rook_r == rook else b_rook_r == rook;
    }

    pub inline fn pawnPush(self: @This()) @This() {
        return .{
            .white_move     = !self.white_move,
            .has_ep_pawn    = true,
            .white_castle_l = self.white_castle_l,
            .white_castle_r = self.white_castle_r,
            .black_castle_l = self.black_castle_l,
            .black_castle_r = self.black_castle_r,
        };
    }

    pub inline fn kingMove(self: @This()) @This() {
        if (self.white_move) {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = false,
                .white_castle_r = false,
                .black_castle_l = self.black_castle_l,
                .black_castle_r = self.black_castle_r,
            };
        } else {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = self.white_castle_l,
                .white_castle_r = self.white_castle_r,
                .black_castle_l = false,
                .black_castle_r = false,
            };
        }
    }

    pub inline fn rookMoveLeft(self: @This()) @This() {
        if (self.white_move) {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = false,
                .white_castle_r = self.white_castle_r,
                .black_castle_l = self.black_castle_l,
                .black_castle_r = self.black_castle_r,
            };
        } else {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = self.white_castle_l,
                .white_castle_r = self.white_castle_r,
                .black_castle_l = false,
                .black_castle_r = self.black_castle_r,
            };
        }
    }

    pub inline fn rookMoveRight(self: @This()) @This() {
        if (self.white_move) {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = self.white_castle_l,
                .white_castle_r = false,
                .black_castle_l = self.black_castle_l,
                .black_castle_r = self.black_castle_r,
            };
        } else {
            return .{
                .white_move     = !self.white_move,
                .has_ep_pawn    = false,
                .white_castle_l = self.white_castle_l,
                .white_castle_r = self.white_castle_r,
                .black_castle_l = self.black_castle_l,
                .black_castle_r = false,
            };
        }
    }

    pub inline fn silentMove(self: @This()) @This() {
        return .{
            .white_move     = !self.white_move,
            .has_ep_pawn    = false,
            .white_castle_l = self.white_castle_l,
            .white_castle_r = self.white_castle_r,
            .black_castle_l = self.black_castle_l,
            .black_castle_r = self.black_castle_r,
        };
    }

    pub inline fn default() @This() {
        return .{
            .white_move     = true,
            .has_ep_pawn    = false,
            .white_castle_l = true,
            .white_castle_r = true,
            .black_castle_l = true,
            .black_castle_r = true,
        };
    }
};

const FenField = enum {
    white,
    has_ep,
    white_castle_l,
    white_castle_r,
    black_castle_l,
    black_castle_r,
};

pub const Fen = struct {
    pub fn fenEnpassant(fen: []const u8) u64 {
        var i: u64 = 0;

        while (fen[i] != ' ') : (i += 1) {}
        i += 1;

        const wb: u8 = fen[i];
        i += 2;

        while (fen[i] != ' ') : (i += 1) {}
        i += 1;

        const eor_minus = fen[i];

        if (eor_minus != '-') {
            if (wb == 'w') {
                const ep_pos: u6 = @intCast(u6, 32 + ('h' - eor_minus));
                return @as(u64, 1) << ep_pos;
            }
            if (wb == 'b') {
                const ep_pos: u6 = @intCast(u6, 24 + ('h' - eor_minus));
                return @as(u64, 1) << ep_pos;
            }
        }

        return 0;
    }

    pub fn fenInfo(comptime field: FenField, fen: []const u8) bool {
        var i: u64 = 0;
        var c: u8 = 0;

        while (fen[i] != ' ') : (i += 1) {}
        i += 1;
        const wb = fen[i];
        i += 1;

        if (field == .white) {
            return (wb == 'w');
        }
        i += 1;

        // std.debug.print("artarst {c} {s}\n", .{wb, fen[i..]});
        while (fen[i] != ' ') : (i += 1) {
            c = fen[i];
            if (field == .white_castle_r) {
                if (c == 'K') {
                    return true;
                }
            }
            if (field == .white_castle_l) {
                if (c == 'Q') {
                    return true;
                }
            }
            if (field == .black_castle_r) {
                if (c == 'k') {
                    return true;
                }
            }
            if (field == .black_castle_l) {
                if (c == 'q') {
                    return true;
                }
            }
        }
        if (field == .white_castle_r or field == .white_castle_l or field == .black_castle_r or field == .black_castle_l) {
            return false;
        }

        i += 1;

        var eor_minus = fen[i];
        if (eor_minus != '-') {
            if (wb == 'w') {
                if (field == .has_ep) {
                    return true;
                }
            }
            if (wb == 'b') {
                if (field == .has_ep) {
                    return true;
                }
            }
        }
        if (field == .has_ep) {
            return false;
        }
        return false;
    }

    pub fn fenToBmp(fen: []const u8, p: u8) u64 {
        var i: u64 = 0;
        var c: u8 = 0;
        var field: u6 = 63;

        var result: u64 = 0;
        while (fen[i] != ' ') : (i += 1) {
            c = fen[i];
            const P: u64 = @as(u64, 1) << field;
            switch (c) {
                '/' => {
                    field += 1;
                },
                '1' => {},
                '2' => {
                    field -= 1;
                },
                '3' => {
                    field -= 2;
                },
                '4' => {
                    field -= 3;
                },
                '5' => {
                    field -= 4;
                },
                '6' => {
                    field -= 5;
                },
                '7' => {
                    field -= 6;
                },
                '8' => {
                    field -= 7;
                },
                else => {
                    if (c == p) {
                        result |= P;
                    }
                },
            }
            field -%= 1;
        }

        return result;
    }
};

pub const BoardPiece = enum {
    pawn,
    knight,
    bishop,
    rook,
    queen,
    king,
};

pub const Board = struct {
    black_pawn: Map,
    black_knight: Map,
    black_bishop: Map,
    black_rook: Map,
    black_queen: Map,
    black_king: Map,
    white_pawn: Map,
    white_knight: Map,
    white_bishop: Map,
    white_rook: Map,
    white_queen: Map,
    white_king: Map,

    white: Map,
    black: Map,
    occ: Map,

    pub inline fn init(bp: Map, bn: Map, bb: Map, br: Map, bq: Map, bk: Map,
        wp: Map, wn: Map, wb: Map, wr: Map, wq: Map, wk: Map) @This() {
        return .{
            .black_pawn = bp,
            .black_knight = bn,
            .black_bishop = bb,
            .black_rook = br,
            .black_queen = bq,
            .black_king = bk,
            .white_pawn = wp,
            .white_knight = wn,
            .white_bishop = wb,
            .white_rook = wr,
            .white_queen = wq,
            .white_king = wk,
            .black = bp | bn | bb | br | bq | bk,
            .white = wp | wn | wb | wr | wq | wk,
            .occ = bp | bn | bb | br | bq | bk | wp | wn | wb | wr | wq | wk,
        };
    }

    pub inline fn initFromFEN(fen: []const u8) @This() {
        return init(
            Fen.fenToBmp(fen, 'p'),
            Fen.fenToBmp(fen, 'n'),
            Fen.fenToBmp(fen, 'b'),
            Fen.fenToBmp(fen, 'r'),
            Fen.fenToBmp(fen, 'q'),
            Fen.fenToBmp(fen, 'k'),
            Fen.fenToBmp(fen, 'P'),
            Fen.fenToBmp(fen, 'N'),
            Fen.fenToBmp(fen, 'B'),
            Fen.fenToBmp(fen, 'R'),
            Fen.fenToBmp(fen, 'Q'),
            Fen.fenToBmp(fen, 'K'),
        );
    }

    pub inline fn movePromote(comptime piece: BoardPiece, comptime is_white: bool, existing: @This(), from: u64, to: u64) @This() {
        const rem = ~to;
        const bp = existing.black_pawn;
        const bn = existing.black_knight;
        const bb = existing.black_bishop;
        const br = existing.black_rook;
        const bq = existing.black_queen;
        const bk = existing.black_king;

        const wp = existing.white_pawn;
        const wn = existing.white_knight;
        const wb = existing.white_bishop;
        const wr = existing.white_rook;
        const wq = existing.white_queen;
        const wk = existing.white_king;

        if (is_white) {
            switch (piece) {
                .queen => {
                    return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ from, wn, wb, wr, wq ^ to, wk);
                },
                .rook => {
                    return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ from, wn, wb, wr ^ to, wq, wk);
                },
                .bishop => {
                    return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ from, wn, wb ^ to, wr, wq, wk);
                },
                .knight => {
                    return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ from, wn ^ to, wb, wr, wq, wk);
                },
                else => {
                    unreachable;
                },
            }
        } else {
            switch (piece) {
                .queen => {
                    return init(bp ^ from, bn, bb, br, bq ^ to, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                },
                .rook => {
                    return init(bp ^ from, bn, bb, br ^ to, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                },
                .bishop => {
                    return init(bp ^ from, bn, bb ^ to, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                },
                .knight => {
                    return init(bp ^ from, bn ^ to, bb, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                },
                else => {
                    unreachable;
                },
            }
        }
    }

    pub inline fn moveCastle(comptime is_white: bool, existing: @This(), kingswitch: u64, rookswitch: u64) @This() {
        const bp = existing.black_pawn;
        const bn = existing.black_knight;
        const bb = existing.black_bishop;
        const br = existing.black_rook;
        const bq = existing.black_queen;
        const bk = existing.black_king;

        const wp = existing.white_pawn;
        const wn = existing.white_knight;
        const wb = existing.white_bishop;
        const wr = existing.white_rook;
        const wq = existing.white_queen;
        const wk = existing.white_king;

        if (is_white) {
            return init(bp, bn, bb, br, bq, bk, wp, wn, wb, wr ^ rookswitch, wq, wk ^ kingswitch);
        } else {
            return init(bp, bn, bb, br ^ rookswitch, bq, bk ^ kingswitch, wp, wn, wb, wr, wq, wk);
        }
    }

    pub inline fn moveEP(comptime is_white: bool, existing: @This(), from: u64, enemy: u64, to: u64) @This() {
        const rem = ~enemy;
        const bp = existing.black_pawn;
        const bn = existing.black_knight;
        const bb = existing.black_bishop;
        const br = existing.black_rook;
        const bq = existing.black_queen;
        const bk = existing.black_king;

        const wp = existing.white_pawn;
        const wn = existing.white_knight;
        const wb = existing.white_bishop;
        const wr = existing.white_rook;
        const wq = existing.white_queen;
        const wk = existing.white_king;
        const mov = from | to;

        if (is_white) {
            return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ mov, wn, wb, wr, wq, wk);
        } else {
            return init(bp ^ mov, bn, bb, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
        }
    }

    pub inline fn move(comptime piece: BoardPiece, comptime is_white: bool, existing: @This(), from: u64, to: u64, is_taking: bool) @This() {
        if (is_taking) {
            return moveComp(piece, is_white, true, existing, from, to);
        } else {
            return moveComp(piece, is_white, false, existing, from, to);
        }
    }

    pub inline fn moveComp(comptime piece: BoardPiece, comptime is_white: bool, comptime is_taking: bool, existing: @This(), from: u64, to: u64) @This() {
        const bp = existing.black_pawn;
        const bn = existing.black_knight;
        const bb = existing.black_bishop;
        const br = existing.black_rook;
        const bq = existing.black_queen;
        const bk = existing.black_king;

        const wp = existing.white_pawn;
        const wn = existing.white_knight;
        const wb = existing.white_bishop;
        const wr = existing.white_rook;
        const wq = existing.white_queen;
        const wk = existing.white_king;

        const mov = from | to;

        if (is_taking) {
            const rem = ~to;
            if (is_white) {
                switch (piece) {
                    .pawn => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp ^ mov, wn, wb, wr, wq, wk);
                    },
                    .knight => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp, wn ^ mov, wb, wr, wq, wk);
                    },
                    .bishop => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp, wn, wb ^ mov, wr, wq, wk);
                    },
                    .rook => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp, wn, wb, wr ^ mov, wq, wk);
                    },
                    .queen => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp, wn, wb, wr, wq ^ mov, wk);
                    },
                    .king => {
                        return init(bp & rem, bn & rem, bb & rem, br & rem, bq & rem, bk, wp, wn, wb, wr, wq, wk ^ mov);
                    },
                }
            } else {
                switch (piece) {
                    .pawn => {
                        return init(bp ^ mov, bn, bb, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                    .knight => {
                        return init(bp, bn ^ mov, bb, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                    .bishop => {
                        return init(bp, bn, bb ^ mov, br, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                    .rook => {
                        return init(bp, bn, bb, br ^ mov, bq, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                    .queen => {
                        return init(bp, bn, bb, br, bq ^ mov, bk, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                    .king => {
                        return init(bp, bn, bb, br, bq, bk ^ mov, wp & rem, wn & rem, wb & rem, wr & rem, wq & rem, wk);
                    },
                }
            }
        } else {
            if (is_white) {
                switch (piece) {
                    .pawn => {
                        return init(bp, bn, bb, br, bq, bk, wp ^ mov, wn, wb, wr, wq, wk);
                    },
                    .knight => {
                        return init(bp, bn, bb, br, bq, bk, wp, wn ^ mov, wb, wr, wq, wk);
                    },
                    .bishop => {
                        return init(bp, bn, bb, br, bq, bk, wp, wn, wb ^ mov, wr, wq, wk);
                    },
                    .rook => {
                        return init(bp, bn, bb, br, bq, bk, wp, wn, wb, wr ^ mov, wq, wk);
                    },
                    .queen => {
                        return init(bp, bn, bb, br, bq, bk, wp, wn, wb, wr, wq ^ mov, wk);
                    },
                    .king => {
                        return init(bp, bn, bb, br, bq, bk, wp, wn, wb, wr, wq, wk ^ mov);
                    },
                }
            } else {
                switch (piece) {
                    .pawn => {
                        return init(bp ^ mov, bn, bb, br, bq, bk, wp, wn, wb, wr, wq, wk);
                    },
                    .knight => {
                        return init(bp, bn ^ mov, bb, br, bq, bk, wp, wn, wb, wr, wq, wk);
                    },
                    .bishop => {
                        return init(bp, bn, bb ^ mov, br, bq, bk, wp, wn, wb, wr, wq, wk);
                    },
                    .rook => {
                        return init(bp, bn, bb, br ^ mov, bq, bk, wp, wn, wb, wr, wq, wk);
                    },
                    .queen => {
                        return init(bp, bn, bb, br, bq ^ mov, bk, wp, wn, wb, wr, wq, wk);
                    },
                    .king => {
                        return init(bp, bn, bb, br, bq, bk ^ mov, wp, wn, wb, wr, wq, wk);
                    },
                }
            }
        }
    }

    pub inline fn default() @This() {
        return initFromFEN("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
    }
};

pub fn mapBitToChar(bit: u64, brd: Board) u8 {
    if (bit & brd.black_pawn) {
        return 'p';
    }
    if (bit & brd.black_pawn) {
        return 'n';
    }
    if (bit & brd.black_pawn) {
        return 'b';
    }
    if (bit & brd.black_pawn) {
        return 'r';
    }
    if (bit & brd.black_pawn) {
        return 'q';
    }
    if (bit & brd.black_pawn) {
        return 'k';
    }
    if (bit & brd.black_pawn) {
        return 'P';
    }
    if (bit & brd.black_pawn) {
        return 'N';
    }
    if (bit & brd.black_pawn) {
        return 'B';
    }
    if (bit & brd.black_pawn) {
        return 'R';
    }
    if (bit & brd.black_pawn) {
        return 'Q';
    }
    if (bit & brd.black_pawn) {
        return 'K';
    }
    return '.';
}
