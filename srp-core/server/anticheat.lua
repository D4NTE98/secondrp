local speedThreshold = 30.0 
local lastPositions = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        
        for src, _ in pairs(Players) do
            local ped = GetPlayerPed(src)
            local pos = GetEntityCoords(ped)
            local velocity = GetEntitySpeed(ped)
            
            if velocity > speedThreshold and not IsPedInAnyVehicle(ped) then
                LogCheat(src, 'Speedhack', 'Velocity: '..velocity)
            end
            
            if lastPositions[src] then
                local distance = #(pos - lastPositions[src])
                if distance > 100.0 then
                    LogCheat(src, 'Teleport', 'Distance: '..distance)
                end
            end
            lastPositions[src] = pos
            
            local weapons = GetPedWeapons(ped)
            for _, weapon in ipairs(Config.AllowedWeapons) do
                if not HasPedGotWeapon(ped, weapon, false) then
                    LogCheat(src, 'Invalid Weapon', 'Weapon: '..weapon)
                end
            end
        end
    end
end)

function LogCheat(source, type, details)
    local identifier = GetPlayerIdentifier(source, 0)
    MySQL.Async.execute('INSERT INTO anticheat_logs (identifier, type, details) VALUES (@id, @type, @details)', {
        ['@id'] = identifier,
        ['@type'] = type,
        ['@details'] = details
    })
    DropPlayer(source, 'AC: '..type)
end

RegisterNetEvent('srp:healPlayer')
AddEventHandler('srp:healPlayer', function()
    local src = source
    if Players[src].job ~= 'ambulance' then
        LogCheat(src, 'Illegal Healing', 'AC - Illegal Healing')
    end
end)