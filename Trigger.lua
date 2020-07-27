Trigger = Class{}

function Trigger:init(layers_list, tile_x, tile_y)
    self.x = tile_x
    self.y = tile_y
    self.layers = layers_list
    self.layer_placeholder = toDraw
end

function Trigger:enter()
    toDraw = self.layers

    map:bump_removeLayer('collidable', world)
    map:bump_removeLayer('test_trig', world)
    map.layers['collidable'].properties['collidable'] = false
    map.layers['test_trig'].properties['collidable'] = false
    map.layers['ShedCol'].properties['collidable'] = true

    -- commit collidable layers
    map:bump_init(world)

    player.player_obj.y = player.player_obj.y - 4
end

function Trigger:exit()
    toDraw = self.layer_placeholder
 
    --print(map.layers['ShedCol'].properties['collidable'])
    map:bump_removeLayer('ShedCol', world)
    map.layers['collidable'].properties['collidable'] = true
    map.layers['test_trig'].properties['collidable'] = true
    map.layers['ShedCol'].properties['collidable'] = false

    -- commit collidable layers
    map:bump_init(world)
end