DialogueState = Class{__includes = BaseState}

function DialogueState:init()
    assert(g_talking_npc, 'no one is talking!')

    self.talking = g_talking_npc
    self.index = 1
    self.dialogueTree = self.talking.dialogueTree
    self.length = get_length(self.dialogueTree)

    print(self.dialogueTree[self.index])
    self.index = self.index + 1
end

function DialogueState:update(dt)
    if self.index > self.length then
        gStateMachine:change('play')
    elseif love.keyboard.wasPressed('k') then
        print(self.dialogueTree[self.index])
        self.index = self.index + 1
    end
end

-- same as play state
function DialogueState:render()
    -- make world move around player
    local tx = math.floor(player.x - GAME_WIDTH / 2)
    local ty = math.floor(player.y - GAME_HEIGHT / 2)
    love.graphics.translate(-tx, -ty)

    -- draw map, player, npcs
    for k, layer in pairs(map_toDraw) do
        gMap:drawTileLayer(layer)
    end

    player:render()

    for k, npc in pairs(map_npcs) do
        npc:render()
    end
end