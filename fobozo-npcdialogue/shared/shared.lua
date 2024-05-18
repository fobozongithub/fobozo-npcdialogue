Shared = {}

-- // [Interaction settings] \\ --
Shared.interact = 'interact' -- Type of interaction method to use (Options: 'ox_target' or 'interact')

-- // [NPC Configuration] \\ --
Shared.DialoguePeds = {
    {
        name = "Abu Salman", -- Name of the NPC
        ped = "csb_burgerdrug", -- Ped model
        job = {
            title = "Burger Shot Employee", -- Job title of the NPC
            required = "" -- Job requirement to interact with the NPC (empty means no requirement)
        },
        coords = vector4(-1173.4746, -882.8961, 13.0092, 32.2758), -- Coordinates of the NPC
        text = "Hello, do you want to start or end your shift?", -- Dialogue text shown to the player
        interaction = {
            ox_target = { -- Settings for 'ox_target' interaction
                icon = 'fas fa-comments', -- Icon shown in the interaction menu
                distance = 2.5 -- Interaction distance
            },
            default = { -- Settings for default interaction
                distance = 7.5, -- Max interaction distance
                interactDst = 2.5 -- Interaction distance to trigger action
            }
        },
        options = { -- Options available in the dialogue menu
            {
                label = "Start Working",
                onSelect = function(rep)
                    local text
                    if rep < 50 then
                        text = "Looks like you're new to the place."
                    else
                        text = "Welcome back, my man. Ready to work?"
                    end
                    return {
                        updateText = text,
                        showNewButtons = true,
                        newButtons = {
                            {
                                label = "Sign In/Out",
                                onSelect = function()
                                    return {}
                                end,
                                minRep = 0,
                                maxRep = 100
                            },
                            {
                                label = "Change Clothes",
                                onSelect = function()
                                    return {}
                                end,
                                minRep = 50,
                                maxRep = 100
                            }
                        }
                    }
                end,
                minRep = 0,
                maxRep = 100
            },
            {
                label = "Exit",
                onSelect = function()
                    return {}
                end,
                minRep = 0,
                maxRep = 100
            }
        }
    },
    -- Additional NPC configurations...
}
