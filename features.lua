-- [[ features.lua ]]
local Features = {}

function Features.Insert(UI_Library)
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- =======================================================
    -- [[ STRUCTURING CONTENT ]]
    -- =======================================================
    local T1 = UI_Library.CreateTab("ⓘ", "Info")
    local T2 = UI_Library.CreateTab("⚙", "Settings")
    local T3 = UI_Library.CreateTab("⚓", "Farm")
    local T4 = UI_Library.CreateTab("⚡", "Automatic")
    local T5 = UI_Library.CreateTab("💬", "Webhook")
    local T6 = UI_Library.CreateTab("🛠", "Utilities")

    local Cat1 = UI_Library.CreateCategory("Movement")
    local R1, L1, B1, S1 = UI_Library.CreateFeatureRow("WalkSpeed", "Set 100", function() LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
    local R2, L2, B2, S2 = UI_Library.CreateFeatureRow("JumpPower", "Set 120", function() LocalPlayer.Character.Humanoid.JumpPower = 120 end)
    local R3, L3, B3, S3 = UI_Library.CreateFeatureRow("Reset Speed & Jump", "Reset", function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end)

    local Cat2 = UI_Library.CreateCategory("Modes")
    local R4, L4, B4, S4 = UI_Library.CreateFeatureRow("Infinite Jump", "Enable", function() UserInputService.JumpRequest:Connect(function() LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping") end) end)

    -- Jalankan animasi bawaan UI dengan aset yang sudah dibuat
    local tabs = {T1, T2, T3, T4, T5, T6}
    local rows = {R1, R2, R3, R4}
    local elements = {Cat1, Cat2, L1, B1, L2, B2, L3, B3, L4, B4, S1, S2, S3, S4}
    
    UI_Library.ExecuteAnimations(tabs, rows, elements)
end

return Features
