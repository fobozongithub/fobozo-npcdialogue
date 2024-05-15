
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
![NPC Interaction UI](https://media.discordapp.net/attachments/1187316503872274472/1239968179778748536/image.png?ex=6644d9db&is=6643885b&hm=ad3ff28c571d9580ba4f5bc1912806487dddcb09451ec89a75e99e7d5e4f189e&=&format=webp&quality=lossless&width=1618&height=910)

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

Shared.interact = 'ox_target' -- or 'interact'
Shared.ReputationCommand = 'setReputation'

Shared.npcs = {
    {
        name = "Abu Salman",
        text = "Hello, do you want to start or end your shift?",
        job = "Burger Shot Employee",
        ped = "csb_burgerdrug",
        coords = vector4(-1191.25, -900.46, 12.98, 311.28),
        ox_target = {
            icon = 'fas fa-comments',
            distance = 7.5
        },
        interact = {
            distance = 7.5,
            interactDst = 5
        },
        options = {
            {
                label = "Clock In/Out",
                event = "menu-iRender:clockInOut", 
                type = "client", 
                args = {'clock'} 
            },
            {
                label = "Change Clothes",
                event = "menu-iRender:changeClothes", 
                type = "client", 
                args = {'uniform'} 
            },
            {
                label = "Leave Conversation",
                event = "fobozo-npcdialogue:hideMenu", 
                type = "client", 
                args = {} 
            },
        }
    },
}
```

### Dependencies
- [ox_target](https://github.com/overextended/ox_target) or [interact](https://github.com/darktrovx/interact)

Ensure that you have these dependencies installed and configured properly for the NPC Interaction System to work seamlessly.

By following the installation and configuration guide, you will have a fully functional NPC interaction system integrated into your role-playing environment. Customize the NPCs and dialogues to fit your server's theme and provide an engaging experience for your players.
