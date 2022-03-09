fx_version 'cerulean'
game "gta5"

version '1.0.0'
description 'Jerzys Billing for QB-Core'

github 'https://github.com/JZSandbox'
discord 'Jerzy#9709'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/assets/css/main.css',
    'html/assets/js/main.js',
}
shared_script 'config.lua'

client_scripts {
    'client/main.lua',

}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
