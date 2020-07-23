-- require push to resize window appropriately
push = require 'push'

-- Include Simple Tiled Implementation into project
local sti = require "sti"

Class = require 'class'

-- import states
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'

-- push parameters
WINDOW_WIDTH, WINDOW_HEIGHT = 480, 480
GAME_WIDTH, GAME_HEIGHT = 480, 480

function love.load()
    -- Load map file
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})

    -- load fonts
    titleFont = love.graphics.newFont('8-BIT WONDER.TTF', 50)
    love.graphics.setFont(titleFont)

    love.window.setTitle("Sandbox")

    -- build state machine
    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('title')

    -- build map
    map = sti("map.lua")

    -- CITE
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    -- update game state and reinit keysPressed
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- render game state
    gStateMachine:render()

    push:finish()
end

function love.keypressed(key)
    -- CITE
    love.keyboard.keysPressed[key] = true

    -- if esc key is pressed, window closes
    if key == 'escape' then
        love.event.quit()
    end
end

-- CITE
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
