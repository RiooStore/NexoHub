-- [[ main.lua ]]
-- Taruh link raw github/pastebin dari file ui.lua dan features.lua kamu di sini:
local URL_UI = "https://raw.githubusercontent.com/RiooStore/NexoHub/main/ui.lua"
local URL_FEATURES = "https://raw.githubusercontent.com/RiooStore/NexoHub/main/features.lua"

local UI_Module = loadstring(game:HttpGet(URL_UI))()
local Features_Module = loadstring(game:HttpGet(URL_FEATURES))()

-- Menyatukan UI asli dengan Fitur tanpa merusak kode
local UI_Library = UI_Module.Create()
Features_Module.Insert(UI_Library)
