RegisterCommand('me', function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('srp:showProximity', -1, source, 'me', msg)
end, false)

RegisterCommand('do', function(source, args)
    local msg = table.concat(args, ' ')
    TriggerClientEvent('srp:showProximity', -1, source, 'do', msg)
end, false)

RegisterCommand('try', function(source, args)
    local msg = table.concat(args, ' ')
    local success = math.random() > 0.5
    TriggerClientEvent('srp:showProximity', -1, source, 'try', {msg=msg, success=success})
end, false)