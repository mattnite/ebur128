const std = @import("std");
const c = @import("c.zig");

pub const Error = error{
    OutOfMemory,
    InvalidMode,
    InvalidChannelIndex,
    NoChange,
    Unknown,
};

fn translateErr(ret: c_int) Error!void {
    return switch (ret) {
        0 => {},
        c.EBUR128_ERROR_NOMEM => error.OutOfMemory,
        c.EBUR128_ERROR_INVALID_MODE => error.InvalidMode,
        c.EBUR128_ERROR_INVALID_CHANNEL_INDEX => error.InvalidChannelIndex,
        c.EBUR128_ERROR_NO_CHANGE => error.NoChange,
        else => error.Unknown,
    };
}

pub const Mode = enum(c_int) {
    m = c.EBUR128_MODE_M,
    s = c.EBUR128_MODE_S,
    i = c.EBUR128_MODE_I,
    lra = c.EBUR128_MODE_LRA,
    sample_peak = c.EBUR128_MODE_SAMPLE_PEAK,
    true_peak = c.EBUR128_MODE_TRUE_PEAK,
};

pub fn getVersion() std.SemanticVersion {
    var ret: std.SemanticVersion = undefined;
    c.ebur128_get_version(&ret.major, &ret.minor, &ret.patch);
    return ret;
}

/// Get global integrated loudness in LUFS.
pub fn loudnessGlobalMultiple(states: []*State) Error!f64 {
    var ret: f64 = undefined;
    try translateErr(c.ebur128_loudness_global_multiple(@ptrCast([*c][*c]c.ebur128_state, states.ptr), states.len, &ret));
    return ret;
}

/// Get loudness range (LRA) in LU across multiple instances.
///
/// Calculates loudness range according to EBU 3342.
pub fn loudnessGlobalRange(states: []*State) Error!f64 {
    var ret: f64 = undefined;
    try translateErr(c.ebur128_loudness_global_range(@ptrCast([*c][*c]c.ebur128_state, states.ptr), states.len, &ret));
    return ret;
}

pub const State = opaque {
    const Self = @This();

    // the library uses a non opaque struct with an opaque member for private
    // members. I'm just going to treat it as all opaque and add getter functions
    fn cast(state: *State) *c.ebur128_state {
        return @ptrCast(*c.ebur128_state, @alignCast(@alignOf([*c]c.ebur128_state), state));
    }

    /// Initialize library state.
    ///
    ///  channels the number of channels.
    ///  sample_rate the sample rate.
    ///  mode see the mode enum for possible values.
    pub fn create(channels: u32, sample_rate: u64, mode: Mode) Error!*Self {
        return if (c.ebur128_init(channels, sample_rate, @enumToInt(mode))) |ptr|
            @ptrCast(*Self, ptr)
        else
            error.Unknown;
    }

    pub fn destroy(self: **Self) void {
        c.ebur128_destroy(@ptrCast([*c][*c]c.ebur128_state, self));
    }

    pub fn getSampleRate(self: *Self) u64 {
        return self.cast().samplerate;
    }

    pub fn getChannels(self: *Self) u32 {
        return self.cast().channels;
    }

    pub fn getMode(self: *Self) Mode {
        return @intToEnum(Mode, self.cast().mode);
    }

    /// Set channel type.
    ///
    /// The default is:
    /// - 0 -> EBUR128_LEFT
    /// - 1 -> EBUR128_RIGHT
    /// - 2 -> EBUR128_CENTER
    /// - 3 -> EBUR128_UNUSED
    /// - 4 -> EBUR128_LEFT_SURROUND
    /// - 5 -> EBUR128_RIGHT_SURROUND
    ///
    /// channel_number zero based channel index.
    /// channel_type channel type from the "channel" enum.
    pub fn setChannel(self: *Self, channel_num: u32, channel_type: Channel) Error!void {
        return translateErr(c.ebur128_set_channel(self.cast(), channel_num, @enumToInt(channel_type)));
    }

    /// Change library parameters.
    ///
    /// Note that the channel map will be reset when setting a different number of
    /// channels. The current unfinished block will be lost.
    ///
    /// channels: new number of channels.
    /// sample_rate: new sample rate.
    pub fn changeParameters(self: *Self, channels: u32, sample_rate: u64) Error!void {
        return translateErr(c.ebur128_change_parameters(self.cast(), channels, sample_rate));
    }

    /// Set the maximum window duration.
    ///
    /// Set the maximum duration that will be used for ebur128_loudness_window().
    /// Note that this destroys the current content of the audio buffer.
    ///
    /// window: duration of the window in ms.
    pub fn setMaxWindow(self: *Self, window: u64) Error!void {
        return translateErr(c.ebur128_set_max_window(self.cast(), window));
    }

    /// Set the maximum history.
    ///
    /// Set the maximum history that will be stored for loudness integration.
    /// More history provides more accurate results, but requires more resources.
    ///
    /// Applies to ebur128_loudness_range() and ebur128_loudness_global() when
    /// EBUR128_MODE_HISTOGRAM is not set.
    ///
    /// Default is ULONG_MAX (at least ~50 days).
    /// Minimum is 3000ms for EBUR128_MODE_LRA and 400ms for EBUR128_MODE_M.
    ///
    /// history: duration of history in ms.
    pub fn setMaxHistory(self: *Self, history: u64) Error!void {
        return translateErr(c.ebur128_set_max_history(self.cast(), history));
    }

    /// Add frames to be processed.
    ///
    /// @param src array of source frames. Channels must be interleaved.
    /// @param frames number of frames. Not number of samples!
    pub fn addFrames(self: *Self, comptime T: type, frames: []T) Error!void {
        return translateErr(switch (T) {
            i16 => c.ebur128_add_frames_short(self.cast(), frames.ptr, frames.len),
            i32 => c.ebur128_add_frames_int(self.cast(), frames.ptr, frames.len),
            f32 => c.ebur128_add_frames_float(self.cast(), frames.ptr, frames.len),
            f64 => c.ebur128_add_frames_double(self.cast(), frames.ptr, frames.len),
            else => @compileError("type " ++ @typeName(T) ++ " not supported"),
        });
    }

    /// Get global integrated loudness in LUFS.
    pub fn loudnessGlobal(self: *Self) Error!f64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_loudness_global(self.cast(), &ret));
        return ret;
    }

    /// Get momentary loudness (last 400ms) in LUFS.
    pub fn loudnessMomentary(self: *Self) Error!f64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_loudness_momentary(self.cast(), &ret));
        return ret;
    }

    /// Get short term loudness (last 3s) in LUFS.
    pub fn loudnessShortTerm(self: *Self) Error!f64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_loudness_shortterm(self.cast(), &ret));
        return ret;
    }

    /// Get loudness of the specified window in LUFS.
    ///
    /// window must not be larger than the current window set in st.
    /// The current window can be changed by calling ebur128_set_max_window().
    ///
    /// window: window in ms to calculate loudness.
    pub fn loudnessWindow(self: *Self, window: u64) Error!f64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_loudness_window(self.cast(), window, &ret));
        return ret;
    }

    /// Get loudness range (LRA) of programme in LU.
    ///
    /// Calculates loudness range according to EBU 3342.
    pub fn loudnessRange(self: *Self) Error!64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_loudness_range(self.cast(), &ret));
        return ret;
    }

    /// Get maximum sample peak from all frames that have been processed.
    ///
    /// The equation to convert to dBFS is: 20 * log10(out)
    ///
    /// channel_num: channel to analyse
    pub fn samplePeak(self: *Self, channel_num: u32) Error!void {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_sample_peak(self.cast(), channel_num, &ret));
        return ret;
    }

    /// Get maximum sample peak from the last call to add_frames().
    ///
    /// The equation to convert to dBFS is: 20 * log10(out)
    ///
    /// channel_num: channel to analyse
    pub fn prevSamplePeak(self: *Self, channel_num: u32) Error!void {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_prev_sample_peak(self.cast(), channel_num, &ret));
        return ret;
    }

    /// Get maximum true peak from all frames that have been processed.
    ///
    /// Uses an implementation defined algorithm to calculate the true peak. Do not
    /// try to compare resulting values across different versions of the library,
    /// as the algorithm may change.
    ///
    /// The current implementation uses a custom polyphase FIR interpolator to
    /// calculate true peak. Will oversample 4x for sample rates < 96000 Hz, 2x for
    /// sample rates < 192000 Hz and leave the signal unchanged for 192000 Hz.
    ///
    /// The equation to convert to dBTP is: 20 * log10(out)
    ///
    /// channel_num: channel to analyse
    pub fn truePeak(self: *Self, channel_num: u32) Error!void {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_true_peak(self.cast(), channel_num, &ret));
        return ret;
    }

    /// Get maximum true peak from the last call to add_frames().
    ///
    /// Uses an implementation defined algorithm to calculate the true peak. Do not
    /// try to compare resulting values across different versions of the library,
    /// as the algorithm may change.
    ///
    /// The current implementation uses a custom polyphase FIR interpolator to
    /// calculate true peak. Will oversample 4x for sample rates < 96000 Hz, 2x for
    /// sample rates < 192000 Hz and leave the signal unchanged for 192000 Hz.
    ///
    /// The equation to convert to dBTP is: 20 * log10(out)
    ///
    /// channel_number: channel to analyse
    /// returns maximum true peak in float format (1.0 is 0 dBTP)
    pub fn prevTruePeak(self: *Self, channel_number: u32) Error!f64 {
        var ret: f64 = undefined;
        try translateError(c.ebur128_prev_true_peak(self.cast(), channel_number, &ret));
        return ret;
    }

    /// Get relative threshold in LUFS.
    pub fn relativeThreshold(self: *Self) f64 {
        var ret: f64 = undefined;
        try translateErr(c.ebur128_relative_threshold(self.cast(), &ret));
        return ret;
    }
};
