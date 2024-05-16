-- // [INITIALIZATION] \\ --

local ESX, QBCore

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

-- // [UTILITY FUNCTIONS] \\ --

local function debugLog(message)
    print(('[fobozo-npcdialogue] %s'):format(message))
end

local function getPlayer(source)
    if ESX then
        return ESX.GetPlayerFromId(source)
    elseif QBCore then
        return QBCore.Functions.GetPlayer(source)
    end
    return nil
end

local function setReputation(identifier, pedModel, amount)
    MySQL.Async.execute('UPDATE npc_reputation SET reputation = @amount WHERE identifier = @identifier AND ped_model = @ped_model', {
        ['@amount'] = amount,
        ['@identifier'] = identifier,
        ['@ped_model'] = pedModel
    }, function(rowsChanged)
        if rowsChanged > 0 then
            debugLog(('Reputation set for identifier %s, pedModel %s, new amount %s'):format(identifier, pedModel, amount))
        end
    end)
end

local function addReputation(identifier, pedModel, amount)
    MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
        ['@identifier'] = identifier,
        ['@ped_model'] = pedModel
    }, function(result)
        if #result > 0 then
            local newReputation = result[1].reputation + amount
            setReputation(identifier, pedModel, newReputation)
        end
    end)
end

local function removeReputation(identifier, pedModel, amount)
    MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
        ['@identifier'] = identifier,
        ['@ped_model'] = pedModel
    }, function(result)
        if #result > 0 then
            local newReputation = result[1].reputation - amount
            if newReputation < 0 then
                newReputation = 0
            end
            setReputation(identifier, pedModel, newReputation)
        end
    end)
end

local function getReputation(identifier, pedModel, cb)
    MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
        ['@identifier'] = identifier,
        ['@ped_model'] = pedModel
    }, function(result)
        if #result > 0 then
            cb(result[1].reputation)
        else
            cb(0)
        end
    end)
end

-- // [EVENT HANDLERS] \\ --

RegisterServerEvent('fobozo-npcdialogue:initializeRep')
AddEventHandler('fobozo-npcdialogue:initializeRep', function(pedModel)
    local src = source
    local player = getPlayer(src)
    
    if not player then
        debugLog(('Player not found for source %s in initializeRep'):format(src))
        return
    end

    local identifier = player.identifier or player.PlayerData.citizenid

    MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
        ['@identifier'] = identifier,
        ['@ped_model'] = pedModel
    }, function(result)
        if #result == 0 then
            MySQL.Async.execute('INSERT INTO npc_reputation (identifier, ped_model, reputation) VALUES (@identifier, @ped_model, @reputation)', {
                ['@identifier'] = identifier,
                ['@ped_model'] = pedModel,
                ['@reputation'] = 0
            })
            TriggerClientEvent('fobozo-npcdialogue:setRep', src, 0)
        else
            TriggerClientEvent('fobozo-npcdialogue:setRep', src, result[1].reputation)
        end
    end)
end)

if ESX then
    ESX.RegisterServerCallback('fobozo-npcdialogue:getRep', function(source, cb, pedModel)
        local player = getPlayer(source)
        
        if not player then
            debugLog(('Player not found for source %s in getRep'):format(source))
            cb(0)
            return
        end

        local identifier = player.identifier

        MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
            ['@identifier'] = identifier,
            ['@ped_model'] = pedModel
        }, function(result)
            if #result > 0 then
                cb(result[1].reputation)
            else
                cb(0)
            end
        end)
    end)
elseif QBCore then
    QBCore.Functions.CreateCallback('fobozo-npcdialogue:getRep', function(source, cb, pedModel)
        local player = getPlayer(source)
        
        if not player then
            debugLog(('Player not found for source %s in getRep'):format(source))
            cb(0)
            return
        end

        local identifier = player.PlayerData.citizenid

        MySQL.Async.fetchAll('SELECT reputation FROM npc_reputation WHERE identifier = @identifier AND ped_model = @ped_model', {
            ['@identifier'] = identifier,
            ['@ped_model'] = pedModel
        }, function(result)
            if #result > 0 then
                cb(result[1].reputation)
            else
                cb(0)
            end
        end)
    end)
end

-- // [EXPORTS] \\ --

exports('setReputation', function(source, pedModel, amount)
    debugLog(('setReputation called with source: %s, pedModel: %s, amount: %s'):format(source, pedModel, amount))
    local player = getPlayer(source)
    
    if not player then
        debugLog(('Player not found for source %s in setReputation'):format(source))
        return
    end

    local identifier = player.identifier or player.PlayerData.citizenid
    setReputation(identifier, pedModel, amount)
end)

exports('addReputation', function(source, pedModel, amount)
    debugLog(('addReputation called with source: %s, pedModel: %s, amount: %s'):format(source, pedModel, amount))
    local player = getPlayer(source)
    
    if not player then
        debugLog(('Player not found for source %s in addReputation'):format(source))
        return
    end

    local identifier = player.identifier or player.PlayerData.citizenid
    addReputation(identifier, pedModel, amount)
end)

exports('removeReputation', function(source, pedModel, amount)
    debugLog(('removeReputation called with source: %s, pedModel: %s, amount: %s'):format(source, pedModel, amount))
    local player = getPlayer(source)
    
    if not player then
        debugLog(('Player not found for source %s in removeReputation'):format(source))
        return
    end

    local identifier = player.identifier or player.PlayerData.citizenid
    removeReputation(identifier, pedModel, amount)
end)

exports('getReputation', function(source, pedModel, cb)
    debugLog(('getReputation called with source: %s, pedModel: %s'):format(source, pedModel))
    local player = getPlayer(source)
    
    if not player then
        debugLog(('Player not found for source %s in getReputation'):format(source))
        cb(0)
        return
    end

    local identifier = player.identifier or player.PlayerData.citizenid
    getReputation(identifier, pedModel, cb)
end)
