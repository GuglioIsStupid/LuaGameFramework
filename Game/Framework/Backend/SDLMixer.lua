local ffi = require("ffi")

ffi.cdef [[
// all Mix funcs
typedef struct Mix_Chunk {
    int allocated;
    Uint8 *abuf;
    Uint32 alen;
    Uint8 volume;
} Mix_Chunk;

typedef struct _Mix_Music Mix_Music;

typedef enum {
    MIX_INIT_FLAC = 0x00000001,
    MIX_INIT_MOD = 0x00000002,
    MIX_INIT_MODPLUG = 0x00000004,
    MIX_INIT_MP3 = 0x00000008,
    MIX_INIT_OGG = 0x00000010,
    MIX_INIT_FLUIDSYNTH = 0x00000020
} MIX_InitFlags;


typedef enum {
    MIX_PLAYCHANNEL,
    MIX_PLAYALL,
    MIX_PLAYING,
    MIX_LOOP,
    MIX_PAUSE,
    MIX_RESUME,
    MIX_REWIND,
    MIX_STOP,
    MIX_HALT,
    MIX_EXPIRED,
    MIX_FADINGOUT
} Mix_Command;

//Mix_MusicType
typedef enum {
    MUS_NONE,
    MUS_CMD,
    MUS_WAV,
    MUS_MOD,
    MUS_MID,
    MUS_OGG,
    MUS_MP3,
    MUS_MP3_MAD,
    MUS_FLAC,
    MUS_MODPLUG
} Mix_MusicType;

//Mix_EffectDone_t
typedef void (*Mix_EffectDone_t)(int chan, void *udata);
//Mix_EffectDone_t
typedef void (*Mix_EffectFunc_t)(int chan, void *stream, int len, void *udata);

//Sint16
typedef short Sint16;

// MixFading
typedef enum {
    MIX_NO_FADING,
    MIX_FADING_OUT,
    MIX_FADING_IN
} Mix_Fading;

// funcs
int Mix_OpenAudio(int frequency, Uint16 format, int channels, int chunksize);
int Mix_Init(int flags);
int Mix_OpenAudioDevice(int frequency, Uint16 format, int channels, int chunksize, const char *device, int allowed_changes);
void Mix_CloseAudio();
void Mix_Quit();
int Mix_AllocateChannels(int numchans);
int Mix_QuerySpec(int *frequency, Uint16 *format, int *channels);
const char * Mix_GetError();
int Mix_GetNumChunkDecoders();
const char * Mix_GetChunkDecoder(int index);
int Mix_GetNumMusicDecoders();
const char * Mix_GetMusicDecoder(int index);
int Mix_GetMusicType(const Mix_Music *music);
Mix_Music * Mix_LoadMUS(const char *file);
Mix_Music * Mix_LoadMUS_RW(SDL_RWops *rw);
Mix_Music * Mix_LoadMUSType_RW(SDL_RWops *rw, Mix_MusicType type, int freesrc);
Mix_Chunk * Mix_LoadWAV(const char *file);
Mix_Chunk * Mix_LoadWAV_RW(SDL_RWops *src, int freesrc);
Mix_Chunk * Mix_LoadWAV_RW(SDL_RWops *src, int freesrc);
Mix_Chunk * Mix_QuickLoad_WAV(Uint8 *mem);
Mix_Chunk * Mix_QuickLoad_RAW(Uint8 *mem, Uint32 len);

int Mix_FreeChunk(Mix_Chunk *chunk);
int Mix_FreeMusic(Mix_Music *music);
int Mix_GetMusicFadingSpeed();
void Mix_SetMusicFadingSpeed(int speed);
int Mix_GetMusicType(const Mix_Music *music);
void Mix_SetPostMix(void (*mix_func)(void *udata, Uint8 *stream, int len), void *arg);
void Mix_HookMusic(void (*mix_func)(void *udata, Uint8 *stream, int len), void *arg);
void Mix_HookMusicFinished(void (*music_finished)(void));
void Mix_GetMusicHookData(void **udata, void (**hook_func)(void *udata, Uint8 *stream, int len));
void Mix_ChannelFinished(void (*channel_finished)(int channel));
int Mix_RegisterEffect(int chan, Mix_EffectFunc_t f, Mix_EffectDone_t d, void *arg);
int Mix_UnregisterEffect(int channel, Mix_EffectFunc_t f);
int Mix_UnregisterAllEffects(int channel);
int Mix_SetPanning(int channel, Uint8 left, Uint8 right);
int Mix_SetPosition(int channel, Sint16 angle, Uint8 distance);
int Mix_SetDistance(int channel, Uint8 distance);
int Mix_SetReverseStereo(int channel, int flip);
int Mix_ReserveChannels(int num);
int Mix_GroupChannel(int which, int tag);
int Mix_GroupChannels(int from, int to, int tag);
int Mix_GroupAvailable(int tag);
int Mix_GroupCount(int tag);
int Mix_GroupOldest(int tag);
int Mix_GroupNewer(int tag);
int Mix_PlayChannel(int channel, Mix_Chunk *chunk, int loops);
int Mix_PlayChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ticks);
int Mix_PlayMusic(Mix_Music *music, int loops);
int Mix_FadeInMusic(Mix_Music *music, int loops, int ms);
int Mix_FadeInMusicPos(Mix_Music *music, int loops, int ms, double position);
int Mix_FadeInChannelTimed(int channel, Mix_Chunk *chunk, int loops, int ms, int ticks);
int Mix_Volume(int channel, int volume);
int Mix_VolumeChunk(Mix_Chunk *chunk, int volume);
int Mix_VolumeMusic(int volume);
int Mix_HaltChannel(int channel);
int Mix_HaltGroup(int tag);
int Mix_HaltMusic();
int Mix_ExpireChannel(int channel, int ticks);
int Mix_FadeOutChannel(int which, int ms);
int Mix_FadeOutGroup(int tag, int ms);
int Mix_FadeOutMusic(int ms);
Mix_Fading Mix_FadingMusic();
Mix_Fading Mix_FadingChannel(int which);
void Mix_Pause(int channel);
void Mix_Resume(int channel);
int Mix_Paused(int channel);
void Mix_PauseMusic();
void Mix_ResumeMusic();
void Mix_RewindMusic();
int Mix_PausedMusic();
int Mix_SetMusicPosition(double position);
int Mix_Playing(int channel);
int Mix_PlayingMusic();
int Mix_SetMusicCMD(const char *command);
int Mix_SetSynchroValue(int value);

//Mix_GetError
const char * Mix_GetError();
]]

local sdlmixer = ffi.load("Lib/SDL2_mixer.dll")

local Mixer = {}

function Mixer.Init(flags)
    local flags = flags or 0
    if sdlmixer.Mix_Init(flags) == 0 then
    end
end

function Mixer.quit()
    sdlmixer.Mix_Quit()
end

function Mixer.openAudio(frequency, format, channels, chunksize)
    local frequency = frequency or 44100
    local format = format or 32784
    local channels = channels or 2
    local chunksize = chunksize or 1024
    if sdlmixer.Mix_OpenAudio(frequency, format, channels, chunksize) == -1 then
    end
end

function Mixer.closeAudio()
    sdlmixer.Mix_CloseAudio()
end

function Mixer.allocateChannels(numchans)
    local numchans = numchans or 16
    return sdlmixer.Mix_AllocateChannels(numchans)
end

function Mixer.LoadWAV(file)
    local file = file or ""
    local chunk = sdlmixer.Mix_LoadWAV(file)
    return chunk
end

function Mixer.loadWAV_RW(src, freesrc)
    local src = src or nil
    local freesrc = freesrc or 0
    local chunk = sdlmixer.Mix_LoadWAV_RW(src, freesrc)
    return chunk
end

function Mixer.LoadMUS(file)
    local file = file or ""
    local music = sdlmixer.Mix_LoadMUS(file)
    print(music)
    return music
end

function Mixer.loadMUS_RW(src, freesrc)
    local src = src or nil
    local freesrc = freesrc or 0
    local music = sdlmixer.Mix_LoadMUS_RW(src, freesrc)
    return music
end

function Mixer.PlayChannel(channel, chunk, loops)
    local channel = channel or -1
    local chunk = chunk or nil
    local loops = loops or 0
    print(channel, chunk, loops)
    return sdlmixer.Mix_PlayChannel(channel, chunk, loops)
end

function Mixer.playChannelTimed(channel, chunk, loops, ticks)
    local channel = channel or -1
    local chunk = chunk or nil
    local loops = loops or 0
    local ticks = ticks or -1
    return sdlmixer.Mix_PlayChannelTimed(channel, chunk, loops, ticks)
end

function Mixer.PlayMusic(music, loops)
    local music = music or nil
    local loops = loops or 0
    return sdlmixer.Mix_PlayMusic(music, loops)
end

function Mixer.playMusicPos(music, loops, position)
    local music = music or nil
    local loops = loops or 0
    local position = position or 0
    return sdlmixer.Mix_PlayMusicPos(music, loops, position)
end

function Mixer.fadeInMusic(music, loops, ms)
    local music = music or nil
    local loops = loops or 0
    local ms = ms or 0
    return sdlmixer.Mix_FadeInMusic(music, loops, ms)
end

function Mixer.fadeInMusicPos(music, loops, ms, position)
    local music = music or nil
    local loops = loops or 0
    local ms = ms or 0
    local position = position or 0
    return sdlmixer.Mix_FadeInMusicPos(music, loops, ms, position)
end

function Mixer.fadeInChannelTimed(channel, chunk, loops, ms, ticks)
    local channel = channel or -1
    local chunk = chunk or nil
    local loops = loops or 0
    local ms = ms or 0
    local ticks = ticks or -1
    return sdlmixer.Mix_FadeInChannelTimed(channel, chunk, loops, ms, ticks)
end

return Mixer