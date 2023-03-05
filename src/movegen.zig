const base = @import("base.zig");
const Map = base.Map;
const Board = base.Board;
const Bit = base.Bit;

const file1: u64 = 0b1000000010000000100000001000000010000000100000001000000010000000;
const file8: u64 = 0b0000000100000001000000010000000100000001000000010000000100000001;
const rank2: u64 = 0b0000000000000000000000000000000000000000000000001111111100000000;
const rank7: u64 = 0b0000000011111111000000000000000000000000000000000000000000000000;
const rank_mid: u64 = 0x0000FFFFFFFF0000;
const rank_18: u64 = 0xFF000000000000FF;

pub inline fn pawnsNotLeft() Map {
    return ~file1;
}

pub inline fn pawnsNotRight() Map {
    return ~file8;
}

pub inline fn pawnForward(comptime is_white: bool, mask: Map) Map {
    return if (is_white) mask << 8 else mask >> 8;
}

pub inline fn pawnForward2(comptime is_white: bool, mask: Map) Map {
    return if (is_white) mask << 16 else mask >> 16;
}

pub inline fn pawnBackward(comptime is_white: bool, mask: Map) Map {
    return pawnForward(!is_white, mask);
}

pub inline fn pawnBackward2(comptime is_white: bool, mask: Map) Map {
    return pawnForward2(!is_white, mask);
}

pub inline fn pawnAttackLeft(comptime is_white: bool, mask: Map) Map {
    return if (is_white) mask << 9 else mask >> 7;
}

pub inline fn pawnAttackRight(comptime is_white: bool, mask: Map) Map {
    return if (is_white) mask << 7 else mask >> 9;
}

pub inline fn pawnInvertLeft(comptime is_white: bool, mask: Map) Map {
    return pawnAttackRight(!is_white, mask);
}

pub inline fn pawnInvertRight(comptime is_white: bool, mask: Map) Map {
    return pawnAttackLeft(!is_white, mask);
}

pub inline fn pawnsFirstRank(comptime is_white: bool) Map {
    return if (is_white) rank2 else rank7;
}

pub inline fn pawnsLastRank(comptime is_white: bool) Map {
    return if (is_white) rank7 else rank2;
}

pub inline fn king(comptime is_white: bool, brd: Board) Bit {
    return if (is_white) brd.white_king else brd.black_king;
}

pub inline fn enemyKing(comptime is_white: bool, brd: Board) Bit {
    return if (is_white) brd.black_king else brd.white_king;
}

pub inline fn pawns(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_pawn else brd.black_pawn;
}

pub inline fn ownColor(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white else brd.black;
}

pub inline fn enemy(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.black else brd.white;
}

pub inline fn enemyRookQueen(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.black_rook | brd.black_queen else brd.white_rook | brd.white_queen;
}

pub inline fn rookQueen(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_rook | brd.white_queen else brd.black_rook | brd.black_queen;
}

pub inline fn enemyBishopQueen(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.black_bishop | brd.black_queen else brd.white_bishop | brd.white_queen;
}

pub inline fn bishopQueen(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_bishop | brd.white_queen else brd.black_bishop | brd.black_queen;
}

pub inline fn enemyOrEmpty(comptime is_white: bool, brd: Board) Map {
    return if (is_white) ~brd.white else ~brd.black;
}

pub inline fn empty(brd: Board) Map {
    return ~brd.occ;
}

pub inline fn knights(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_knight else brd.black_knight;
}

pub inline fn rooks(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_rook else brd.black_rook;
}

pub inline fn bishops(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_bishop else brd.black_bishop;
}

pub inline fn queens(comptime is_white: bool, brd: Board) Map {
    return if (is_white) brd.white_queen else brd.black_queen;
}
