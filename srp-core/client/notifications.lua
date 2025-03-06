local notificationQueue = {}

RegisterNetEvent('srp:showNotification')
AddEventHandler('srp:showNotification', function(msg, type)
    SendNUIMessage({
        type = 'notification',
        message = msg,
        nType = type or 'info'
    })
end)

-- Zaawansowane powiadomienia w świecie
function ShowAdvancedNotification(title, subject, msg, icon, color)
    AddTextEntry('srpNotify', msg)
    SetNotificationTextEntry('srpNotify')
    SetNotificationMessage(icon, icon, false, color or 1, title, subject)
    DrawNotification(false, false)
end

-- ShowAdvancedNotification('Szpital', 'EMS', 'Potrzebna pomoc medyczna!', 'CHAR_CALL911', 1)