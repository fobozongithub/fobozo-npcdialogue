
# NPC Interaction System Inspired by Nopixel 4.0 (Loved the design, so tried it out)

The Dialogue System is a comprehensive and customizable script designed for roleplaying servers utilizing the ESX or QBCore frameworks. This system allows server administrators to create immersive and interactive NPC dialogues with configurable interactions, reputation management, and job requirements. The script supports smooth animations, responsive design, and a seamless integration with popular interaction systems like ox_target and interact.

## Features
- Configurable interaction settings using `ox_target` or `interact`
- Customizable NPC dialogues and commands
- Smooth animations and transitions
- Responsive design with adaptive styling for different screen sizes
- Reputation management system with server-side callbacks and exports
- Supports both ESX and QBCore frameworks
- Easy to set up and extend with configurable NPC interaction settings

## Support

For any questions, feedback, or assistance with using the NPC Interaction System, you can join our Discord server:

[![Discord](https://img.shields.io/discord/1131142366204530769?color=7289da&label=Discord&logo=discord&logoColor=white)](https://discord.gg/b5kjPY2FM8)

## Preview
![NPC Interaction UI](https://media.discordapp.net/attachments/1245669285272092684/1245669285779734539/fobozo-npcdialogue.png?ex=6675efad&is=66749e2d&hm=1bfdcb5957281a189030d660754daa5c78d9cfc2c79017c3abfdfab585bca8fb&=&format=webp&quality=lossless&width=885&height=497)

## Installation Guide

1. **Clone the Repository**
    ```sh
    git clone https://github.com/fobozongithub/fobozo-npcdialogue.git
    ```

2. **Navigate to the Directory**
    ```sh
    cd fobozo-npcdialogue
    ```

3. **Install Dependencies**
    Make sure you have the required dependencies installed, such as [oxmysql](https://github.com/overextended/oxmysql) and [ox_target](https://github.com/overextended/ox_target), or [interact](https://github.com/darktrovx/interact).

4. **Setup the Database**
    Create the required table in your database by running the following SQL command:
    ```sql
    CREATE TABLE IF NOT EXISTS npc_reputation (
        id INT AUTO_INCREMENT PRIMARY KEY,
        identifier VARCHAR(50) NOT NULL,
        ped_model VARCHAR(50) NOT NULL,
        reputation INT DEFAULT 0,
        UNIQUE (identifier, ped_model)
    );
    ```

5. **Add the Resource to Your Server**
    Add the following line to your server configuration file (e.g., `server.cfg`):
    ```plaintext
    ensure fobozo-npcdialogue
    ```

6. **Start Your Server**
    Restart your server or ensure the resource to apply the changes.


## Configuration

### Exports

```lua
exports['fobozo-npcdialogue']:setReputation(playerId, pedModel, reputation)
```

```lua
exports['fobozo-npcdialogue']:addReputation(playerId, pedModel, amount)
```

```lua
exports['fobozo-npcdialogue']:removeReputation(playerId, pedModel, amount)
```

```lua
exports['fobozo-npcdialogue']:getReputation(playerId, pedModel, function(reputation)
    callback(reputation)
end)
```

```lua
exports['fobozo-npcdialogue']:createDialoguePed(
    'mp_f_bennymech_01',
    'Custom NPC',
    'Custom Job',
    'police',
    -1175.9968, -878.6601, 13.0109, 67.6690,
    'Hello, do you want to start or end your shift?', 
    {
        ox_target = { icon = 'fas fa-comments', distance = 2.5 },
        default = { distance = 7.5, interactDst = 2.5 }
    },
    {
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
)
```

### Shared Configuration
You can configure NPC settings in the `shared.lua` file:

```lua
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

```

### Dependencies
- [oxmysql](https://github.com/overextended/oxmysql)
- [ox_target](https://github.com/overextended/ox_target) or [interact](https://github.com/darktrovx/interact)

Ensure that you have these dependencies installed and configured properly for the NPC Interaction System to work seamlessly.

By following the installation and configuration guide, you will have a fully functional NPC interaction system integrated into your role-playing environment. Customize the NPCs and dialogues to fit your server's theme and provide an engaging experience for your players.

## Credits
This project was originally created by the [NS-NPCDialogue](https://github.com/Nexus-Fivem/ns-npcdialogue?tab=MIT-1-ov-file) script, created by Nexus-Fivem. Special thanks to the creators of this project for their efforts and dedication. I have since enhanced it with additional features and a more polished design.
