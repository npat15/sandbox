-- Idea: Use sti to draw layer onto mapstack if triggered 
-- TODO: make more efficient by removing layer if exited

require 'Player'
--require 'states/PlayState'

Trigger = Class{}

function Trigger:init(layers_list, tile)
    self.layers = layers_list
    self.layer_placeholder = {}
end

function Trigger:enter()
    self.layer_placeholder = toDraw
    toDraw = self.layers

    map.layers['collidable'].properties['collidable'] = false
    map.layers['ShedCol'].properties['collidable'] = true

    -- commit collidable layers
    map:bump_init(world)
end

function Trigger:exit()

    map:bump_removeLayer('ShedCol', world)

    toDraw = self.layer_placeholder
    self.layer_placeholder = {}
 
    --print(map.layers['ShedCol'].properties['collidable'])
    map.layers['collidable'].properties['collidable'] = true
    map.layers['ShedCol'].properties['collidable'] = false

    -- commit collidable layers
    map:bump_init(world)
end