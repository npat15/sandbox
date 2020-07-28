Trigger = Class{}

function Trigger:init(layers_list, tile_x0, tile_y0, tile_x1, tile_y1)
    self.x0 = tile_x0
    self.y0 = tile_y0
    self.x1 = tile_x1
    self.y1 = tile_y1

    self.layers = layers_list
    self.layer_placeholder = {}

    -- copy toDraw
    for k, layer in pairs(toDraw) do
        table.insert(self.layer_placeholder, layer)
    end
end

function Trigger:enter()
    toDraw = self.layers
    
    local px1, py1 = map:convertTileToPixel(self.x1, self.y1 - 2)
    world:update(player, px1, py1)
    player.player_obj.x = px1
    player.player_obj.y = py1
end

function Trigger:exit()
    toDraw = self.layer_placeholder

    local px0, py0 = map:convertTileToPixel(self.x0, self.y0)
    world:update(player, px0, py0) 
    player.player_obj.x = px0
    player.player_obj.y = py0 + 16
end