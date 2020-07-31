Trigger = Class{}

function Trigger:init(layers_list, tile_x0, tile_y0, tile_x1, tile_y1, drawOn)
    self.x0 = tile_x0
    self.y0 = tile_y0
    self.x1 = tile_x1
    self.y1 = tile_y1

    self.layers = layers_list
    self.layer_placeholder = {}

    -- copy toDraw
    for k, layer in pairs(drawOn) do
        table.insert(self.layer_placeholder, layer)
    end
end

function Trigger:enter()
    map_toDraw = self.layers
    
    local px1, py1 = gMap:convertTileToPixel(self.x1, self.y1 - 2)
    world:update(player, px1, py1)
    player.object.x = px1
    player.object.y = py1

    sounds['door']:play()
end

function Trigger:exit()
    map_toDraw = self.layer_placeholder

    local px0, py0 = gMap:convertTileToPixel(self.x0, self.y0)
    world:update(player, px0, py0) 
    player.object.x = px0
    player.object.y = py0 + 16

    sounds['door']:play()
end