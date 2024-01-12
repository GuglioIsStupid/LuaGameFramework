local ffi = require("ffi")

Game = {}

local path = (...) .. "."

Game._sdl2 = require(path .. "Backend.SDL2")
Game._sdl_mixer = require(path .. "Backend.SDLMixer")
Game._mpg123 = require(path .. "Backend.mpg123")
require(path .. "Modules.Window")
require(path .. "Modules.Graphics")
require(path .. "Modules.Keyboard")

function Game:run()
    if self.load then self:load() end

    -- events
    local event = ffi.new("SDL_Event")

    -- main loop
    while not self.Window.ShouldQuit do
        -- poll events
        while self._sdl2.PollEvent(event) ~= 0 do
            if event.type == self._sdl2.EventType.Quit then
                if self.quit then self:quit() end
                self.Window.Quit()
            elseif event.type == self._sdl2.EventType.KeyDown then
                local keyname = self.Keyboard.GetKeyName(event.key.keysym.sym)
                self.Keyboard._keys[keyname].pressed = true
                self.Keyboard._keys[keyname].held = true
                if self.keypressed then self:keypressed(keyname) end
            elseif event.type == self._sdl2.EventType.KeyUp then
                local keyname = self.Keyboard.GetKeyName(event.key.keysym.sym)
                self.Keyboard._keys[keyname].pressed = false
                self.Keyboard._keys[keyname].held = false
                if self.keyreleased then self:keyreleased(keyname) end
            end
                
        end

        -- update
        self.Window.Update()
        local dt = self.Window.GetDelta()
        if self.update then self:update(dt) end

        -- draw
        self._sdl2.SetRenderDrawColor(self.Window._renderer, self.Graphics._bgColor[1], self.Graphics._bgColor[2], self.Graphics._bgColor[3], self.Graphics._bgColor[4])
        self.Window.RenderClear(self.Window._renderer)
        if self.draw then self:draw() end
        self._sdl2.RenderPresent(self.Window._renderer)
        -- delay
        self.Window.Delay(1)

        self.Keyboard.Update()
    end
end

function Game:errorhandler(msg)

end

function Game:quit()
    -- override this
end