Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        
        for src, player in pairs(Players) do
            if player.hunger > 0 then
                player.hunger = player.hunger - 1
            else
                SetEntityHealth(GetPlayerPed(src), GetEntityHealth(GetPlayerPed(src)) - 10)
            end
            
            if player.thirst > 0 then
                player.thirst = player.thirst - 2
            else
                SetEntityHealth(GetPlayerPed(src), GetEntityHealth(GetPlayerPed(src)) - 20)
            end
            
            TriggerClientEvent('srp:updateNeeds', src, player.hunger, player.thirst)
        end
    end
end)