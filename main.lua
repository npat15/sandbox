-- require push to resize window appropriately
push = require 'push'

-- Include Simple Tiled Implementation into project
sti = require "sti"
bump = require 'bump'

Class = require 'class'
 
require 'Character'
require 'Trigger'

map_list = require 'maps'
g_map_index = 1

-- import states
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'

-- push parameters
WINDOW_WIDTH, WINDOW_HEIGHT = 480, 480
GAME_WIDTH, GAME_HEIGHT = 480, 480

function make_map(index)
    map_data = map_list[index]
    map_filename = map_data['filename']
    map_toDraw = map_data['toDraw']
    map_player = map_data['player']
    map_npcs = map_data['npcs']
    map_triggers = map_data['triggers']

    -- build map
    world = bump.newWorld()
    gMap = sti(map_filename, {"bump"})

    -- add collision layer to world
    gMap:bump_init(world)
end

function love.load()
    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {fullscreen = false})

    -- load fonts
    titleFont = love.graphics.newFont('8-BIT WONDER.TTF', 50)
    love.graphics.setFont(titleFont)

    love.window.setTitle("Sandbox")

    -- set up map
    make_map(g_map_index)

    -- CITE
    love.keyboard.keysPressed = {}

     -- build state machine
     gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
    }
    gStateMachine:change('title')
end

function love.update(dt)
    -- update game state and reinit keysPressed
    fps = love.timer.getFPS()
    --print(fps)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    -- render game state
    gStateMachine:render()
    --map:bump_draw(world)

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
