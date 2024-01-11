local ffi = require("ffi")

ffi.cdef[[
typedef struct SDL_Window SDL_Window;
typedef struct SDL_Renderer SDL_Renderer;
typedef struct SDL_Texture SDL_Texture;
typedef struct SDL_Surface SDL_Surface;
typedef struct SDL_PixelFormat SDL_PixelFormat;
typedef struct SDL_Palette SDL_Palette;
typedef struct SDL_RWops SDL_RWops;
typedef struct SDL_Rect SDL_Rect;

// functions for window creation
SDL_Window* SDL_CreateWindow(const char* title, int x, int y, int w, int h, unsigned int flags);
void SDL_DestroyWindow(SDL_Window* window);
SDL_Renderer* SDL_CreateRenderer(SDL_Window* window, int index, unsigned int flags);
void SDL_DestroyRenderer(SDL_Renderer* renderer);
SDL_Texture* SDL_CreateTexture(SDL_Renderer* renderer, unsigned int format, int access, int w, int h);
void SDL_DestroyTexture(SDL_Texture* texture);
SDL_Surface* SDL_CreateRGBSurface(unsigned int flags, int width, int height, int depth, unsigned int Rmask, unsigned int Gmask, unsigned int Bmask, unsigned int Amask);

// functions for closing
void SDL_Quit();
int SDL_QuitRequested();

// functions for delay
void SDL_Delay(unsigned int ms);
unsigned int SDL_GetTicks();

// time
typedef unsigned long long SDL_Time;
SDL_Time SDL_GetTime();

// functions for getting window size
void SDL_GetWindowSize(SDL_Window* window, int* w, int* h);

// functions for getting renderer output size
void SDL_GetRendererOutputSize(SDL_Renderer* renderer, int* w, int* h);

// functions for getting renderer info
typedef struct SDL_RendererInfo {
    const char* name;
    unsigned int flags;
    unsigned int num_texture_formats;
    unsigned int texture_formats[16];
    int max_texture_width;
    int max_texture_height;
} SDL_RendererInfo;
void SDL_GetRendererInfo(SDL_Renderer* renderer, SDL_RendererInfo* info);

// event types
typedef enum SDL_EventType {
    SDL_FIRSTEVENT = 0,
    SDL_QUIT = 0x100,
    SDL_LASTEVENT = 0x1FF
} SDL_EventType;

// event
typedef struct SDL_CommonEvent {
    unsigned int type;
    unsigned int timestamp;
} SDL_CommonEvent;

typedef struct SDL_WindowEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    unsigned char event;
    unsigned char padding1;
    unsigned char padding2;
    unsigned char padding3;
    int data1;
    int data2;
} SDL_WindowEvent;

typedef struct SDL_KeyboardEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    unsigned char state;
    unsigned char repeat;
    unsigned char padding2;
    unsigned char padding3;
    unsigned char keysym[8];
} SDL_KeyboardEvent;

typedef struct SDL_TextEditingEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    char text[32];
    int start;
    int length;
} SDL_TextEditingEvent;

typedef struct SDL_TextInputEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    char text[32];
} SDL_TextInputEvent;

typedef struct SDL_MouseMotionEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    unsigned int which;
    unsigned int state;
    int x;
    int y;
    int xrel;
    int yrel;
} SDL_MouseMotionEvent;

typedef struct SDL_MouseButtonEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    unsigned int which;
    unsigned char button;
    unsigned char state;
    unsigned char clicks;
    unsigned char padding1;
    int x;
    int y;
} SDL_MouseButtonEvent;

typedef struct SDL_MouseWheelEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int windowID;
    unsigned int which;
    int x;
    int y;
    unsigned int direction;
} SDL_MouseWheelEvent;

typedef struct SDL_JoyAxisEvent {
    unsigned int type;
    unsigned int timestamp;
    unsigned int which;
    unsigned char axis;
    unsigned char padding1;
    unsigned char padding2;
    unsigned char padding3;
    int value;
    unsigned short padding4;
} SDL_JoyAxisEvent;

// SDL_Event
typedef union SDL_Event {
    unsigned int type;
    SDL_CommonEvent common;
    SDL_WindowEvent window;
    SDL_KeyboardEvent key;
    SDL_TextEditingEvent edit;
    SDL_TextInputEvent text;
    SDL_MouseMotionEvent motion;
    SDL_MouseButtonEvent button;
    SDL_MouseWheelEvent wheel;
    SDL_JoyAxisEvent jaxis;
} SDL_Event;

// poll event
int SDL_PollEvent(SDL_Event* event);
// get all events
int SDL_PeepEvents(SDL_Event* events, int numevents, int action, unsigned int minType, unsigned int maxType);
// push event
int SDL_PushEvent(SDL_Event* event);
// flush events
void SDL_FlushEvent(unsigned int type);

// Uint64
typedef unsigned long long Uint64;

// get performance counter
Uint64 SDL_GetPerformanceCounter(void);
// get performance frequency
Uint64 SDL_GetPerformanceFrequency(void);

// SDL_Rect
typedef struct SDL_Rect {
    int x, y;
    int w, h;
} SDL_Rect;

// fill render rect
int SDL_RenderFillRect(SDL_Renderer* renderer, SDL_Rect* rect);
int SDL_RenderDrawRect(SDL_Renderer* renderer, SDL_Rect* rect);

// render clear
int SDL_RenderClear(SDL_Renderer* renderer);

// SDL_Color
typedef struct SDL_Color {
    unsigned char r;
    unsigned char g;
    unsigned char b;
    unsigned char a;
} SDL_Color;
int SDL_SetRenderDrawColor(SDL_Renderer* renderer, unsigned char r, unsigned char g, unsigned char b, unsigned char a);

// SDL_RenderPresent
void SDL_RenderPresent(SDL_Renderer* renderer);
]]

local SDL = ffi.load("SDL2.dll")

local SDL2 = {}

function SDL2.CreateWindow(title, x, y, w, h, flags)
    return SDL.SDL_CreateWindow(title, x, y, w, h, flags)
end

function SDL2.DestroyWindow(window)
    SDL.SDL_DestroyWindow(window)
end

function SDL2.CreateRenderer(window, index, flags)
    return SDL.SDL_CreateRenderer(window, index, flags)
end

function SDL2.DestroyRenderer(renderer)
    SDL.SDL_DestroyRenderer(renderer)
end

function SDL2.CreateTexture(renderer, format, access, w, h)
    return SDL.SDL_CreateTexture(renderer, format, access, w, h)
end

function SDL2.DestroyTexture(texture)
    SDL.SDL_DestroyTexture(texture)
end

function SDL2.CreateRGBSurface(flags, width, height, depth, Rmask, Gmask, Bmask, Amask)
    return SDL.SDL_CreateRGBSurface(flags, width, height, depth, Rmask, Gmask, Bmask, Amask)
end

-- close functions
function SDL2.Quit()
    SDL.SDL_Quit()
end

-- delay
function SDL2.Delay(ms)
    SDL.SDL_Delay(ms)
end

-- get ticks
function SDL2.GetTicks()
    return SDL.SDL_GetTicks()
end

-- time
function SDL2.GetTime()
    return SDL.SDL_GetTime()
end

-- get performance counter
function SDL2.GetPerformanceCounter()
    return SDL.SDL_GetPerformanceCounter()
end

-- get performance frequency
function SDL2.GetPerformanceFrequency()
    return SDL.SDL_GetPerformanceFrequency()
end

-- get window size
function SDL2.GetWindowSize(window)
    local w = ffi.new("int[1]")
    local h = ffi.new("int[1]")
    SDL.SDL_GetWindowSize(window, w, h)
    return w[0], h[0]
end

-- get renderer output size
function SDL2.GetRendererOutputSize(renderer)
    local w = ffi.new("int[1]")
    local h = ffi.new("int[1]")
    SDL.SDL_GetRendererOutputSize(renderer, w, h)
    return w[0], h[0]
end

-- get renderer info
function SDL2.GetRendererInfo(renderer)
    local info = ffi.new("SDL_RendererInfo[1]")
    SDL.SDL_GetRendererInfo(renderer, info)
    return info[0]
end

-- event types
SDL2.EventType = {
    FirstEvent = 0,
    Quit = 0x100,
    LastEvent = 0x1FF
}

-- event
SDL2.CommonEvent = ffi.typeof("SDL_CommonEvent")
SDL2.WindowEvent = ffi.typeof("SDL_WindowEvent")
SDL2.KeyboardEvent = ffi.typeof("SDL_KeyboardEvent")
SDL2.TextEditingEvent = ffi.typeof("SDL_TextEditingEvent")
SDL2.TextInputEvent = ffi.typeof("SDL_TextInputEvent")
SDL2.MouseMotionEvent = ffi.typeof("SDL_MouseMotionEvent")
SDL2.MouseButtonEvent = ffi.typeof("SDL_MouseButtonEvent")
SDL2.MouseWheelEvent = ffi.typeof("SDL_MouseWheelEvent")
SDL2.JoyAxisEvent = ffi.typeof("SDL_JoyAxisEvent")

SDL2.Event = ffi.typeof("SDL_Event")

function SDL2.PollEvent(event)
    return SDL.SDL_PollEvent(event)
end

-- graphics
function SDL2.RenderFillRect(renderer, rect)
    return SDL.SDL_RenderFillRect(renderer, rect)
end

function SDL2.RenderDrawRect(renderer, rect)
    return SDL.SDL_RenderDrawRect(renderer, rect)
end

function SDL2.RenderClear(renderer)
    return SDL.SDL_RenderClear(renderer)
end

function SDL2.SetRenderDrawColor(renderer, r, g, b, a)
    return SDL.SDL_SetRenderDrawColor(renderer, r, g, b, a)
end

function SDL2.RenderPresent(renderer)
    return SDL.SDL_RenderPresent(renderer)
end

-- SDL_Color

SDL2.Color = ffi.typeof("SDL_Color")

-- SDL_Rect
SDL2.Rect = ffi.typeof("SDL_Rect")

return SDL2