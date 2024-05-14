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
