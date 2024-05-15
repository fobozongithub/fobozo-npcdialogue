local FOBOZO = { Functions = {} }
local playerReputation = 0

FOBOZO.Functions.GetOffsetFromCoordsAndHeading = function(coords, heading, offsetX, offsetY, offsetZ)
    local headingRad = math.rad(heading)
    local x = offsetX * math.cos(headingRad) - offsetY * math.sin(headingRad)
    local y = offsetX * math.sin(headingRad) + offsetY * math.cos(headingRad)
    local z = offsetZ

    local worldCoords = vector4(
        coords.x + x,
        coords.y + y,
        coords.z + z,
        heading
    )
    
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

    if GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        while not ESX do
            Citizen.Wait(100)
        end
        playerJob = ESX.GetPlayerData().job.name
    elseif GetResourceState('qb-core') == 'started' then
        local QBCore = exports['qb-core']:GetCoreObject()
        while not QBCore do
            Citizen.Wait(100)
        end
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
                        TriggerEvent("fobozo-npcdialogue:showMenu", npc, playerReputation)
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
                            TriggerEvent("fobozo-npcdialogue:showMenu", npc, playerReputation)
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

RegisterNetEvent("fobozo-npcdialogue:showMenu", function(npc)
    SendNUIMessage({
        type = "dialog",
        options = npc.options,
        name = npc.name,
        text = npc.text,
        job = npc.job.title,
        rep = playerReputation
    })
    FOBOZO.Functions.CamCreate(npc.coords)
end)

RegisterNetEvent('fobozo-npcdialogue:updateRep', function(newRep)
    playerReputation = newRep
    SendNUIMessage({
        type = 'updateRep',
        rep = newRep
    })
end)

RegisterNUICallback("fobozo-npcdialogue:hideMenu", function()
    SetNuiFocus(false, false)
    FOBOZO.Functions.DestroyCamera()
end)

RegisterNUICallback("fobozo-npcdialogue:process", function(data)
    SetNuiFocus(false, false)
    if data.type == 'client' then
        TriggerEvent(data.event, table.unpack(data.args))
    elseif data.type == 'server' then
        TriggerServerEvent(data.event, table.unpack(data.args))
    elseif data.type == 'command' then
        ExecuteCommand(data.event)
    end
    FOBOZO.Functions.DestroyCamera()
end)

-- // [EXPORTS] \\ --

exports('createDialoguePed', function(pedModel, pedName, jobTitle, jobRequired, x, y, z, w, text, interaction, options)
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
        options = options
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

-- // HARDCODED, RECOMMENDED TO MAKE YOUR OWN SYSTEM \\ --

RegisterNetEvent('fobozo:print', function()
    print('test event')
end)