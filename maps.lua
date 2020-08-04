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
        toDraw = {"terrain0", "terrain2", "terrain1"},
        player = Character('Player', 'player', 0, 0, 16, 32, "maps/tiles/gfx/character.png", true, 'maps/route1.lua', {}),
        npcs =      {
                        --Character('NPC', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {"Hi!", "I'm happy!"}),
                        --Character('NPC1', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'How are you?'}),
                        --Character('NPC2', 'npc', 0, 0, 16, 32, "maps/tiles/gfx/NPC_test.png", true, 'maps/map.lua', {'You!', "You're not supposed to be in here!"}),
                    }, 
        triggers = {
                        Trigger({'shed1_floor', 'shed1_stuff'}, 63, 62, 91, 98, {"terrain0", "terrain2", "terrain1"}),
                        Trigger({'shed2_floor', 'shed2_stuff'}, 74, 72, 72, 98, {"terrain0", "terrain2", "terrain1"}),
                        Trigger({'house1_floor', 'house1_stuff'}, 63, 73, 54, 98, {"terrain0", "terrain2", "terrain1"}),
                        Trigger({'house2_floor', 'house2_stuff'}, 74, 62, 36, 98, {"terrain0", "terrain2", "terrain1"}),
                    },

        mtriggers = {
                        MapTrigger(18, 18, 2),
                        MapTrigger(18, 19, 2),
                        MapTrigger(18, 20, 2),
                        MapTrigger(18, 21, 2),
                        MapTrigger(18, 22, 2),
                        MapTrigger(18, 23, 2),
                        MapTrigger(18, 24, 2),
                    },
    },
}