-- Made by @Tomić#9076

fx_version 'cerulean'
games { 'gta5' }

author "tomiichx"
description "Sports Betting FiveM / Kladionica FiveM"

version 'Tomić Development | v1.0'

shared_scripts {
  -- '@es_extended/imports.lua',
  'config.lua',
}

client_script 'cl_strana.lua'

server_scripts { 
  '@oxmysql/lib/MySQL.lua',
  'sv_strana.lua',
}

--[[
████████╗░█████╗░███╗░░░███╗██╗░█████╗░
╚══██╔══╝██╔══██╗████╗░████║██║██╔══██╗
░░░██║░░░██║░░██║██╔████╔██║██║██║░░╚═╝
░░░██║░░░██║░░██║██║╚██╔╝██║██║██║░░██╗
░░░██║░░░╚█████╔╝██║░╚═╝░██║██║╚█████╔╝
░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░╚════╝░
]]