package.path = package.path .. ";./?.lua;./?/init.lua;./?/?.lua;./?/?.init.lua"
package.path = package.path .. ";./Game/?.lua;./Game/?/init.lua;./Game/?/?.lua;./Game/?/?.init.lua"

-- cpath
package.cpath = package.cpath .. ";./?.dll;./?/?.dll;./?/?.so;./?/?.dylib"
package.cpath = package.cpath .. ";./Game/?.dll;./Game/?/?.dll;./Game/?/?.so;./Game/?/?.dylib"

require("Game.Framework")

local player = {
    x = 0,
    y = 0
}

local noteData = {
    {1000, 1, 10000}, -- time, lane, y
    {2000, 2, 10000},
    {3000, 3, 10000},
    {4000, 4, 10000},
}

function Game:load()
    Game.Window.CreateWindow("Game", nil, nil, 640, 480, 0)
    json = require("Game.Libraries.json")

    musicTime = 0
end

function Game:update(dt)    
    musicTime = musicTime + dt * 1000
    if Game.Keyboard.IsKeyDown("W") then
        player.y = player.y - 100 * dt
    elseif Game.Keyboard.IsKeyDown("S") then
        player.y = player.y + 100 * dt
    end

    if Game.Keyboard.IsKeyDown("A") then
        player.x = player.x - 100 * dt
    elseif Game.Keyboard.IsKeyDown("D") then
        player.x = player.x + 100 * dt
    end

    for i, note in ipairs(noteData) do
        if note[1]+1 <= Game.Window.GetTicks() then
        else
            -- update 3 (y)
            note[3] = note[1] - musicTime
        end
    end
end
local inputs = {
    ["D"] = 1,
    ["F"] = 2,
    ["J"] = 3,
    ["K"] = 4
}
function Game:keypressed(key)
    for i, note in ipairs(noteData) do
        if note[2] == inputs[key] and note[1] - 250 <= musicTime and note[1] + 250 >= musicTime then
            table.remove(noteData, i)
            break
        end
    end
end

function Game:keyreleased(key)
end

function Game:draw()
    Game._sdl2.SetRenderDrawColor(Game.Window._renderer, 255, 255, 255, 255)
    --Game.Graphics.DrawRect("fill", player.x, player.y, 100, 100)

    for i, note in ipairs(noteData) do -- 15x15
        Game._sdl2.SetRenderDrawColor(Game.Window._renderer, 255, 0, 0, 255)
        Game.Graphics.DrawRect("fill", (note[2] - 1) * 30 + 265, note[3]*0.5, 15, 15)
    end
end

Game:run()