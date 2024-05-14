
# NPC Interaction System

This script provides a dynamic NPC interaction system with configurable settings and an aesthetically pleasing UI for role-playing environments.

## Features
- Configurable interaction settings using `ox_target` or `interact`
- Customizable NPC dialogues and commands
- Smooth animations and transitions
- Responsive design with adaptive styling for different screen sizes

## Preview
![NPC Interaction UI](https://media.discordapp.net/attachments/1187316503872274472/1239898391996272660/fobozo-npcdialogue.gif?ex=664498dc&is=6643475c&hm=3217b74918bc9ebd77e6f8597c9d55963e5ba7772f7f1ef28be437ae4cfe999f&=&width=787&height=662)

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
    Make sure you have the required dependencies installed, such as [es_extended](https://github.com/esx-framework/es_extended), [ox_target](https://github.com/overextended/ox_target), or [interact](https://github.com/darktrovx/interact).

4. **Add the Resource to Your Server**
    Add the following line to your server configuration file (e.g., `server.cfg`):
    ```plaintext
    ensure fobozo-npcdialogue
    ```

5. **Start Your Server**
    Restart your server or ensure the resource to apply the changes.

## Configuration

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
- [es_extended](https://github.com/esx-framework/es_extended)
- [ox_target](https://github.com/overextended/ox_target) or [interact](https://github.com/darktrovx/interact)

Ensure that you have these dependencies installed and configured properly for the NPC Interaction System to work seamlessly.

By following the installation and configuration guide, you will have a fully functional NPC interaction system integrated into your role-playing environment. Customize the NPCs and dialogues to fit your server's theme and provide an engaging experience for your players.
