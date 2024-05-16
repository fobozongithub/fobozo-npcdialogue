local FOBOZO = { Functions = {} }
local playerReputation = 0
local ESX, QBCore

-- // [INITIALIZATION] \\ --

if GetResourceState('es_extended') == 'started' then
    ESX = exports['es_extended']:getSharedObject()
    while not ESX do
        Citizen.Wait(100)
    end
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    while not QBCore do
        Citizen.Wait(100)
    end
end

-- // [FUNCTIONS] \\ --

FOBOZO.Functions.GetOffsetFromCoordsAndHeading = function(coords, heading, offsetX, offsetY, offsetZ)
    local headingRad = math.rad(heading)
    local x = offsetX * math.cos(headingRad) - offsetY * math.sin(headingRad)
    local y = offsetX * math.sin(headingRad) + offsetY * math.cos(headingRad)
    local z = offsetZ

    local worldCoords = vector4(coords.x + x, coords.y + y, coords.z + z, heading)
    return worldCoords
end

FOBOZO.Functions.CamCreate = function(npc)
    cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')
    local coordsCam = FOBOZO.Functions.GetOffsetFromCoordsAndHeading(npc, npc.w, 0.0, 0.6, 1.60)
    local coordsPly = npc
    SetCamCoord(cam, coordsCam)
    PointCamAtCoord(cam, coordsPly.x, coordsPly.y, coordsPly.z + 1.60)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
end

FOBOZO.Functions.DestroyCamera = function()
    RenderScriptCams(false, true, 500, 1, 0)
    DestroyCam(cam, false)
end

FOBOZO.Functions.GetPlayerJob = function()
    local playerJob = nil

    if ESX then
        playerJob = ESX.GetPlayerData().job.name
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayerData()
        playerJob = Player.job.name
    end

    return playerJob
end

FOBOZO.Functions.AddInteraction = function(npc, npcPed)
    if Shared.interact == 'ox_target' then
        exports.ox_target:addLocalEntity(npcPed, {
            {
                name = npc.name,
                label = npc.name,
                icon = npc.interaction.ox_target.icon or 'fas fa-comments',
                distance = npc.interaction.ox_target.distance or 7.5,
                onSelect = function()
                    local playerJob = FOBOZO.Functions.GetPlayerJob()
                    if npc.job.required == "" or playerJob == npc.job.required then
                        TriggerServerEvent("fobozo-npcdialogue:initializeRep", npc.ped)
                        TriggerEvent("fobozo-npcdialogue:showMenu", npc)
                        SetNuiFocus(true, true)
                    else
                        print("You cannot interact with this NPC.")
                    end
                end
            }
        })
    elseif Shared.interact == 'interact' then
        exports['interact']:AddLocalEntityInteraction({
            entity = npcPed,
            name = npc.name,
            options = {
                {
                    label = npc.name,
                    action = function(entity)
                        local playerJob = FOBOZO.Functions.GetPlayerJob()
                        if npc.job.required == "" or playerJob == npc.job.required then
                            TriggerServerEvent("fobozo-npcdialogue:initializeRep", npc.ped)
                            TriggerEvent("fobozo-npcdialogue:showMenu", npc)
                            SetNuiFocus(true, true)
                        else
                            print("You cannot interact with this NPC.")
                        end
                    end,
                }
            },
            distance = npc.interaction.default.distance or 7.5,
            interactDst = npc.interaction.default.interactDst or 5
        })
    end
end

-- // [THREADS] \\ --

Citizen.CreateThread(function()
    for _, npc in ipairs(Shared.DialoguePeds) do
        RequestModel(GetHashKey(npc.ped))
        while not HasModelLoaded(GetHashKey(npc.ped)) do
            Wait(500)
        end

        local npcPed = CreatePed(4, GetHashKey(npc.ped), npc.coords.x, npc.coords.y, npc.coords.z, npc.coords.w, false, false)
        FreezeEntityPosition(npcPed, true)
        SetEntityInvincible(npcPed, true)
        SetBlockingOfNonTemporaryEvents(npcPed, true)
        
        FOBOZO.Functions.AddInteraction(npc, npcPed)
    end
end)

-- // [EVENT HANDLERS] \\ --

RegisterNetEvent("fobozo-npcdialogue:showMenu", function(npc)
    local pedModel = npc.ped
    local npcActions = npc.actions or Shared.Actions -- Use custom actions if provided, otherwise fall back to Shared.Actions
    
    local callback = function(rep)
        playerReputation = rep
        SendNUIMessage({
            type = "dialog",
            options = npc.options,
            name = npc.name,
            text = npc.text,
            job = npc.job.title,
            rep = playerReputation
        })
        FOBOZO.Functions.CamCreate(npc.coords)
    end

    if ESX then
        ESX.TriggerServerCallback('fobozo-npcdialogue:getRep', callback, pedModel)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('fobozo-npcdialogue:getRep', callback, pedModel)
    end
end)


RegisterNetEvent('fobozo-npcdialogue:setRep')
AddEventHandler('fobozo-npcdialogue:setRep', function(rep)
    playerReputation = rep
    SendNUIMessage({
        type = 'updateRep',
        rep = rep
    })
end)

-- // [NUI CALLBACKS] \\ --

RegisterNUICallback("fobozo-npcdialogue:getRep", function(data, cb)
    local pedModel = data.pedModel
    if ESX then
        ESX.TriggerServerCallback('fobozo-npcdialogue:getRep', function(rep)
            playerReputation = rep
            cb(rep)
        end, pedModel)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('fobozo-npcdialogue:getRep', function(rep)
            playerReputation = rep
            cb(rep)
        end, pedModel)
    end
end)

RegisterNUICallback("fobozo-npcdialogue:hideMenu", function()
    SetNuiFocus(false, false)
    FOBOZO.Functions.DestroyCamera()
end)

RegisterNUICallback("fobozo-npcdialogue:process", function(data, cb)
    SetNuiFocus(false, false)
    local actionName = data.action
    if Shared.Actions[actionName] then
        Shared.Actions[actionName]()
    else
        print('Action could not be found: ' .. tostring(actionName))
    end
    FOBOZO.Functions.DestroyCamera()
    cb('ok')
end)

-- // [EXPORTS] \\ --

exports('createDialoguePed', function(pedModel, pedName, jobTitle, jobRequired, x, y, z, w, text, interaction, options, customActions)
    local npc = {
        name = pedName,
        ped = pedModel,
        job = {
            title = jobTitle,
            required = jobRequired
        },
        coords = vector4(x, y, z, w),
        text = text,
        interaction = interaction,
        options = options,
        actions = customActions
    }

    RequestModel(GetHashKey(npc.ped))
    while not HasModelLoaded(GetHashKey(npc.ped)) do
        Wait(500)
    end

    local npcPed = CreatePed(4, GetHashKey(npc.ped), npc.coords.x, npc.coords.y, npc.coords.z, npc.coords.w, false, false)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)

    FOBOZO.Functions.AddInteraction(npc, npcPed)
end)