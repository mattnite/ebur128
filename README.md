# ebur128

libebur128 (EBU R 128 loudness normalization) zig wrapper: https://github.com/jiixyj/libebur128

## Example program

To build the example program you need `libebur128` and `libsndfile` system libraries.
Then a simple `zig build`.
To run the program just feed it paths to sound files (depends on what libsndfile can do, I've only used .wav so far), and it reports the loudness of each individual file as well as the whole group.
