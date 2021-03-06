pub usingnamespace @import("std").c.builtins;
pub const max_align_t = struct_unnamed_1;
pub const enum_channel = extern enum(c_int) {
    EBUR128_UNUSED = 0,
    EBUR128_LEFT = 1,
    EBUR128_Mp030 = 1,
    EBUR128_RIGHT = 2,
    EBUR128_Mm030 = 2,
    EBUR128_CENTER = 3,
    EBUR128_Mp000 = 3,
    EBUR128_LEFT_SURROUND = 4,
    EBUR128_Mp110 = 4,
    EBUR128_RIGHT_SURROUND = 5,
    EBUR128_Mm110 = 5,
    EBUR128_DUAL_MONO = 6,
    EBUR128_MpSC = 7,
    EBUR128_MmSC = 8,
    EBUR128_Mp060 = 9,
    EBUR128_Mm060 = 10,
    EBUR128_Mp090 = 11,
    EBUR128_Mm090 = 12,
    EBUR128_Mp135 = 13,
    EBUR128_Mm135 = 14,
    EBUR128_Mp180 = 15,
    EBUR128_Up000 = 16,
    EBUR128_Up030 = 17,
    EBUR128_Um030 = 18,
    EBUR128_Up045 = 19,
    EBUR128_Um045 = 20,
    EBUR128_Up090 = 21,
    EBUR128_Um090 = 22,
    EBUR128_Up110 = 23,
    EBUR128_Um110 = 24,
    EBUR128_Up135 = 25,
    EBUR128_Um135 = 26,
    EBUR128_Up180 = 27,
    EBUR128_Tp000 = 28,
    EBUR128_Bp000 = 29,
    EBUR128_Bp045 = 30,
    EBUR128_Bm045 = 31,
    _,
};
pub const EBUR128_UNUSED = @enumToInt(enum_channel.EBUR128_UNUSED);
pub const EBUR128_LEFT = @enumToInt(enum_channel.EBUR128_LEFT);
pub const EBUR128_Mp030 = @enumToInt(enum_channel.EBUR128_Mp030);
pub const EBUR128_RIGHT = @enumToInt(enum_channel.EBUR128_RIGHT);
pub const EBUR128_Mm030 = @enumToInt(enum_channel.EBUR128_Mm030);
pub const EBUR128_CENTER = @enumToInt(enum_channel.EBUR128_CENTER);
pub const EBUR128_Mp000 = @enumToInt(enum_channel.EBUR128_Mp000);
pub const EBUR128_LEFT_SURROUND = @enumToInt(enum_channel.EBUR128_LEFT_SURROUND);
pub const EBUR128_Mp110 = @enumToInt(enum_channel.EBUR128_Mp110);
pub const EBUR128_RIGHT_SURROUND = @enumToInt(enum_channel.EBUR128_RIGHT_SURROUND);
pub const EBUR128_Mm110 = @enumToInt(enum_channel.EBUR128_Mm110);
pub const EBUR128_DUAL_MONO = @enumToInt(enum_channel.EBUR128_DUAL_MONO);
pub const EBUR128_MpSC = @enumToInt(enum_channel.EBUR128_MpSC);
pub const EBUR128_MmSC = @enumToInt(enum_channel.EBUR128_MmSC);
pub const EBUR128_Mp060 = @enumToInt(enum_channel.EBUR128_Mp060);
pub const EBUR128_Mm060 = @enumToInt(enum_channel.EBUR128_Mm060);
pub const EBUR128_Mp090 = @enumToInt(enum_channel.EBUR128_Mp090);
pub const EBUR128_Mm090 = @enumToInt(enum_channel.EBUR128_Mm090);
pub const EBUR128_Mp135 = @enumToInt(enum_channel.EBUR128_Mp135);
pub const EBUR128_Mm135 = @enumToInt(enum_channel.EBUR128_Mm135);
pub const EBUR128_Mp180 = @enumToInt(enum_channel.EBUR128_Mp180);
pub const EBUR128_Up000 = @enumToInt(enum_channel.EBUR128_Up000);
pub const EBUR128_Up030 = @enumToInt(enum_channel.EBUR128_Up030);
pub const EBUR128_Um030 = @enumToInt(enum_channel.EBUR128_Um030);
pub const EBUR128_Up045 = @enumToInt(enum_channel.EBUR128_Up045);
pub const EBUR128_Um045 = @enumToInt(enum_channel.EBUR128_Um045);
pub const EBUR128_Up090 = @enumToInt(enum_channel.EBUR128_Up090);
pub const EBUR128_Um090 = @enumToInt(enum_channel.EBUR128_Um090);
pub const EBUR128_Up110 = @enumToInt(enum_channel.EBUR128_Up110);
pub const EBUR128_Um110 = @enumToInt(enum_channel.EBUR128_Um110);
pub const EBUR128_Up135 = @enumToInt(enum_channel.EBUR128_Up135);
pub const EBUR128_Um135 = @enumToInt(enum_channel.EBUR128_Um135);
pub const EBUR128_Up180 = @enumToInt(enum_channel.EBUR128_Up180);
pub const EBUR128_Tp000 = @enumToInt(enum_channel.EBUR128_Tp000);
pub const EBUR128_Bp000 = @enumToInt(enum_channel.EBUR128_Bp000);
pub const EBUR128_Bp045 = @enumToInt(enum_channel.EBUR128_Bp045);
pub const EBUR128_Bm045 = @enumToInt(enum_channel.EBUR128_Bm045);
pub const enum_error = extern enum(c_int) {
    EBUR128_SUCCESS = 0,
    EBUR128_ERROR_NOMEM = 1,
    EBUR128_ERROR_INVALID_MODE = 2,
    EBUR128_ERROR_INVALID_CHANNEL_INDEX = 3,
    EBUR128_ERROR_NO_CHANGE = 4,
    _,
};
pub const EBUR128_SUCCESS = @enumToInt(enum_error.EBUR128_SUCCESS);
pub const EBUR128_ERROR_NOMEM = @enumToInt(enum_error.EBUR128_ERROR_NOMEM);
pub const EBUR128_ERROR_INVALID_MODE = @enumToInt(enum_error.EBUR128_ERROR_INVALID_MODE);
pub const EBUR128_ERROR_INVALID_CHANNEL_INDEX = @enumToInt(enum_error.EBUR128_ERROR_INVALID_CHANNEL_INDEX);
pub const EBUR128_ERROR_NO_CHANGE = @enumToInt(enum_error.EBUR128_ERROR_NO_CHANGE);
pub const enum_mode = extern enum(c_int) {
    EBUR128_MODE_M = 1,
    EBUR128_MODE_S = 3,
    EBUR128_MODE_I = 5,
    EBUR128_MODE_LRA = 11,
    EBUR128_MODE_SAMPLE_PEAK = 17,
    EBUR128_MODE_TRUE_PEAK = 49,
    EBUR128_MODE_HISTOGRAM = 64,
    _,
};
pub const EBUR128_MODE_M = @enumToInt(enum_mode.EBUR128_MODE_M);
pub const EBUR128_MODE_S = @enumToInt(enum_mode.EBUR128_MODE_S);
pub const EBUR128_MODE_I = @enumToInt(enum_mode.EBUR128_MODE_I);
pub const EBUR128_MODE_LRA = @enumToInt(enum_mode.EBUR128_MODE_LRA);
pub const EBUR128_MODE_SAMPLE_PEAK = @enumToInt(enum_mode.EBUR128_MODE_SAMPLE_PEAK);
pub const EBUR128_MODE_TRUE_PEAK = @enumToInt(enum_mode.EBUR128_MODE_TRUE_PEAK);
pub const EBUR128_MODE_HISTOGRAM = @enumToInt(enum_mode.EBUR128_MODE_HISTOGRAM);
pub const struct_ebur128_state_internal = opaque {};
const struct_unnamed_2 = extern struct {
    mode: c_int,
    channels: c_uint,
    samplerate: c_ulong,
    d: ?*struct_ebur128_state_internal,
};
pub const ebur128_state = struct_unnamed_2;
pub extern fn ebur128_get_version(major: [*c]c_int, minor: [*c]c_int, patch: [*c]c_int) void;
pub extern fn ebur128_init(channels: c_uint, samplerate: c_ulong, mode: c_int) [*c]ebur128_state;
pub extern fn ebur128_destroy(st: [*c][*c]ebur128_state) void;
pub extern fn ebur128_set_channel(st: [*c]ebur128_state, channel_number: c_uint, value: c_int) c_int;
pub extern fn ebur128_change_parameters(st: [*c]ebur128_state, channels: c_uint, samplerate: c_ulong) c_int;
pub extern fn ebur128_set_max_window(st: [*c]ebur128_state, window: c_ulong) c_int;
pub extern fn ebur128_set_max_history(st: [*c]ebur128_state, history: c_ulong) c_int;
pub extern fn ebur128_add_frames_short(st: [*c]ebur128_state, src: [*c]const c_short, frames: usize) c_int;
pub extern fn ebur128_add_frames_int(st: [*c]ebur128_state, src: [*c]const c_int, frames: usize) c_int;
pub extern fn ebur128_add_frames_float(st: [*c]ebur128_state, src: [*c]const f32, frames: usize) c_int;
pub extern fn ebur128_add_frames_double(st: [*c]ebur128_state, src: [*c]const f64, frames: usize) c_int;
pub extern fn ebur128_loudness_global(st: [*c]ebur128_state, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_global_multiple(sts: [*c][*c]ebur128_state, size: usize, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_momentary(st: [*c]ebur128_state, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_shortterm(st: [*c]ebur128_state, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_window(st: [*c]ebur128_state, window: c_ulong, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_range(st: [*c]ebur128_state, out: [*c]f64) c_int;
pub extern fn ebur128_loudness_range_multiple(sts: [*c][*c]ebur128_state, size: usize, out: [*c]f64) c_int;
pub extern fn ebur128_sample_peak(st: [*c]ebur128_state, channel_number: c_uint, out: [*c]f64) c_int;
pub extern fn ebur128_prev_sample_peak(st: [*c]ebur128_state, channel_number: c_uint, out: [*c]f64) c_int;
pub extern fn ebur128_true_peak(st: [*c]ebur128_state, channel_number: c_uint, out: [*c]f64) c_int;
pub extern fn ebur128_prev_true_peak(st: [*c]ebur128_state, channel_number: c_uint, out: [*c]f64) c_int;
pub extern fn ebur128_relative_threshold(st: [*c]ebur128_state, out: [*c]f64) c_int;
pub const EBUR128_VERSION_MAJOR = 1;
pub const EBUR128_VERSION_MINOR = 2;
pub const EBUR128_VERSION_PATCH = 6;
pub const NULL = @import("std").meta.cast(?*c_void, 0);
pub fn offsetof(t: anytype, d: anytype) callconv(.Inline) @TypeOf(__builtin_offsetof(t, d)) {
    return __builtin_offsetof(t, d);
}
pub const channel = enum_channel;
pub const @"error" = enum_error;
pub const mode = enum_mode;
pub const ebur128_state_internal = struct_ebur128_state_internal;
