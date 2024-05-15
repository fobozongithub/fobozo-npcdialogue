Shared = {}

-- // [Interaction settings] \\ --
Shared.interact = 'interact' -- // [ Options: 'ox_target' or 'interact' ]
Shared.ReputationCommand = 'setReputation'

-- // [NPC Configuration] \\ --
Shared.DialoguePeds = {
    {
        -- // [NPC Identification] \\ --
        name = "Abu Salman",
        ped = "csb_burgerdrug",
        
        -- // [Job settings] \\ --
        job = {
            title = "Burger Shot Employee",
            required = "" -- No job requirement
        },
        
        -- // [NPC Location] \\ --
        coords = vector4(-1173.4746, -882.8961, 13.0092, 32.2758),
        
        -- // [Interaction text] \\ --
        text = "Hello, do you want to start or end your shift?",
        
        -- // [Interaction settings] \\ --
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
        
        -- // [Options available for interaction] \\ --
        options = {
            {
                label = "Sign In/Out",
                event = "fobozo:print", 
                type = "client", 
                args = {'clock'} 
            },
            {
                label = "Change Clothes",
                event = "fobozo:print", 
                type = "client", 
                args = {'uniform'} 
            },
            {
                label = "Leave Conversation",
                event = "fobozo:print", 
                type = "client", 
                args = {} 
            }
        }
    },
    {
        -- // [NPC Identification] \\ --
        name = "Officer John",
        ped = "s_m_y_cop_01",
        
        -- // [Job settings] \\ --
        job = {
            title = "LSPD Officer",
            required = "police" -- Required job is police
        },
        
        -- // [NPC Location] \\ --
        coords = vector4(-1172.7806, -885.5114, 12.9868, 293.5538),
       
        -- // [Interaction text] \\ --
        text = "Hello, Officer. Do you want to start or end your shift?",
        
        -- // [Interaction settings] \\ --
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
        
        -- // [Options available for interaction] \\ --
        options = {
            {
                label = "Sign In/Out",
                event = "fobozo:print", 
                type = "client", 
                args = {'clock'} 
            },
            {
                label = "Change Clothes",
                event = "fobozo:print", 
                type = "client", 
                args = {'uniform'} 
            },
            {
                label = "Leave Conversation",
                event = "fobozo:print", 
                type = "client", 
                args = {} 
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
--             label = "Leave Conversation",
--             event = "fobozo:print", 
--             type = "client", 
--             args = {} 
--         }
--     }
-- )
