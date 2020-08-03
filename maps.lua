return {

    {   
        filename = 'maps/map.lua',
        toDraw = {"Tile Layer 1", "Buildings"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/map.lua', {}),
        npcs =      {
                        Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    },

        mtriggers = {
            
                    },
    },

    {   
        filename = 'maps/spawn1.lua',
        toDraw = {"terrain0", "terrain1"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/spawn.lua', {}),
        npcs =      {
                        --Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        --Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        --Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        --Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    },

        mtriggers = {
                        MapTrigger(73, 27, 3),
                        MapTrigger(73, 28, 3),
                        MapTrigger(73, 29, 3),
                        MapTrigger(73, 30, 3),
                        MapTrigger(73, 31, 3),
                        MapTrigger(73, 32, 3),
                        MapTrigger(73, 33, 3),
                        MapTrigger(73, 34, 3),
                        MapTrigger(73, 35, 3),
                        MapTrigger(73, 36, 3),
                    },
    },

    {   
        filename = 'maps/route1.lua',
        toDraw = {"terrain0", "terrain1", "terrain2"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/route1.lua', {}),
        npcs =      {
                        --Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        --Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        --Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        --Trigger({'Shed', 'ShedObjects'}, 23, 23, 9, 57, {"Tile Layer 1", "Buildings"}),
                    },

        mtriggers = {
                    },
    },
}