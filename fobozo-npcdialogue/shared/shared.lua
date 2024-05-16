Shared = {}

-- // [Interaction settings] \\ --
Shared.interact = 'interact' -- // Type of interaction method to use (Options: 'ox_target' or 'interact')

-- // [NPC Actions] \\ --
Shared.Actions = {
    signInOut = function()
        print('Sign In/Out action triggered.')
    end,
    changeClothes = function()
        print('Change Clothes action triggered.')
    end,
    exit = function()
        print('Exit action triggered.')
    end
}

-- // [NPC Configuration] \\ --
Shared.DialoguePeds = {
    {
        name = "Abu Salman", -- // Name of the NPC
        ped = "csb_burgerdrug", -- // Ped model
        job = {
            title = "Burger Shot Employee", -- // Job title of the NPC
            required = "" -- // Job requirement to interact with the NPC (empty means no requirement)
        },
        coords = vector4(-1173.4746, -882.8961, 13.0092, 32.2758), -- // Coordinates of the NPC
        text = "Hello, do you want to start or end your shift?", -- // Dialogue text shown to the player
        interaction = {
            ox_target = { -- // Settings for 'ox_target' interaction
                icon = 'fas fa-comments', -- // Icon shown in the interaction menu
                distance = 2.5 -- // Interaction distance
            },
            default = { -- // Settings for default interaction
                distance = 7.5, -- // Max interaction distance
                interactDst = 2.5 -- // Interaction distance to trigger action
            }
        },
        options = { -- // Options available in the dialogue menu
            {
                label = "Sign In/Out", -- // Label shown to the player
                action = "signInOut", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 0 -- // Reputation required to perform the action
            },
            {
                label = "Change Clothes", -- // Label shown to the player
                action = "changeClothes", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 50 -- // Reputation required to perform the action
            },
            {
                label = "Exit", -- // Label shown to the player
                action = "exit", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 0 -- // Reputation required to perform the action
            }
        }
    },
    {
        name = "Officer John", -- // Name of the NPC
        ped = "s_m_y_cop_01", -- // Ped model
        job = {
            title = "LSPD Officer", -- // Job title of the NPC
            required = "police" -- // Job requirement to interact with the NPC
        },
        coords = vector4(-1172.7806, -885.5114, 12.9868, 293.5538), -- // Coordinates of the NPC
        text = "Hello, Officer. Do you want to start or end your shift?", -- // Dialogue text shown to the player
        interaction = {
            ox_target = { -- // Settings for 'ox_target' interaction
                icon = 'fas fa-comments', -- // Icon shown in the interaction menu
                distance = 2.5 -- // Interaction distance
            },
            default = { -- // Settings for default interaction
                distance = 7.5, -- // Max interaction distance
                interactDst = 2.5 -- // Interaction distance to trigger action
            }
        },
        options = { -- // Options available in the dialogue menu
            {
                label = "Sign In/Out", -- // Label shown to the player
                action = "signInOut", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 0 -- // Reputation required to perform the action
            },
            {
                label = "Change Clothes", -- // Label shown to the player
                action = "changeClothes", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 50 -- // Reputation required to perform the action
            },
            {
                label = "Exit", -- // Label shown to the player
                action = "exit", -- // Action to perform (referenced in Shared.Actions)
                repRequired = 0 -- // Reputation required to perform the action
            }
        }
    },
}
