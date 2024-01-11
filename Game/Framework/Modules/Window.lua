Game.Window = {}
local SDL2 = require("Game.Framework.Backend.SDL2")
local Windows = require("Game.Framework.Backend.Windows")

local delta = 0
local lastTime = 0
local currentTime = 0
-- use os to get the times LMFAO

Game.Window._window = nil
Game.Window._renderer = nil

function Game.Window.CreateWindow(title, x, y, w, h, flags)
    local desktopWidth, desktopHeight = Windows.GetDesktopDimensions()
    local x = x or desktopWidth / 2 - w / 2
    local y = y or desktopHeight / 2 - h / 2
    local flags = flags or 0
    Game.Window._window = SDL2.CreateWindow(title, x, y, w, h, flags)
    
    -- create renderer
    Game.Window._renderer = SDL2.CreateRenderer(Game.Window._window, -1, 0)
    return Game.Window._window
end

function Game.Window.DestroyWindow(window)
    SDL2.DestroyWindow(window)
end

function Game.Window.CreateRenderer(window, index, flags)
    return SDL2.CreateRenderer(window, index, flags)
end

-- should quit?
Game.Window.ShouldQuit = false

-- close functions
function Game.Window.Quit()
    print("Quitting...")
    Window.ShouldQuit = true
    SDL2.Quit()
end

-- delay
function Game.Window.Delay(ms)
    SDL2.Delay(ms)
end

-- get ticks
function Game.Window.GetTicks()
    return SDL2.GetTicks()
end

-- get window size
function Game.Window.GetWindowSize(window)
    return SDL2.GetWindowSize(window)
end

-- get renderer output size
function Game.Window.GetRendererOutputSize(renderer)
    return SDL2.GetRendererOutputSize(renderer)
end

-- renderer functions
function Game.Window.RenderClear(renderer)
    SDL2.RenderClear(renderer)
end

function Game.Window.GetTime()
    return SDL2.GetTime()
end

function Game.Window.Update()
    -- use ticks
    currentTime = Game.Window.GetTicks()
    delta = (currentTime - lastTime)/1000
    lastTime = currentTime
    SDL2.PumpEvents()
    Game.Keyboard._keystate = SDL2.GetKeyboardState()
end

function Game.Window.GetDelta()
    return delta
end
