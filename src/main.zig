const std = @import("std");

const base = @import("base.zig");
const movegen = @import("movegen.zig");
const movelist = @import("movelist.zig");
const chesstest = @import("chesstest.zig");

pub fn chessTest() !void {
    for (chesstest.Test.positions) |position| {
        var v = std.mem.split(u8, position, ";");
        const fen = v.first();
        std.debug.print("{s}\n", .{fen});
        var i: u32 = 1;
        var n = v.next();
        while (n) |item| {
            var perft_vals = std.mem.split(u8, item, " ");
            _ = perft_vals.first();
            const expected = try std.fmt.parseInt(u32, perft_vals.next().?, 10);
            movelist._Perft(fen, i);
            const result = movelist.MoveReceiver.nodes;
            const status = if (result == expected) "OK" else "ERROR";
            if (result == expected) {
                std.debug.print("   {}: {} {s}\n", .{i, result, status});
            } else {
                std.debug.print("xxx -> {}: {} vs {} {s}\n", .{i, result, expected, status});
            }
            if (i == 6) {
                break;
            }
            i += 1;
            n = v.next();
        }
    }
}

pub fn main() anyerror!void {
    const args = std.os.argv;
    std.log.info("{s}\n", .{args[0..]});
    try chessTest();
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
