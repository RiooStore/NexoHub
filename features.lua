-- [[ NEXO HUB - CORE FEATURES FILE (V11.1 - SAFE HOOK) ]]
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Auto-Detect Game Name
local GameName = "NexoHub"
local success, result = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId).Name
end)
if success and result then GameName = result end
_G.NexoHub_GameName = GameName

-- [[ MACRO SYSTEM CONFIGURATION ]]
local MacroData = {
    IsRecording = false,
    IsPlaying = false,
    CurrentMacroName = "MAKRO_V1",
    StartTime = 0,
    Actions = {},
    AutoLoop = false
}

-- Pastikan folder utama NexoHub ada di Workspace Executor
if not isfolder("NexoHub") then makefolder("NexoHub") end
if not isfolder("NexoHub/Macros") then makefolder("NexoHub/Macros") end

-- Fungsi Pembantu: Menambahkan Log ke UI
local function AddLog(text)
    if _G.NexoHub_AddLogUI then
        _G.NexoHub_AddLogUI(text)
    end
end

-- =======================================================
-- [[ SAFE HOOK ENGINE - DETOUR METHOD (ANTI-FREEZE) ]]
-- =======================================================
local EventsFolder = game:GetService("ReplicatedStorage"):WaitForChild("Events")
local PlaceTowerRF = EventsFolder:WaitForChild("PlaceTower")
local UpgradeTowerRF = EventsFolder:WaitForChild("UpgradeTower")
local SellTowerRF = EventsFolder:WaitForChild("SellTower")

-- Trik Aman: Kita ambil fungsi asli InvokeServer bawaan Roblox
local rawInvokeServer = Instance.new("RemoteFunction").InvokeServer

local oldHook
oldHook = hookfunction(rawInvokeServer, function(self, ...)
    local args = {...}
    
    -- Pastikan script tidak memproses apa-apa kalau sedang tidak merekam (Biar Ringan & Anti-Lag)
    if MacroData.IsRecording then
        local timeDelay = tick() - MacroData.StartTime
        
        if self == PlaceTowerRF then
            table.insert(MacroData.Actions, {
                Type = "Place",
                Pos = {args[1].X, args[1].Y, args[1].Z},
                ID = args[2],
                Rot = args[3] or 0,
                Delay = timeDelay
            })
            AddLog("[RECORD] Place Unit Terdeteksi!")
            
        elseif self == UpgradeTowerRF then
            table.insert(MacroData.Actions, {
                Type = "Upgrade",
                TowerInstance = args[1],
                Delay = timeDelay
            })
            AddLog("[RECORD] Upgrade Unit Terdeteksi!")
            
        elseif self == SellTowerRF then
            table.insert(MacroData.Actions, {
                Type = "Sell",
                TowerInstance = args[1],
                Delay = timeDelay
            })
            AddLog("[RECORD] Sell Unit Terdeteksi!")
        end
    end
    
    return oldHook(self, ...)
end)

-- [[ LOGIKA MANAJEMEN MAKRO ]]
_G.NexoHub_Features = {
    SetWalkSpeed = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v end end,
    SetJumpPower = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = v end end,
    ResetStats = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end end,
    EnableInfJump = function() end,
    
    SetMacroName = function(name)
        MacroData.CurrentMacroName = name or "MAKRO_V1"
        AddLog("Nama file disetel: " .. MacroData.CurrentMacroName)
    end,
    
    SetAutoLoop = function(state)
        MacroData.AutoLoop = state
        AddLog("Auto Loop: " .. (state and "ON" or "OFF"))
    end,

    StartRecord = function()
        if MacroData.IsPlaying then AddLog("Error: Stop Playback dahulu!") return end
        MacroData.IsRecording = true
        MacroData.StartTime = tick()
        MacroData.Actions = {}
        AddLog("🔴 MEREKAM: Silakan taruh/upgrade unit di game...")
    end,

    StopRecord = function()
        if not MacroData.IsRecording then return end
        MacroData.IsRecording = false
        
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        local json = HttpService:JSONEncode(MacroData.Actions)
        writefile(filePath, json)
        AddLog(string.format("💾 Tersimpan %d aksi ke %s.json", #MacroData.Actions, MacroData.CurrentMacroName))
    end,

    PlayMacro = function()
        if MacroData.IsRecording then AddLog("Error: Stop Perekaman dahulu!") return end
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        if not isfile(filePath) then AddLog("❌ File tidak ditemukan!") return end
        
        MacroData.IsPlaying = true
        AddLog("▶️ Menjalankan Makro: " .. MacroData.CurrentMacroName)
        
        local actions = HttpService:JSONDecode(readfile(filePath))
        
        task.spawn(function()
            repeat
                local currentDelay = 0
                for _, act in ipairs(actions) do
                    if not MacroData.IsPlaying then break end
                    
                    local waitTime = act.Delay - currentDelay
                    if waitTime > 0 then task.wait(waitTime) end
                    currentDelay = act.Delay
                    
                    pcall(function()
                        if act.Type == "Place" then
                            local posVector = Vector3.new(act.Pos[1], act.Pos[2], act.Pos[3])
                            PlaceTowerRF:InvokeServer(posVector, act.ID, act.Rot)
                            AddLog("[PLAY] Menempatkan unit")
                        elseif act.Type == "Upgrade" then
                            UpgradeTowerRF:InvokeServer(act.TowerInstance)
                            AddLog("[PLAY] Melakukan Upgrade")
                        elseif act.Type == "Sell" then
                            SellTowerRF:InvokeServer(act.TowerInstance)
                            AddLog("[PLAY] Menjual unit")
                        end
                    end)
                end
                if MacroData.AutoLoop and MacroData.IsPlaying then
                    AddLog("🔁 Mengulang dari awal...")
                    task.wait(1)
                end
            until not MacroData.AutoLoop or not MacroData.IsPlaying
            MacroData.IsPlaying = false
            AddLog("✨ Playback Selesai.")
        end)
    end,

    StopMacro = function()
        MacroData.IsPlaying = false
        AddLog("⏹️ Playback dihentikan.")
    end,

    DeleteMacro = function()
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        if isfile(filePath) then
            delfile(filePath)
            AddLog("🗑️ File " .. MacroData.CurrentMacroName .. " terhapus.")
        else
            AddLog("❌ Gagal, file tidak ada.")
        end
    end
}
print("NexoHub Safe Hook System Active!")
