
# NPC Interaction System

This script provides a dynamic NPC interaction system with configurable settings and an aesthetically pleasing UI for role-playing environments.

## Features
- Configurable interaction settings using `ox_target` or `interact`
- Customizable NPC dialogues and commands
- Smooth animations and transitions
- Responsive design with adaptive styling for different screen sizes

## Support

For any questions, feedback, or assistance with using the NPC Interaction System, you can join our Discord server:

[![Discord](https://img.shields.io/discord/1131142366204530769?color=7289da&label=Discord&logo=discord&logoColor=white)](https://discord.gg/9wsVqqgCVz)

## Preview
![NPC Interaction UI](https://media.discordapp.net/attachments/1239968782890434684/1240263972389785620/image.png?ex=6645ed56&is=66449bd6&hm=a6651fd47552bd14899c9640f743b16e5602fc45157785f84fcaebd670182af7&=&format=webp&quality=lossless&width=1387&height=662)

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
    Make sure you have the required dependencies installed, such as [ox_target](https://github.com/overextended/ox_target), or [interact](https://github.com/darktrovx/interact).

4. **Add the Resource to Your Server**
    Add the following line to your server configuration file (e.g., `server.cfg`):
    ```plaintext
    ensure fobozo-npcdialogue
    ```

5. **Start Your Server**
    Restart your server or ensure the resource to apply the changes.

## Configuration

### Exports

```lua
exports['fobozo-npcdialogue']:createDialoguePed(
    "csb_burgerdrug", -- // [Ped model] \\ --
    "Abu Salman", -- // [Ped name] \\ --
    "Burger Shot Employee", -- // [Job title] \\ --
    "police", -- // [Job requirement (optional, leave empty if none)] \\ --
    -1173.4746, -882.8961, 13.0092, 32.2758, -- // [Coordinates (x, y, z, w)] \\ --
    "Hello, do you want to start or end your shift?", -- // [Text] \\ --
    "ox_target", -- // [Interaction type ('ox_target' or 'interact')] \\ --
    { -- // [Options] \\ --
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
)
```

### Shared Configuration
You can configure NPC settings in the `shared.lua` file:

```lua
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
```

### Dependencies
- [ox_target](https://github.com/overextended/ox_target) or [interact](https://github.com/darktrovx/interact)

Ensure that you have these dependencies installed and configured properly for the NPC Interaction System to work seamlessly.

By following the installation and configuration guide, you will have a fully functional NPC interaction system integrated into your role-playing environment. Customize the NPCs and dialogues to fit your server's theme and provide an engaging experience for your players.

## Credits
This project makes use of the [NS-NPCDialogue](https://github.com/Nexus-Fivem/ns-npcdialogue?tab=MIT-1-ov-file) system, created by Nexus-Fivem. Special thanks to the contributors of this project for their efforts and dedication.
