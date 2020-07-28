NPC = Class{}

local WALK_TIME = 0.25
local WALKING_SPEED = 40
local ANIMATION_SPEED = 0.1

-- SAME AS PLAYER EXCEPT WALK VAR
function NPC:init(name, U0, V0, U1, V1, charSheet)
    self.name = name
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1

    -- make var?
    self.direction = 1

    -- DIFF FROM PLAYER
    self.walk = false 

    -- find NPC within object layer
    local obj
    for k, object in pairs(map.objects) do
        if object.name == self.name then
            obj = object
            break
        end
    end

    self.obj = obj
    self.x = self.obj.x
    self.y = self.obj.y

    -- start timer
    self.timer = 0
    self.frame_timer = 0

    -- start NPC facing downward
    self.charSheet = love.graphics.newImage(charSheet)
    self.currentFrame = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

    -- load animation frames
    -- hardcoded frames for now
    local FRAME_WIDTH = 16
    local FRAME_HEIGHT = 32
    
    local SHEET_WIDTH = self.charSheet:getWidth()
    local SHEET_HEIGHT = self.charSheet:getHeight()

    function loadFrames(start_y)
        frameTable = {}
        for i = 0, 3 do
            table.insert(frameTable, love.graphics.newQuad(i * FRAME_WIDTH, start_y, FRAME_WIDTH, FRAME_HEIGHT, SHEET_WIDTH, SHEET_HEIGHT))
        end
        return frameTable
    end

    -- store all frames in one table for easy access
    self.frames = {
        loadFrames(0), 
        loadFrames(FRAME_HEIGHT), 
        loadFrames(2 * FRAME_HEIGHT), 
        loadFrames(3 * FRAME_HEIGHT)
        }
end

function NPC:update(dt)
    local function frameIndex()
        -- could we use modulus instead?
        frame = math.ceil(self.frame_timer / ANIMATION_SPEED)
        if frame > 4 then
            self.frame_timer = 0
            frame = 1
        end
        return frame
    end

    self.timer = self.timer + dt
    self.frame_timer = self.frame_timer + dt

    -- initialize these here so there's no nil error in update
    future_x = self.obj.x
    future_y = self.obj.y

    -- some movemt every 3 secs
    if self.timer >= 3 then
        self.direction = math.random(4)
        self.timer = 0

        if self.direction < 5 then
            self.walk = true
        else 
            self.walk = false
        end
    end

    if self.walk then
        if self.direction == 1 and self.timer <= WALK_TIME then
            future_y = self.obj.y + WALKING_SPEED * dt
        elseif self.direction == 2 and self.timer <= WALK_TIME then
            future_x = self.obj.x + WALKING_SPEED * dt
        elseif self.direction == 3 and self.timer <= WALK_TIME then
            future_y = self.obj.y - WALKING_SPEED * dt
        elseif self.direction == 4 and self.timer <= WALK_TIME then
            future_x = self.obj.x - WALKING_SPEED * dt 
        end
    end

    -- determine animation 
    if future_x == self.obj.x and future_y == self.obj.y then
        self.currentFrame = self.frames[self.direction][1]
    else
        self.currentFrame = self.frames[self.direction][frameIndex()]
    end

    -- look for collision 
    local actualX, actualY, collisions, len = world:check(self, future_x, future_y)

    if len == 0 then
        -- if no collision, let player move
        self.obj.x = future_x
        self.obj.y = future_y
        self.x = self.obj.x
        self.y = self.obj.y
        world:move(self, self.x, self.y)
    else
        -- keep player in place
        self.obj.x = actualX
        self.obj.y = actualY
        self.x = self.obj.x
        self.y = self.obj.y
        self.currentFrame = self.frames[self.direction][1]
        world:move(self, self.x, self.y)
    end
end

-- SAME AS PLAYER 
function NPC:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.currentFrame, self.obj.x, self.obj.y - 16)
end 