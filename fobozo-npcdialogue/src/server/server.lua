RegisterCommand(Shared.ReputationCommand, function(source, args, rawCommand)
    local newRep = tonumber(args[1])
    if newRep then
        TriggerClientEvent('fobozo-npcdialogue:updateRep', source, newRep)
    else
        print('Invalid rep value')
    end
end)