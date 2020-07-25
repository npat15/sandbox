Player = Class{}

local WALKING_SPEED = 40
local ANIMATION_SPEED = 0.1

function Player:init(name, U0, V0, U1, V1, charSheet)
    self.name = name
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1
    --self.layer = spriteLayer

    -- find player within object layer
    local player_obj
    for k, object in pairs(map.objects) do
        if object.name == self.name then
            player_obj = object
            break
        end
    end

    self.player_obj = player_obj
    --self.player_obj.x = math.floor(self.player_obj.x)
    --self.player_obj.y = math.floor(self.player_obj.y)
    self.x = self.player_obj.x
    self.y = self.player_obj.y

    --[[
    self.layer.player = {
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
    --]]

    -- start timer
    self.timer = 0

    -- initialize these here so there's no nil error in update
    future_x = self.player_obj.x
    future_y = self.player_obj.y

    -- start player facing downward
    self.charSheet = love.graphics.newImage(charSheet)
    self.currentFrame = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

    -- load animation frames
    -- hardcoded frames for now
    FRAME_WIDTH = 16
    FRAME_HEIGHT = 32
    
    SHEET_WIDTH = self.charSheet:getWidth()
    SHEET_HEIGHT = self.charSheet:getHeight()

    function loadFrames(start_y)
        frameTable = {}
        for i = 0, 3 do
            table.insert(frameTable, love.graphics.newQuad(i * FRAME_WIDTH, start_y, FRAME_WIDTH, FRAME_HEIGHT, SHEET_WIDTH, SHEET_HEIGHT))
        end
        return frameTable
    end

    self.downFrames = loadFrames(0)
    self.rightFrames = loadFrames(FRAME_HEIGHT)
    self.upFrames = loadFrames(2 * FRAME_HEIGHT)
    self.leftFrames = loadFrames(3 * FRAME_HEIGHT)
end

function Player:update(dt)
    self.timer = self.timer + dt

    -- pick current frame base on elapsed time
    function frameIndex()
        -- should this be local?
        -- could we use modulus instead?
        frame = math.ceil(self.timer / ANIMATION_SPEED)
        if frame > 4 then
            self.timer = 0
            frame = 1
        end

        return frame
    end
    
    -- Move player up
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        future_y = self.player_obj.y - WALKING_SPEED * dt
        self.currentFrame = self.upFrames[frameIndex()]
    -- Move player down
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        future_y = self.player_obj.y + WALKING_SPEED * dt
        self.currentFrame = self.downFrames[frameIndex()]
    -- Move player left
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        future_x = self.player_obj.x - WALKING_SPEED * dt
        self.currentFrame = self.leftFrames[frameIndex()]
    -- Move player right
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        future_x = self.player_obj.x + WALKING_SPEED * dt
        self.currentFrame = self.rightFrames[frameIndex()]
    end

    local actualX, actualY, collisions, len = world:check(self, future_x, future_y)

    if len == 0 then
        -- if no collision, let player move
        self.player_obj.x = future_x
        self.player_obj.y = future_y
        self.x = self.player_obj.x
        self.y = self.player_obj.y
        world:move(self, self.x, self.y)
    else
        -- if there's a collision, keep player in place
        self.player_obj.x = actualX
        self.player_obj.y = actualY
        self.x = self.player_obj.x
        self.y = self.player_obj.y
        world:move(self, self.x, self.y)
    end
end

function Player:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.currentFrame, self.player_obj.x, self.player_obj.y - 10)
end