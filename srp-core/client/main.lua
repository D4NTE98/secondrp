local isCharacterCreated = false
local playerData = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if not isCharacterCreated then
            if NetworkIsPlayerActive(PlayerId()) then
                TriggerServerEvent('srp:playerLoaded')
                ShowCharacterCreation()
                break
            end
        end
    end
end)

function ShowCharacterCreation()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'show_creator',
        allowedNames = Config.AllowedFirstNames
    })
end

RegisterNUICallback('createCharacter', function(data, cb)
    TriggerServerEvent('srp:createCharacter', data)
    SetNuiFocus(false, false)
    isCharacterCreated = true
    cb({})
end)

-- HUD
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isCharacterCreated then
            local ped = PlayerPedId()
            
            SendNUIMessage({
                type = 'update_hud',
                health = GetEntityHealth(ped),
                armor = GetPedArmour(ped),
                hunger = playerData.hunger or 100,
                thirst = playerData.thirst or 100,
                money = playerData.money,
                job = playerData.job
            })
        end
    end
end)

RegisterNetEvent('srp:showNotification')
AddEventHandler('srp:showNotification', function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, false)
end)