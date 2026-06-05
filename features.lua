-- [[ NEXO HUB - CORE FEATURES FILE ]]
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- Auto-Detect Game Name
local GameName = "NexoHub"
local success, result = pcall(function()
    return MarketplaceService:GetProductInfo(game.PlaceId).Name
end)
if success and result then GameName = result end

-- Daftarkan ke Global Variable agar bisa dibaca oleh File UI
_G.NexoHub_GameName = GameName

-- Buat table global untuk menyimpan semua fungsi fitur
_G.NexoHub_Features = {
    SetWalkSpeed = function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
        end
    end,
    
    SetJumpPower = function(value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
        end
    end,
    
    ResetStats = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
        end
    end,
    
    EnableInfJump = function()
        if not _G.InfJumpConnected then
            _G.InfJumpConnected = true
            UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
                end
            end)
        end
    end
}

print("NexoHub Features Loaded for game: " .. GameName)
