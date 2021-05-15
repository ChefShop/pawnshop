fx_version 'adamant'
games {'gta5'};

author 'Chef#6502'
description 'Pawn Shop By chef'
version '1.0'

client_scripts {
    '@es_extended/locale.lua',
    'dependencies/menu.lua',
    'client/main.lua',
    'locales/fr.lua',
    'config.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    "@es_extended/locale.lua",
    'locales/fr.lua',
    'server/main.lua',
    'config.lua'
}