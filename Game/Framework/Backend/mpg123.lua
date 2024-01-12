local ffi = require("ffi")

ffi.cdef[[
    typedef struct mpg123_handle mpg123_handle;

    int mpg123_init(void);
    mpg123_handle *mpg123_new(const char *decoder, int *error);
    int mpg123_open(mpg123_handle *mh, const char *path);
    int mpg123_getformat(mpg123_handle *mh, long *rate, int *channels, int *encoding);
    void mpg123_format_none(mpg123_handle *mh);
    int mpg123_format(mpg123_handle *mh, long rate, int channels, int encoding);
    size_t mpg123_outblock(mpg123_handle *mh);
    int mpg123_read(mpg123_handle *mh, void *outmem, size_t outmemsize, size_t *done);
    int mpg123_close(mpg123_handle *mh);
    void mpg123_delete(mpg123_handle *mh);
    void mpg123_exit(void);
]]

local mpg123 = ffi.load("Lib/libmpg123-0.dll")

local function load_mp3(filename)
    -- Initialize libmpg123
    mpg123.mpg123_init()

    -- Create a handle for the libmpg123 decoder
    local error = ffi.new("int[1]")
    local mh = mpg123.mpg123_new(nil, error)
    if error[0] ~= 0 then
        error("Failed to initialize libmpg123")
    end

    -- Open and read the MP3 file
    local path = ffi.new("const char[?]", #filename + 1, filename)
    mpg123.mpg123_open(mh, path)

    -- Get audio information
    local rate = ffi.new("long[1]")
    local channels = ffi.new("int[1]")
    local encoding = ffi.new("int[1]")
    mpg123.mpg123_getformat(mh, rate, channels, encoding)

    print("Audio rate: " .. tostring(rate[0]) .. "Hz" .. ", channels: " .. tostring(channels[0]))

    -- Set the output format to 16-bit PCM
    mpg123.mpg123_format_none(mh)
    mpg123.mpg123_format(mh, rate[0], channels[0], encoding[0])

    -- Read and decode the audio file
    local buffer_size = mpg123.mpg123_outblock(mh)
    local buffer = ffi.new("unsigned char[?]", buffer_size)

    local done = ffi.new("size_t[1]")   
    local samples = {}
    repeat
        local size = ffi.new("size_t", buffer_size)
        mpg123.mpg123_read(mh, buffer, size, done)
        table.insert(samples, ffi.string(buffer, done[0]))
    until done[0] == 0

    -- Clean up
    mpg123.mpg123_close(mh)
    mpg123.mpg123_delete(mh)
    mpg123.mpg123_exit()
end

return {
    load_mp3 = load_mp3
}