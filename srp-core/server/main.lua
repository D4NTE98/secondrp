local Players = {}
local Jobs = {}
local Vehicles = {}

--[[
  TABELE SQL (MySQL)
  CREATE TABLE users (
    identifier VARCHAR(255) PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    job VARCHAR(50) DEFAULT 'unemployed',
    job_grade INT DEFAULT 0,
    money INT DEFAULT 5000,
    bank INT DEFAULT 0,
    phone_number VARCHAR(20)
  );

  CREATE TABLE owned_vehicles (
    owner VARCHAR(255),
    plate VARCHAR(12) UNIQUE,
    vehicle LONGTEXT,
    stored BOOLEAN DEFAULT true
  );
]]

AddEventHandler('playerConnecting', function()
    print("^3[SRP]^0 Gracz łączy się: " .. GetPlayerName(source))
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    if Players[src] then
        SavePlayerData(src)
        Players[src] = nil
    end
    print("^3[SRP]^0 Gracz wyszedł: " .. reason)
end)

RegisterNetEvent('srp:createCharacter')
AddEventHandler('srp:createCharacter', function(data)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)

    MySQL.Async.execute('INSERT INTO users (identifier, firstname, lastname) VALUES (@identifier, @firstname, @lastname)', {
        ['@identifier'] = identifier,
        ['@firstname'] = data.firstname,
        ['@lastname'] = data.lastname
    }, function()
        TriggerClientEvent('srp:characterCreated', src)
    end)
end)

RegisterNetEvent('srp:setJob')
AddEventHandler('srp:setJob', function(job, grade)
    local src = source
    if Players[src] then
        Players[src].job = job
        Players[src].job_grade = grade
        TriggerClientEvent('srp:updateJob', src, job, grade)
    end
end)

function GetPlayerMoney(source)
    return Players[source].money
end

RegisterNetEvent('srp:addMoney')
AddEventHandler('srp:addMoney', function(amount)
    local src = source
    if Players[src] then
        Players[src].money = Players[src].money + amount
        TriggerClientEvent('srp:updateMoney', src, Players[src].money)
    end
end)

RegisterNetEvent('srp:spawnVehicle')
AddEventHandler('srp:spawnVehicle', function(model)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    local vehicle = CreateVehicle(joaat(model), coords.x, coords.y, coords.z, 0.0, true, false)
    local netId = NetworkGetNetworkIdFromEntity(vehicle)
    
    TriggerClientEvent('srp:vehicleSpawned', src, netId)
end)

AddEventHandler('srp:playerLoaded', function(source)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0)
    
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            Players[src] = result[1]
            TriggerClientEvent('srp:initClient', src, Players[src])
        end
    end)
end)

function SavePlayerData(source)
    local player = Players[source]
    if player then
        MySQL.Async.execute('UPDATE users SET money=@money, job=@job, job_grade=@job_grade WHERE identifier=@identifier', {
            ['@money'] = player.money,
            ['@job'] = player.job,
            ['@job_grade'] = player.job_grade,
            ['@identifier'] = player.identifier
        })
    end
end