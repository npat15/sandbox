Player = Class{}

local WALKING_SPEED = 40

function Player:init(name, U0, V0, U1, V1, charSheet)
    self.name = name
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1

    local player_obj
    for k, object in pairs(map.objects) do
        if object.name == self.name then
            player_obj = object
            break
        end
    end

    self.player_obj = player_obj

    --[[

    layer.player = {
        sprite = sprite,
        x      = player.x,
        y      = player.y,
        ox     = sprite:getWidth() / 2,
        oy     = sprite:getHeight() / 1.35
    }

    
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

    self.charSheet = love.graphics.newImage(charSheet)
    self.spriteQuad = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

end

function Player:update(dt)

    --[[
    local PLAYER_KEYS = {

        w = 'walk_up',
        a = 'walk_left',
        d = 'walk_right',
        s = 'walk_down',
    }

    local BINDINGS = {

        walk_up = function() self.player_obj.y = self.player_obj.y - WALKING_SPEED * dt end,
        walk_left = function() self.player_obj.x = self.player_obj.x - WALKING_SPEED * dt end,
        walk_right = function() self.player_obj.x = self.player_obj.x + WALKING_SPEED * dt end,
        walk_down = function()  self.player_obj.y = self.player_obj.y + WALKING_SPEED * dt end ,
    }

    function inputHandler(input, k)
        local action = BINDINGS[input]
        if action then  
            while love.keyboard.isDown(k) do
                action()  
            end
        end
    end

    function love.keypressed(k)
        local binding = PLAYER_KEYS[k]
        return inputHandler(binding, k)
    end
    --]]

    -- Move player up
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.player_obj.y = self.player_obj.y - WALKING_SPEED * dt
    -- Move player down
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.player_obj.y = self.player_obj.y + WALKING_SPEED * dt
    -- Move player left
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        self.player_obj.x = self.player_obj.x - WALKING_SPEED * dt
    -- Move player right
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        self.player_obj.x = self.player_obj.x + WALKING_SPEED * dt
    end
    
end

function Player:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.spriteQuad, self.player_obj.x, self.player_obj.y - 10)
end