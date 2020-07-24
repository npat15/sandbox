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

    -- SPRITE STUFF
    local layer = map:addCustomLayer("Sprites", 2)

    local player
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            player = object
            break
        end
    end

    sprite = love.graphics.newImage("tiles/gfx/character.png")
    character = love.graphics.newQuad(0, 0, 16, 32, sprite:getWidth(), sprite:getHeight())

    layer.player = {
        sprite = sprite,
        x      = player.x,
        y      = player.y,
        ox     = sprite:getWidth() / 2,
        oy     = sprite:getHeight() / 1.35
    }

    --[[
    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
            self.player.sprite,
            math.floor(self.player.x),
            math.floor(self.player.y),
            0,
            1,
            1,
            self.player.ox,
            self.player.oy
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end
    ]]--

    map:removeLayer("Game Objects")

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
