-- [[ NEXO HUB - CORE FEATURES FILE (V11) ]]
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
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

-- Fungsi Pembantu: Menambahkan Log ke UI secara Real-time
local function AddLog(text)
    if _G.NexoHub_AddLogUI then
        _G.NexoHub_AddLogUI(text)
    end
end

-- [[ LOGIKA UTAMA MAKRO ]]
_G.NexoHub_Features = {
    SetWalkSpeed = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = v end end,
    SetJumpPower = function(v) if LocalPlayer.Character then LocalPlayer.Character.Humanoid.JumpPower = v end end,
    ResetStats = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end end,
    EnableInfJump = function() end,
    
    -- Mengatur nama makro yang aktif
    SetMacroName = function(name)
        MacroData.CurrentMacroName = name or "MAKRO_V1"
        AddLog("Nama makro disetel: " .. MacroData.CurrentMacroName)
    end,
    
    -- Toggle Auto Loop
    SetAutoLoop = function(state)
        MacroData.AutoLoop = state
        AddLog("Auto Loop: " .. (state and "ON" or "OFF"))
    end,

    -- Mulai Merekam
    StartRecord = function()
        if MacroData.IsPlaying then AddLog("Error: Tolong hentikan Playback!") return end
        MacroData.IsRecording = true
        MacroData.StartTime = tick()
        MacroData.Actions = {}
        AddLog("🔴 Perekaman dimulai untuk: " .. MacroData.CurrentMacroName)
        
        -- [[ DETEKSI AKSI BEE SWARM TOWER DEFENSE ]]
        -- Catatan: Ganti "RemoteEventName" sesuai dengan Remote Event asli dari game tersebut
        -- Kode di bawah ini adalah interseptor universal sebagai pondasi dasar
        local remotes = game:GetService("ReplicatedStorage")
        if remotes:FindFirstChild("RemoteEventName") then -- Ganti dengan Remote asli game
            _G.MacroConnection = remotes.RemoteEventName.OnClientEvent:Connect(function(actionType, unitName, position, extra)
                if MacroData.IsRecording then
                    local timeDelay = tick() - MacroData.StartTime
                    table.insert(MacroData.Actions, {
                        Action = actionType, -- "Spawn", "Upgrade", "Sell"
                        Unit = unitName,
                        Pos = {position.X, position.Y, position.Z},
                        Delay = timeDelay
                    })
                    AddLog(string.format("[%s] %s di posisi %.1f, %.1f", actionType, unitName, position.X, position.Z))
                end
            end)
        end
    end,

    -- Berhenti & Simpan Rekaman
    StopRecord = function()
        if not MacroData.IsRecording then return end
        MacroData.IsRecording = false
        if _G.MacroConnection then _G.MacroConnection:Disconnect() end
        
        -- Simpan ke file JSON di folder workspace
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        local json = HttpService:JSONEncode(MacroData.Actions)
        writefile(filePath, json)
        AddLog("💾 Berhasil menyimpan " .. #MacroData.Actions .. " aksi ke " .. MacroData.CurrentMacroName .. ".json")
    end,

    -- Jalankan Rekaman (Playback)
    PlayMacro = function()
        if MacroData.IsRecording then AddLog("Error: Tolong hentikan Perekaman!") return end
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        if not isfile(filePath) then AddLog("❌ File makro tidak ditemukan!") return end
        
        MacroData.IsPlaying = true
        AddLog("▶️ Menjalankan Makro: " .. MacroData.CurrentMacroName)
        
        local actions = HttpService:JSONDecode(readfile(filePath))
        
        task.spawn(function()
            repeat
                for _, act in ipairs(actions) do
                    if not MacroData.IsPlaying then break end
                    task.wait(act.Delay) -- Tunggu sesuai jeda waktu rekam asli
                    
                    -- Eksekusi balik ke game lewat Remote Event game tersebut
                    -- game:GetService("ReplicatedStorage").RemoteEventName:FireServer(act.Action, act.Unit, Vector3.new(act.Pos[1], act.Pos[2], act.Pos[3]))
                    
                    AddLog(string.format("Mengulang: %s %s", act.Action, act.Unit))
                end
                AddLog("✨ Playback Makro Selesai.")
            until not MacroData.AutoLoop or not MacroData.IsPlaying
            MacroData.IsPlaying = false
        end)
    end,

    -- Hentikan Playback
    StopMacro = function()
        MacroData.IsPlaying = false
        AddLog("⏹️ Playback dihentikan.")
    end,

    -- Hapus File Makro
    DeleteMacro = function()
        local filePath = "NexoHub/Macros/" .. MacroData.CurrentMacroName .. ".json"
        if isfile(filePath) then
            delfile(filePath)
            AddLog("🗑️ File " .. MacroData.CurrentMacroName .. " berhasil dihapus.")
        else
            AddLog("❌ Gagal menghapus, file tidak ada.")
        end
    end,
    
    -- Mengambil list semua file makro yang ada untuk dropdown/select
    GetMacroList = function()
        local list = {}
        for _, file in ipairs(listfiles("NexoHub/Macros")) do
            local cleanName = file:match("([^/]+)%.json$")
            if cleanName then table.insert(list, cleanName) end
        end
        return list
    end
}
print("NexoHub Features V11 Loaded Successfully!")
