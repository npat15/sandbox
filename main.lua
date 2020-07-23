-- require push to resize window appropriately
push = require 'push'

-- Include Simple Tiled Implementation into project
local sti = require "sti"

-- push parameters
WINDOW_WIDTH, WINDOW_HEIGHT = 480, 480
GAME_WIDTH, GAME_HEIGHT = 480, 480

function love.load()
    -- Load map file
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})

    love.window.setTitle("Sandbox")

    map = sti("map.lua")
end

function love.update(dt)
    -- Update world
    map:update(dt)
end

function love.draw()
    push:start()

    -- Draw world
    map:draw()

    push:finish()
end

-- if key is pressed, window closes
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end