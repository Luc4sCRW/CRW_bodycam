fx_version 'cerulean'
game 'gta5'

author 'Luc4s_CRW'
description 'Simple Bodycam | CRW_bodycam'
version '1.0.0'
lua54 'yes'

client_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'client.lua'
}

server_scripts {
    'config.lua',
    'server.lua'
}

shared_scripts {
    'locales.lua',
    'locales/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

server_export 'useBodycam'
