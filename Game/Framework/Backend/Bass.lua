local ffi = require("ffi")

ffi.cdef [[
typedef int8_t BYTE;
typedef int16_t WORD;
typedef int32_t DWORD;
typedef int64_t QWORD;

typedef int BOOL;

typedef DWORD HMUSIC;
typedef DWORD HSAMPLE;
typedef DWORD HCHANNEL;
typedef DWORD HSTREAM;
typedef DWORD HRECORD;
typedef DWORD HSYNC;
typedef DWORD HDSP;
typedef DWORD HFX;
typedef DWORD HPLUGIN;

typedef struct {
	DWORD freq;
	DWORD chans;
	DWORD flags;
	DWORD ctype;
	DWORD origres;
	HPLUGIN plugin;
	HSAMPLE sample;
	const char *filename;
} BASS_CHANNELINFO;

typedef struct {
	DWORD freq;
	float volume;
	float pan;
	DWORD flags;
	DWORD length;
	DWORD max;
	DWORD origres;
	DWORD chans;
	DWORD mingap;
	DWORD mode3d;
	float mindist;
	float maxdist;
	DWORD iangle;
	DWORD oangle;
	float outvol;
	DWORD vam;
	DWORD priority;
} BASS_SAMPLE;

typedef struct {
	DWORD flags;
	DWORD hwsize;
	DWORD hwfree;
	DWORD freesam;
	DWORD free3d;
	DWORD minrate;
	DWORD maxrate;
	BOOL eax;
	DWORD minbuf;
	DWORD dsver;
	DWORD latency;
	DWORD initflags;
	DWORD speakers;
	DWORD freq;
} BASS_INFO;

typedef struct {
	char *name;
	char *driver;
	DWORD flags;
} BASS_DEVICEINFO;

BOOL BASS_Init(int device, DWORD freq, DWORD flags, void *win, void *dsguid);
BOOL BASS_Free();
HSAMPLE BASS_SampleCreate(DWORD length, DWORD freq, DWORD chans, DWORD max, DWORD flags);
BOOL BASS_SampleGetInfo(HSAMPLE handle, BASS_SAMPLE *info);
BOOL BASS_SampleGetData(HSAMPLE handle, void *buffer);
BOOL BASS_SampleSetData(HSAMPLE handle, const void *buffer);
QWORD BASS_ChannelSeconds2Bytes(DWORD handle, double pos);
QWORD BASS_ChannelGetPosition(DWORD handle, DWORD mode);
BOOL BASS_ChannelGetInfo(DWORD handle, BASS_CHANNELINFO *info);
QWORD BASS_ChannelGetLength(DWORD handle, DWORD mode);
HSAMPLE BASS_SampleLoad(BOOL mem, const void *file, QWORD offset, DWORD length, DWORD max, DWORD flags);
BOOL BASS_SampleFree(HSAMPLE handle);
BOOL BASS_ChannelFree(DWORD handle);
BOOL BASS_ChannelSetAttribute(DWORD handle, DWORD attrib, float value);
HSTREAM BASS_StreamCreateFile(BOOL mem, const void *file, QWORD offset, QWORD length, DWORD flags);
DWORD BASS_SampleGetChannel(HSAMPLE handle, DWORD flags);
BOOL BASS_ChannelPlay(DWORD handle, BOOL restart);
BOOL BASS_ChannelStop(DWORD handle);
BOOL BASS_ChannelPause(DWORD handle);
DWORD BASS_ChannelIsActive(DWORD handle);
double BASS_ChannelBytes2Seconds(DWORD handle, QWORD pos);
BOOL BASS_ChannelSetPosition(DWORD handle, QWORD pos, DWORD mode);
HPLUGIN BASS_PluginLoad(const char *file, DWORD flags);
BOOL BASS_PluginFree(HPLUGIN handle);
DWORD BASS_SampleGetChannels(HSAMPLE handle, HCHANNEL *channels);
int BASS_ErrorGetCode();
BOOL BASS_GetInfo(BASS_INFO *info);
BOOL BASS_SetConfig(DWORD option, DWORD value);
DWORD BASS_GetConfig(DWORD option);
DWORD BASS_GetDevice();
BOOL BASS_GetDeviceInfo(DWORD device, BASS_DEVICEINFO *info);
]]

local bass = ffi.load("Lib/bass.dll")

local Bass = {}

function Bass:init(device)
    local device = device or 0
    if bass.BASS_Init(device or -1, 44100, 0, nil, nil) == 0 then
        print("BASS_Init error: " .. bass.BASS_ErrorGetCode())
    end
end

function Bass:ReInit()
    local device = bass.BASS_GetDevice()
    local flags = 129
    if device == -1 then
        device = 1
        flags = 0
    end
    bass.BASS_Init(device, 44100, flags, nil, nil)
end

function Bass:Free()
    bass.BASS_Free()
end

function Bass:SampleCreate(length, freq, chans, max, flags)
    local length = length or 0
    local freq = freq or 44100
    local chans = chans or 2
    local max = max or 3
    local flags = flags or 0
    local sample = bass.BASS_SampleCreate(length, freq, chans, max, flags)
    if sample == nil then
        print("BASS_SampleCreate error: " .. bass.BASS_ErrorGetCode())
    end
    return sample
end

function Bass:SampleGetInfo(handle)
    local info = ffi.new("BASS_SAMPLE")
    if bass.BASS_SampleGetInfo(handle, info) == 0 then
        print("BASS_SampleGetInfo error: " .. bass.BASS_ErrorGetCode())
    end
    return info
end

function Bass:SampleGetData(handle)
    local buffer = ffi.new("BYTE[?]", bass.BASS_SampleGetInfo(handle).length)
    if bass.BASS_SampleGetData(handle, buffer) == 0 then
        print("BASS_SampleGetData error: " .. bass.BASS_ErrorGetCode())
    end
    return buffer
end

function Bass:SampleSetData(handle, buffer)
    if bass.BASS_SampleSetData(handle, buffer) == 0 then
        print("BASS_SampleSetData error: " .. bass.BASS_ErrorGetCode())
    end
end

function Bass:ChannelSeconds2Bytes(handle, pos)
    return bass.BASS_ChannelSeconds2Bytes(handle, pos)
end 

function Bass:ChannelGetPosition(handle, mode)
    return bass.BASS_ChannelGetPosition(handle, mode)
end

return Bass