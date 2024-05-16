Shared = {}

-- // [Interaction settings] \\ --
Shared.interact = 'interact' -- // [ Options: 'ox_target' or 'interact' ]
Shared.ReputationCommand = 'setReputation'

-- // [NPC Configuration] \\ --
Shared.DialoguePeds = {
    {
        name = "Abu Salman",
        ped = "csb_burgerdrug",
        job = {
            title = "Burger Shot Employee",
            required = "" -- No job requirement
        },
        coords = vector4(-1173.4746, -882.8961, 13.0092, 32.2758),
        text = "Hello, do you want to start or end your shift?",
        interaction = {
            ox_target = {
                icon = 'fas fa-comments',
                distance = 2.5
            },
            default = {
                distance = 7.5,
                interactDst = 2.5
            }
        },
        options = {
            {
                label = "Sign In/Out",
                event = "fobozo:print", 
                type = "client", 
                args = {'clock'},
                repRequired = 0 -- No reputation requirement
            },
            {
                label = "Change Clothes",
                event = "fobozo:print", 
                type = "client", 
                args = {'uniform'},
                repRequired = 50 -- 50 rep requirement
            },
            {
                label = "Exit",
                event = "fobozo:print", 
                type = "client", 
                args = {},
                repRequired = 0 -- No reputation requirement
            }
        }
    },
    {
        name = "Officer John",
        ped = "s_m_y_cop_01",
        job = {
            title = "LSPD Officer",
            required = "police" -- Required job is police
        },
        coords = vector4(-1172.7806, -885.5114, 12.9868, 293.5538),
        text = "Hello, Officer. Do you want to start or end your shift?",
        interaction = {
            ox_target = {
                icon = 'fas fa-comments',
                distance = 2.5
            },
            default = {
                distance = 7.5,
                interactDst = 2.5
            }
        },
        options = {
            {
                label = "Sign In/Out",
                event = "fobozo:print", 
                type = "client", 
                args = {'clock'},
                repRequired = 0 -- No reputation requirement
            },
            {
                label = "Change Clothes",
                event = "fobozo:print", 
                type = "client", 
                args = {'uniform'},
                repRequired = 50 -- 50 rep requirement
            },
            {
                label = "Exit",
                event = "fobozo:print", 
                type = "client", 
                args = {},
                repRequired = 0 -- No reputation requirement
            }
        }
    },
}


-- // [HOW TO USE EXPORT] \\ --

-- exports['fobozo-npcdialogue']:createDialoguePed(
--     "csb_burgerdrug", -- // [Ped model] \\ --
--     "Abu Salman", -- // [Ped name] \\ --
--     "Burger Shot Employee", -- // [Job title] \\ --
--     "police", -- // [Job requirement (optional, leave empty if none)] \\ --
--     -1173.4746, -882.8961, 13.0092, 32.2758, -- // [Coordinates (x, y, z, w)] \\ --
--     "Hello, do you want to start or end your shift?", -- // [Text] \\ --
--     "ox_target", -- // [Interaction type ('ox_target' or 'interact')] \\ --
--     { -- // [Options] \\ --
--         {
--             label = "Sign In/Out",
--             event = "fobozo:print", 
--             type = "client", 
--             args = {'clock'} 
--         },
--         {
--             label = "Change Clothes",
--             event = "fobozo:print", 
--             type = "client", 
--             args = {'uniform'} 
--         },
--         {
--             label = "Exit",
--             event = "fobozo:print", 
--             type = "client", 
--             args = {} 
--         }
--     }
-- )
