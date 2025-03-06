fx_version 'cerulean'
game 'gta5'

name 'SecondRP'
author 'D4NTE98'
version '1.0.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/jobs.lua',
    'server/inventory.lua',
    'server/accounts.lua',
    'server/anticheat.lua',
}

client_scripts {
    'client/main.lua',
    'client/hud.lua',
    'client/vehicle.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/assets/**.*'
}