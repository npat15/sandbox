-- Idea: Use sti to draw layer onto mapstack if triggered 
-- TODO: make more efficient by removing layer if exited

require 'Player'
--require 'states/PlayState'

Trigger = Class{}

function Trigger:init(layers_list, tile)
    self.layers = layers_list
    layer_placeholder = toDraw
end

function Trigger:enter()
    toDraw = self.layers

    map:bump_removeLayer('collidable', world)
    map.layers['collidable'].properties['collidable'] = false
    map.layers['ShedCol'].properties['collidable'] = true

    -- commit collidable layers
    map:bump_init(world)
end

function Trigger:exit()
    toDraw = layer_placeholder
 
    --print(map.layers['ShedCol'].properties['collidable'])
    map:bump_removeLayer('ShedCol', world)
    map.layers['collidable'].properties['collidable'] = true
    map.layers['ShedCol'].properties['collidable'] = false

    -- commit collidable layers
    map:bump_init(world)
end