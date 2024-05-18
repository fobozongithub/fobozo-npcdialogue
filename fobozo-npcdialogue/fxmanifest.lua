fx_version "adamant"
game "gta5"

name "fobozo-npcdialogue"
author "@fobozo"
version "2.0.0"

ui_page "src/ui/index.html"
files { "src/ui/**/**" }

shared_scripts { 'shared/*.lua' }
client_script 'src/client/*.lua'
server_scripts { 'src/server/*.lua', '@oxmysql/lib/MySQL.lua' }
