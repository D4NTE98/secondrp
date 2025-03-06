Config = {
    AllowedFirstNames = {"John", "Michael", "Emily", "Sarah"},
    StartingMoney = 5000,
    Jobs = {
        ['police'] = {label = 'Policja', grades = {[0] = 'Rekrut', [1] = 'Funkcjonariusz'}},
        ['ambulance'] = {label = 'EMS', grades = {[0] = 'Ratownik'}}
    },

    Needs = {
        hungerRate = 0.5,
        thirstRate = 1.0,
        damage = {
            hunger = 10,
            thirst = 20
        }
    },
    
    AntiCheat = {
        maxSpeed = 30.0, -- m/s
        teleportDistance = 100.0,
        allowedWeapons = {
            'WEAPON_KNIFE', 
            'WEAPON_NIGHTSTICK'
        }
    },
    
    RPCommands = {
        range = 15.0 
    }
}