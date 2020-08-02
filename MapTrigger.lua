MapTrigger = Class{}

function MapTrigger:init(tile_x0, tile_y0, future_index)
    self.x0 = tile_x0
    self.y0 = tile_y0
    self.future_index = future_index
end

function MapTrigger:enter()
    g_map_index = self.future_index
    make_map(g_map_index)
    sounds['door']:play()
end

