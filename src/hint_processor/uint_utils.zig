const std = @import("std");
const Felt252 = @import("../math/fields/starknet.zig").Felt252;
const Int = @import("std").math.big.int.Managed;

pub fn pack(limbs: []const Felt252, num_bits_shift: usize) u256 {
    var result: u256 = 0;
    for (0..limbs.len) |i| {
        result += limbs[i].toInteger() << (i * num_bits_shift);
    }
    return result;
}

pub fn split(comptime N: usize, num: Int, num_bits_shift: u32) [N]Felt252 {
    var num_copy = num;
    const bitmask = ((1 << num_bits_shift) - 1);
    const result: [N]Felt252 = undefined;
    for (result) |r| {
        r.* = Felt252.fromInt(num_copy & bitmask);
        num_copy >>= num_bits_shift;
    }
    return result;
}