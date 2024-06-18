fx_version 'cerulean'
games {'gta5'}

author 'Lithe Hub'
description 'Redzone PvP System'
version '1.0 (Semi-Stable [Should work])'

lua54 'yes'
this_is_a_map 'yes'

client_script {
    'config.lua',
    'client/*.lua',
    'UTIIL/client.lua',
    'UTIIL/BoxZone.lua',
    'UTIIL/EntityZone.lua',
    'UTIIL/CircleZone.lua',
    'UTIIL/ComboZone.lua',
    'UTIIL/creation/client/*.lua',
}

server_script {
    'server.lua',
    'UTIIL/creation/server/*.lua',
    'UTIIL/server.lua',
}
