Character = Class{}

local types = {'player', 'npc'}
local WALK_TIME = 0.25
local WALKING_SPEED = 40
local JOG_SPEED = 65
local ANIMATION_SPEED = 0.1

function Character:init(name, type, U0, V0, U1, V1, charSheet, moves) 
    -- early parameters
    self.name = name
    self.type = type
    self.U0 = U0
    self.V0 = V0
    self.U1 = U1
    self.V1 = V1
    self.direction = 1
    self.moves = moves
    self.timer = 0
    self.frameTimer = 0
 
    -- set draw wiggle room
    local offset
    if self.type == 'player' then
        offset = 10
    else
        offset = 16
    end

    self.offset = offset

    -- locate within map 
    local object
    for k, obj in pairs(map.objects) do
        if obj.name == self.name then
            object = obj
            break
        end
    end

    -- set up position
    self.object = object
    self.x = self.object.x
    self.y = self.object.y

    -- set start frame
    self.charSheet = love.graphics.newImage(charSheet)
    self.currentFrame = love.graphics.newQuad(U0, V0, U1, V1, self.charSheet:getWidth(), self.charSheet:getHeight())

    local frames
    if self.moves then
        -- load animation frames
        -- hardcoded frames for now
        local FRAME_WIDTH = 16
        local FRAME_HEIGHT = 32
        
        local SHEET_WIDTH = self.charSheet:getWidth()
        local SHEET_HEIGHT = self.charSheet:getHeight()

        local function loadFrames(start_y)
            frameTable = {}
            for i = 0, 3 do
                table.insert(frameTable, love.graphics.newQuad(i * FRAME_WIDTH, start_y, FRAME_WIDTH, FRAME_HEIGHT, SHEET_WIDTH, SHEET_HEIGHT))
            end
            return frameTable
        end

        -- store all frames in one table for easy access
        frames = {
            loadFrames(0), 
            loadFrames(FRAME_HEIGHT), 
            loadFrames(2 * FRAME_HEIGHT), 
            loadFrames(3 * FRAME_HEIGHT)
        }
    else
        frames = {'flag'}
    end

    self.frames = frames
end

function Character:update(dt)
    -- START HELPERS
    -- pick current frame base on elapsed time
    local function frameIndex()
        -- could we use modulus instead?
        frame = math.ceil(self.frameTimer / ANIMATION_SPEED)
        if frame > 4 then
            self.frameTimer = 0
            frame = 1
        end
        return frame
    end

    -- rounds float
    local function round(n)
        return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
    end

    local function trig(px, py)
        local x, y = map:convertPixelToTile(px, py)
        local floor = math.floor

        for k, trigger in pairs(gTriggers) do
            if (trigger.x0 == round(x) and trigger.y0 == floor(y)) or (trigger.x1 == round(x) and trigger.y1 == floor(y + 2)) then
                return trigger
            end
        end

        return {}
    end
    -- END HELPERS

    -- add time passed
    self.timer = self.timer + dt
    self.frameTimer = self.frameTimer + dt

    -- initialize these here so there's no nil error in update
    -- local?
    future_x = self.object.x
    future_y = self.object.y

    if self.moves then
        if self.type == 'player' then
            local speed = WALKING_SPEED

            -- set speed
            if love.keyboard.isDown("j") then
                speed = JOG_SPEED
            end

            -- Move player up
            if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
                self.direction = 3
                future_y = self.object.y - speed * dt
            -- Move player down
            elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
                self.direction = 1
                future_y = self.object.y + speed * dt
            -- Move player left
            elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
                self.direction = 4
                future_x = self.object.x - speed * dt
            -- Move player right
            elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
                self.direction = 2
                future_x = self.object.x + speed * dt
            end

        elseif self.type == 'npc' then

            -- some movemt every 3 secs
            if self.timer >= 3 then
                self.direction = math.random(4)
                self.timer = 0
            end

            -- sparratic movemt
            if self.direction == 1 and self.timer <= WALK_TIME then
                future_y = self.object.y + WALKING_SPEED * dt
            elseif self.direction == 2 and self.timer <= WALK_TIME then
                future_x = self.object.x + WALKING_SPEED * dt
            elseif self.direction == 3 and self.timer <= WALK_TIME then
                future_y = self.object.y - WALKING_SPEED * dt
            elseif self.direction == 4 and self.timer <= WALK_TIME then
                future_x = self.object.x - WALKING_SPEED * dt 
            end  
        end

        -- determine animation 
        if future_x == self.object.x and future_y == self.object.y then
            self.currentFrame = self.frames[self.direction][1]
        else
            self.currentFrame = self.frames[self.direction][frameIndex()]
        end

        -- look for collision 
        local actualX, actualY, collisions, len = world:check(self, future_x, future_y)

        if len == 0 then
            -- if no collision, move
            self.object.x = future_x
            self.object.y = future_y
            self.x = self.object.x
            self.y = self.object.y
            world:move(self, self.x, self.y)
        else
            if self.type == 'player' then
                -- look for trigger
                local res = trig(future_x, future_y)
                local num = 0

                for k, trigger in pairs(res) do
                    num = num + 1
                end

                if num > 0 then
                    if self.direction == 3 then
                        res:enter() 
                    else
                        res:exit()
                    end
                else
                    -- keep in place
                    self.object.x = actualX
                    self.object.y = actualY
                    self.x = self.object.x
                    self.y = self.object.y
                    self.currentFrame = self.frames[self.direction][1]
                    world:move(self, self.x, self.y)
                end
            else
                -- keep in place
                self.object.x = actualX
                self.object.y = actualY
                self.x = self.object.x
                self.y = self.object.y
                self.currentFrame = self.frames[self.direction][1]
                world:move(self, self.x, self.y)
            end
        end
    end
end

function Character:render()
    -- draw sprite
    -- subtract from y value to make sprite appear on object
    love.graphics.draw(self.charSheet, self.currentFrame, self.object.x, self.object.y - self.offset)
end 