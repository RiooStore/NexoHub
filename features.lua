-- [[ NEXO HUB - CORE FEATURES FILE (V11 - HOOK VERSION) ]]
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
-- [[ HOOKING ENGINE - DETEKSI OTOMATIS REMOTEFUNCTION ]]
-- =======================================================
local EventsFolder = game:GetService("ReplicatedStorage"):WaitForChild("Events")
local PlaceTowerRF = EventsFolder:WaitForChild("PlaceTower")
local UpgradeTowerRF = EventsFolder:WaitForChild("UpgradeTower")
local SellTowerRF = EventsFolder:WaitForChild("SellTower")

-- Hook PlaceTower
local oldPlace = hookmetamethod(PlaceTowerRF, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if self == PlaceTowerRF and method == "InvokeServer" and MacroData.IsRecording then
        local timeDelay = tick() - MacroData.StartTime
        -- args[1] = Vector3, args[2] = Tower ID/Name, args[3] = Rotation
        table.insert(MacroData.Actions, {
            Type = "Place",
            Pos = {args[1].X, args[1].Y, args[1].Z},
            ID = args[2],
            Rot = args[3] or 0,
            Delay = timeDelay
        })
        AddLog(string.format("[PLACE] ID: %s", string.sub(tostring(args[2]), 1, 8) .. "..."))
    end
    return oldPlace(self, ...)
end)

-- Hook UpgradeTower
local oldUpgrade = hookmetamethod(UpgradeTowerRF, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if self == UpgradeTowerRF and method == "InvokeServer" and MacroData.IsRecording then
        local timeDelay = tick() - MacroData.StartTime
        -- args[1] = Unique Instance ID dari tower yang di-upgrade
        table.insert(MacroData.Actions, {
            Type = "Upgrade",
            TowerInstance = args[1],
            Delay = timeDelay
        })
        AddLog("[UPGRADE] Unit berhasil direkam")
    end
    return oldUpgrade(self, ...)
end)

-- Hook SellTower
local oldSell = hookmetamethod(SellTowerRF, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if self == SellTowerRF and method == "InvokeServer" and MacroData.IsRecording then
        local timeDelay = tick() - MacroData.StartTime
        -- args[1] = Unique Instance ID dari tower yang dijual
        table.insert(MacroData.Actions, {
            Type = "Sell",
            TowerInstance = args[1],
            Delay = timeDelay
        })
        AddLog("[SELL] Unit berhasil direkam")
    end
    return oldSell(self, ...)
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
        AddLog("🔴 MEREKAM AKSI: Jalankan game seperti biasa...")
    end,

    StopRecord = function()
        if not MacroData.IsRecording then return end
        MacroData.IsRecording = false
        
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        local json = HttpService:JSONEncode(MacroData.Actions)
        writefile(filePath, json)
        AddLog(string.format("💾 Berhasil menyimpan %d aksi ke %s.json", #MacroData.Actions, MacroData.CurrentMacroName))
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
                    
                    -- Kalkulasi jeda waktu asli antar aksi
                    local waitTime = act.Delay - currentDelay
                    if waitTime > 0 then task.wait(waitTime) end
                    currentDelay = act.Delay
                    
                    -- Eksekusi berdasarkan tipe aksi yang terekam
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
print("NexoHub Core Feature V11 Hook System Active!")
