Shared = {}

Shared.interact = 'interact' -- 'ox_target' or 'interact'
Shared.ReputationCommand = 'setReputation'

Shared.npcs = {
    {
        name = "Abu Salman",
        text = "Hello, do you want to start or end your shift?",
        job = "Burger Shot Employee",
        ped = "csb_burgerdrug",
        coords = vector4(-1173.4746, -882.8961, 13.0092, 32.2758),
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
            },
        }
    },
}