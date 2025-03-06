local Accounts = {}
local activeSessions = {}

RegisterNetEvent('srp:registerAccount')
AddEventHandler('srp:registerAccount', function(email, password)
    local src = source
    if not isValidEmail(email) then
        TriggerClientEvent('srp:showNotification', src, "Nieprawidłowy format email!", 'error')
        return
    end
    
    local hashedPassword = HashString(password)
    
    MySQL.Async.execute('INSERT INTO accounts (email, password) VALUES (@email, @password)', {
        ['@email'] = email,
        ['@password'] = hashedPassword
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('srp:showNotification', src, "Konto zostało założone!", 'success')
        end
    end)
end)

RegisterNetEvent('srp:loginAccount')
AddEventHandler('srp:loginAccount', function(email, password)
    local src = source
    local hashedPassword = HashString(password)
    
    MySQL.Async.fetchScalar('SELECT id FROM accounts WHERE email = @email AND password = @password', {
        ['@email'] = email,
        ['@password'] = hashedPassword
    }, function(accountId)
        if accountId then
            activeSessions[src] = accountId
            TriggerClientEvent('srp:loggedIn', src, accountId)
        else
            TriggerClientEvent('srp:showNotification', src, "Błędne dane logowania!", 'error')
        end
    end)
end)

RegisterNetEvent('srp:selectCharacter')
AddEventHandler('srp:selectCharacter', function(charId)
    local src = source
    local accountId = activeSessions[src]
    
    MySQL.Async.fetchAll('SELECT * FROM characters WHERE account_id = @accountId AND id = @charId', {
        ['@accountId'] = accountId,
        ['@charId'] = charId
    }, function(result)
        if result[1] then
            TriggerEvent('srp:playerLoaded', src, result[1])
        end
    end)
end)

function HashString(str)
    return string.lower(sha256(str))
end

function isValidEmail(email)
    return string.match(email, "^[%w_.+-]+@[%w-]+%.%w+$") ~= nil
end