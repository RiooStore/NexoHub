-- [[ NEXO HUB - MASTER INITIALIZER ]]

-- 1. Load File Fitur/Core Terlebih Dahulu
local featureSuccess, featureError = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/username/repo/main/features.lua"))()
end)

if not featureSuccess then
    warn("NexoHub Error: Gagal memuat file fitur! (" .. tostring(featureError) .. ")")
end

-- 2. Jalankan File UI Setelah Fitur Selesai Dimuat
local uiSuccess, uiError = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/username/repo/main/ui.lua"))()
end)

if not uiSuccess then
    warn("NexoHub Error: Gagal memuat file UI! (" .. tostring(uiError) .. ")")
end
