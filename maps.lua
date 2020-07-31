return {

    {   
        filename = 'map.lua',
        toDraw = {"Tile Layer 1", "Buildings"},
        player = Character('Player', 'player', 0, 0, 16, 32, "tiles/gfx/character.png", true, 'map.lua', {}),
        npcs =      {
                        Character('NPC', 'npc', 0, 0, 16, 32, "tiles/gfx/NPC_test.png", true, 'map.lua', {"Hi!", "I'm happy!"}),
                        Character('NPC1', 'npc', 0, 0, 16, 32, "tiles/gfx/NPC_test.png", true, 'map.lua', {'How are you?'}),
                        Character('NPC2', 'npc', 0, 0, 16, 32, "tiles/gfx/NPC_test.png", true, 'map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    }
    },
}