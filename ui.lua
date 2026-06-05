-- [[ NEXO HUB - PREMIUM UI MULTI-TAB & FARM MACRO (V11 REVISED - FIXED) ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Ambil nama game dari global
local GameName = _G.NexoHub_GameName or "NexoHub"

if CoreGui:FindFirstChild("NexoHubUI") then
    CoreGui.NexoHubUI:Destroy()
end

-- [[ FIXED ENVIRONMENT WRAPPER: Mencegah UI Stuck/Gagal Muncul ]]
if not _G.NexoHub_Features then
    _G.NexoHub_Features = {
        SetWalkSpeed = function(val) print("Walkspeed set to:", val) end,
        SetJumpPower = function(val) print("JumpPower set to:", val) end,
        ResetStats = function() print("Stats reset") end,
        EnableInfJump = function() print("InfJump Toggled") end,
        SetMacroName = function(txt) print("Macro Name:", txt) end,
        StartRecord = function() print("Recording started") end,
        StopRecord = function() print("Recording stopped") end,
        PlayMacro = function() print("Playback started") end,
        StopMacro = function() print("Playback stopped") end,
        DeleteMacro = function() print("Macro deleted") end,
        SetAutoLoop = function(val) print("Loop set to:", val) end
    }
end

local NexoHubUI = Instance.new("ScreenGui")
NexoHubUI.Name = "NexoHubUI"
NexoHubUI.Parent = CoreGui
NexoHubUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =======================================================
-- [[ 1. INTRO LOADING SCREEN ]]
-- =======================================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Parent = NexoHubUI
IntroFrame.BackgroundTransparency = 1
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.ZIndex = 10

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Parent = IntroFrame
IntroTitle.BackgroundTransparency = 1
IntroTitle.Position = UDim2.new(0.5, -250, 0.4, -40)
IntroTitle.Size = UDim2.new(0, 500, 0, 80)
IntroTitle.Font = Enum.Font.GothamBold
IntroTitle.Text = "NEXO HUB"
IntroTitle.TextSize = 65
IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255) -- Diubah ke putih agar terlihat solid di latar gelap
IntroTitle.TextTransparency = 1

local LoadingSpinner = Instance.new("ImageLabel")
LoadingSpinner.Parent = IntroFrame
LoadingSpinner.BackgroundTransparency = 1
LoadingSpinner.Position = UDim2.new(0.5, -25, 0.55, 0)
LoadingSpinner.Size = UDim2.new(0, 50, 0, 50)
LoadingSpinner.Image = "rbxassetid://6031267431" 
LoadingSpinner.ImageColor3 = Color3.fromRGB(255, 255, 255)
LoadingSpinner.ImageTransparency = 1

-- =======================================================
-- [[ 2. MAIN MENU WINDOW ]]
-- =======================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = NexoHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.Position = UDim2.new(0.5, -315, 0.5, -195)
MainFrame.Size = UDim2.new(0, 630, 0, 390)
MainFrame.ClipsDescendants = true
MainFrame.BackgroundTransparency = 1 

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.2
MainStroke.Color = Color3.fromRGB(70, 70, 75)
MainStroke.Transparency = 1 
MainStroke.Parent = MainFrame

local HeaderZone = Instance.new("Frame")
HeaderZone.Name = "HeaderZone"
HeaderZone.Parent = MainFrame
HeaderZone.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
HeaderZone.Size = UDim2.new(1, 0, 0, 55)
HeaderZone.BackgroundTransparency = 1
HeaderZone.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 14)
HeaderCorner.Parent = HeaderZone

local HubIcon = Instance.new("ImageLabel")
HubIcon.Parent = HeaderZone
HubIcon.BackgroundTransparency = 1
HubIcon.Position = UDim2.new(0, 16, 0, 14)
HubIcon.Size = UDim2.new(0, 28, 0, 28)
HubIcon.Image = "rbxassetid://6023426926" 
HubIcon.ImageTransparency = 1

local TitleMain = Instance.new("TextLabel")
TitleMain.Parent = HeaderZone
TitleMain.BackgroundTransparency = 1
TitleMain.Position = UDim2.new(0, 54, 0, 11)
TitleMain.Size = UDim2.new(0, 350, 0, 18) 
TitleMain.Font = Enum.Font.GothamBold
TitleMain.Text = "NexoHub - " .. GameName
TitleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleMain.TextSize = 16 
TitleMain.TextXAlignment = Enum.TextXAlignment.Left
TitleMain.TextTransparency = 1

local TitleSub = Instance.new("TextLabel")
TitleSub.Parent = HeaderZone
TitleSub.BackgroundTransparency = 1
TitleSub.Position = UDim2.new(0, 54, 0, 30)
TitleSub.Size = UDim2.new(0, 250, 0, 14)
TitleSub.Font = Enum.Font.GothamMedium
TitleSub.Text = "Premium Version"
TitleSub.TextColor3 = Color3.fromRGB(150, 150, 155)
TitleSub.TextSize = 12
TitleSub.TextXAlignment = Enum.TextXAlignment.Left
TitleSub.TextTransparency = 1

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Parent = HeaderZone
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -48, 0, 14)
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
MinimizeBtn.TextSize = 16
MinimizeBtn.TextTransparency = 1

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 16) 
Sidebar.Position = UDim2.new(0, 0, 0, 55) 
Sidebar.Size = UDim2.new(0, 165, 1, -55)
Sidebar.BackgroundTransparency = 1
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 14)
SidebarCorner.Parent = Sidebar

local TabContainer = Instance.new("Frame")
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 12, 0, 12)
TabContainer.Size = UDim2.new(1, -20, 1, -24)

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 6)

local VerticalDivider = Instance.new("Frame")
VerticalDivider.Name = "VerticalDivider"
VerticalDivider.Parent = MainFrame
VerticalDivider.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
VerticalDivider.BorderSizePixel = 0
VerticalDivider.Position = UDim2.new(0, 165, 0, 55)
VerticalDivider.Size = UDim2.new(0, 1, 1, -55)
VerticalDivider.BackgroundTransparency = 1

local ResizeBtn = Instance.new("ImageButton")
ResizeBtn.Name = "ResizeBtn"
ResizeBtn.Parent = MainFrame
ResizeBtn.BackgroundTransparency = 1
ResizeBtn.Position = UDim2.new(1, -15, 1, -15)
ResizeBtn.Size = UDim2.new(0, 12, 0, 12)
ResizeBtn.Image = "rbxassetid://3926307971"
ResizeBtn.ImageColor3 = Color3.fromRGB(140, 140, 145)
ResizeBtn.ZIndex = 6
ResizeBtn.ImageTransparency = 1

local LogoBtn = Instance.new("TextButton")
LogoBtn.Name = "LogoBtn"
LogoBtn.Parent = NexoHubUI
LogoBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
LogoBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
LogoBtn.Size = UDim2.new(0, 55, 0, 55)
LogoBtn.Font = Enum.Font.GothamBold
LogoBtn.Text = "N"
LogoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoBtn.TextSize = 26
LogoBtn.Visible = false
LogoBtn.ZIndex = 15

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0)
LogoCorner.Parent = LogoBtn

-- =======================================================
-- [[ 3. MULTI-TAB PAGE ENGINE CONTAINER ]]
-- =======================================================
local Pages = {}
local TabButtons = {}

local function CreatePage(id)
    local ContentContainer = Instance.new("ScrollingFrame")
    ContentContainer.Name = "Page_" .. id
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1 
    ContentContainer.Position = UDim2.new(0, 182, 0, 70)
    ContentContainer.Size = UDim2.new(1, -198, 1, -88)
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentContainer.ScrollBarThickness = 4
    ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 125)
    ContentContainer.Active = true
    ContentContainer.Visible = false

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentContainer
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    Pages[id] = ContentContainer
    return ContentContainer
end

local function SwitchToTab(id)
    for pageId, frame in pairs(Pages) do
        frame.Visible = (pageId == id)
    end
    for btnId, btn in pairs(TabButtons) do
        if btnId == id then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(48, 48, 54), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(36, 36, 40), TextColor3 = Color3.fromRGB(175, 175, 180)}):Play()
        end
    end
end

-- =======================================================
-- [[ 4. DYNAMIC INTERFACE BUILDERS ]]
-- =======================================================
local function CreateTab(icon, name, id)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabContainer
    TabBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 40)
    TabBtn.Size = UDim2.new(1, 0, 0, 42) 
    TabBtn.Font = Enum.Font.GothamBold 
    TabBtn.Text = "  " .. icon .. "   " .. name
    TabBtn.TextColor3 = Color3.fromRGB(175, 175, 180)
    TabBtn.TextSize = 16 
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.AutoButtonColor = false
    TabBtn.TextTransparency = 1
    TabBtn.BackgroundTransparency = 1
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10) 
    BtnCorner.Parent = TabBtn
    
    TabBtn.MouseEnter:Connect(function() 
        if Pages[id].Visible == false then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(48, 48, 54), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() 
        end
    end)
    TabBtn.MouseLeave:Connect(function() 
        if Pages[id].Visible == false then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(36, 36, 40), TextColor3 = Color3.fromRGB(175, 175, 180)}):Play() 
        end
    end)
    
    TabBtn.MouseButton1Click:Connect(function()
        SwitchToTab(id)
    end)
    
    TabButtons[id] = TabBtn
    return TabBtn
end

local function CreateCategory(parentPage, title)
    local CategoryLabel = Instance.new("TextLabel")
    CategoryLabel.Parent = parentPage
    CategoryLabel.BackgroundTransparency = 1
    CategoryLabel.Size = UDim2.new(1, 0, 0, 32)
    CategoryLabel.Font = Enum.Font.GothamBold
    CategoryLabel.Text = title
    CategoryLabel.TextColor3 = Color3.fromRGB(255, 255, 255) 
    CategoryLabel.TextSize = 22 
    CategoryLabel.TextXAlignment = Enum.TextXAlignment.Left
    CategoryLabel.TextTransparency = 1
    return CategoryLabel
end

local function CreateFeatureRow(parentPage, text, btnText, callback)
    local RowFrame = Instance.new("Frame")
    RowFrame.Parent = parentPage
    RowFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32) 
    RowFrame.Size = UDim2.new(1, -12, 0, 48) 
    RowFrame.BackgroundTransparency = 1 

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 8) 
    RowCorner.Parent = RowFrame

    local RowStroke = Instance.new("UIStroke")
    RowStroke.Thickness = 1.2
    RowStroke.Color = Color3.fromRGB(80, 80, 85) 
    RowStroke.Transparency = 1
    RowStroke.Parent = RowFrame

    local FeatureLabel = Instance.new("TextLabel")
    FeatureLabel.Parent = RowFrame
    FeatureLabel.BackgroundTransparency = 1
    FeatureLabel.Position = UDim2.new(0, 20, 0, 0) 
    FeatureLabel.Size = UDim2.new(0.55, 0, 1, 0)
    FeatureLabel.Font = Enum.Font.GothamMedium
    FeatureLabel.Text = text
    FeatureLabel.TextColor3 = Color3.fromRGB(250, 250, 255)
    FeatureLabel.TextSize = 16 
    FeatureLabel.TextXAlignment = Enum.TextXAlignment.Left
    FeatureLabel.TextTransparency = 1

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Parent = RowFrame
    ActionBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 64) 
    ActionBtn.Position = UDim2.new(1, -105, 0, 9) 
    ActionBtn.Size = UDim2.new(0, 95, 0, 30)
    ActionBtn.Font = Enum.Font.GothamSemibold
    ActionBtn.Text = btnText
    ActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ActionBtn.TextSize = 13 
    ActionBtn.AutoButtonColor = false
    ActionBtn.TextTransparency = 1
    ActionBtn.BackgroundTransparency = 1

    local ActCorner = Instance.new("UICorner")
    ActCorner.CornerRadius = UDim.new(0, 6)
    ActCorner.Parent = ActionBtn

    ActionBtn.MouseEnter:Connect(function() TweenService:Create(ActionBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(78, 78, 85)}):Play() end)
    ActionBtn.MouseLeave:Connect(function() TweenService:Create(ActionBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(58, 58, 64)}):Play() end)
    
    ActionBtn.MouseButton1Click:Connect(function() 
        ActionBtn.Size = UDim2.new(0, 90, 0, 28)
        task.wait(0.05)
        ActionBtn.Size = UDim2.new(0, 95, 0, 30)
        if callback then callback() end 
    end)

    RowFrame.MouseEnter:Connect(function() TweenService:Create(RowStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(130, 130, 135)}):Play() end)
    RowFrame.MouseLeave:Connect(function() TweenService:Create(RowStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 85)}):Play() end)

    return RowFrame, FeatureLabel, ActionBtn, RowStroke
end

local function CreateTextBoxRow(parentPage, text, placeholder, callback)
    local RowFrame = Instance.new("Frame")
    RowFrame.Parent = parentPage
    RowFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32) 
    RowFrame.Size = UDim2.new(1, -12, 0, 48) 
    RowFrame.BackgroundTransparency = 1 

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 8) 
    RowCorner.Parent = RowFrame

    local RowStroke = Instance.new("UIStroke")
    RowStroke.Thickness = 1.2
    RowStroke.Color = Color3.fromRGB(80, 80, 85) 
    RowStroke.Transparency = 1
    RowStroke.Parent = RowFrame

    local FeatureLabel = Instance.new("TextLabel")
    FeatureLabel.Parent = RowFrame
    FeatureLabel.BackgroundTransparency = 1
    FeatureLabel.Position = UDim2.new(0, 20, 0, 0) 
    FeatureLabel.Size = UDim2.new(0.45, 0, 1, 0)
    FeatureLabel.Font = Enum.Font.GothamMedium
    FeatureLabel.Text = text
    FeatureLabel.TextColor3 = Color3.fromRGB(250, 250, 255)
    FeatureLabel.TextSize = 16 
    FeatureLabel.TextXAlignment = Enum.TextXAlignment.Left
    FeatureLabel.TextTransparency = 1

    local InputBox = Instance.new("TextBox")
    InputBox.Parent = RowFrame
    InputBox.BackgroundColor3 = Color3.fromRGB(44, 44, 50)
    InputBox.Position = UDim2.new(1, -165, 0, 9)
    InputBox.Size = UDim2.new(0, 155, 0, 30)
    InputBox.Font = Enum.Font.GothamSemibold
    InputBox.Text = placeholder
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.TextSize = 13
    InputBox.ClipsDescendants = true
    InputBox.TextTransparency = 1
    InputBox.BackgroundTransparency = 1

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = InputBox

    InputBox.FocusLost:Connect(function()
        if callback then callback(InputBox.Text) end
    end)

    return RowFrame, FeatureLabel, InputBox, RowStroke
end

-- =======================================================
-- [[ 5. ALLOCATION REGISTER FOR PAGES ]]
-- =======================================================
local InfoPage = CreatePage("info")
local FarmPage = CreatePage("farm")
local SettingsPage = CreatePage("settings")
local AutoPage = CreatePage("auto")
local WebhookPage = CreatePage("webhook")
local UtilsPage = CreatePage("utils")

local T1 = CreateTab("ⓘ", "Info", "info")
local T2 = CreateTab("⚓", "Farm", "farm")
local T3 = CreateTab("⚙", "Settings", "settings")
local T4 = CreateTab("⚡", "Automatic", "auto")
local T5 = CreateTab("💬", "Webhook", "webhook")
local T6 = CreateTab("🛠", "Utilities", "utils")

-- =======================================================
-- [[ CONTENT LAYOUT POPULATION ]]
-- =======================================================
local Cat1 = CreateCategory(InfoPage, "Movement")
local R1, L1, B1, S1 = CreateFeatureRow(InfoPage, "WalkSpeed", "Set 100", function() if _G.NexoHub_Features then _G.NexoHub_Features.SetWalkSpeed(100) end end)
local R2, L2, B2, S2 = CreateFeatureRow(InfoPage, "JumpPower", "Set 120", function() if _G.NexoHub_Features then _G.NexoHub_Features.SetJumpPower(120) end end)
local R3, L3, B3, S3 = CreateFeatureRow(InfoPage, "Reset Speed & Jump", "Reset", function() if _G.NexoHub_Features then _G.NexoHub_Features.ResetStats() end end)

local Cat2 = CreateCategory(InfoPage, "Modes")
local R4, L4, B4, S4 = CreateFeatureRow(InfoPage, "Infinite Jump", "Enable", function() if _G.NexoHub_Features then _G.NexoHub_Features.EnableInfJump() end end)

local CatFarm1 = CreateCategory(FarmPage, "Macro Recorder Engine")

local RF1, LF1, IF1, SF1 = CreateTextBoxRow(FarmPage, "Nama File Makro", "MAKRO_V1", function(txt)
    if _G.NexoHub_Features then _G.NexoHub_Features.SetMacroName(txt) end
end)

local RF2, LF2, BF2, SF2 = CreateFeatureRow(FarmPage, "Mulai Rekam Makro", "RECORD", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StartRecord() end
end)

local RF3, LF3, BF3, SF3 = CreateFeatureRow(FarmPage, "Berhenti & Simpan", "STOP REC", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StopRecord() end
end)

local RF4, LF4, BF4, SF4 = CreateFeatureRow(FarmPage, "Putar Ulang Makro", "PLAY", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.PlayMacro() end
end)

local RF5, LF5, BF5, SF5 = CreateFeatureRow(FarmPage, "Hentikan Pemutaran", "STOP PLAY", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StopMacro() end
end)

local RF6, LF6, BF6, SF6 = CreateFeatureRow(FarmPage, "Hapus File Makro", "DELETE", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.DeleteMacro() end
end)

local RF7, LF7, BF7, SF7 = CreateFeatureRow(FarmPage, "Putar Otomatis (Loop)", "LOOP: OFF", function() end)
BF7.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
local isLooping = false
BF7.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    BF7.Text = isLooping and "LOOP: ON" or "LOOP: OFF"
    BF7.BackgroundColor3 = isLooping and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(150, 40, 40)
    if _G.NexoHub_Features then _G.NexoHub_Features.SetAutoLoop(isLooping) end
end)

local CatFarm2 = CreateCategory(FarmPage, "Macro Console Monitoring Log")
local LogContainer = Instance.new("Frame")
LogContainer.Parent = FarmPage
LogContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
LogContainer.Size = UDim2.new(1, -12, 0, 110)
LogContainer.BackgroundTransparency = 1
local LogCrnr = Instance.new("UICorner") ; LogCrnr.CornerRadius = UDim.new(0, 8) ; LogCrnr.Parent = LogContainer
local LogStroke = Instance.new("UIStroke") ; LogStroke.Thickness = 1.2 ; LogStroke.Color = Color3.fromRGB(60, 60, 65) ; LogStroke.Transparency = 1 ; LogStroke.Parent = LogContainer

local LogText = Instance.new("TextLabel")
LogText.Parent = LogContainer
LogText.BackgroundTransparency = 1
LogText.Position = UDim2.new(0, 15, 0, 10)
LogText.Size = UDim2.new(1, -30, 1, -20)
LogText.Font = Enum.Font.Code
LogText.Text = "Sistem makro siap...\nMenunggu instruksi perekaman aksi."
LogText.TextColor3 = Color3.fromRGB(100, 230, 100)
LogText.TextSize = 12
LogText.TextXAlignment = Enum.TextXAlignment.Left
LogText.TextYAlignment = Enum.TextYAlignment.Top
LogText.TextTransparency = 1

_G.NexoHub_AddLogUI = function(msg)
    local currentText = LogText.Text
    local lines = {}
    for line in string.gmatch(currentText, "[^\n]+") do table.insert(lines, line) end
    if #lines >= 5 then table.remove(lines, 1) end
    table.insert(lines, msg)
    LogText.Text = table.concat(lines, "\n")
end

SwitchToTab("info")

-- =======================================================
-- [[ 6. DRAG & RESIZE ENGINE SYSTEMS ]]
-- =======================================================
local function MakeDraggable(clickObj, frameObj)
    local dragStart, startPos, dragging = nil, nil, false
    clickObj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frameObj.Position
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragStart and startPos then
            local mousePos = UserInputService:GetMouseLocation()
            local delta = Vector3.new(mousePos.X, mousePos.Y - 36, 0) - dragStart
            frameObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

MakeDraggable(HeaderZone, MainFrame)
MakeDraggable(LogoBtn, LogoBtn)

local resizing, resizeStart, startSize = false, nil, nil
ResizeBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        resizing = true; resizeStart = input.Position; startSize = MainFrame.Size
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then resizing = false end
end)
RunService.RenderStepped:Connect(function()
    if resizing and resizeStart and startSize then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = Vector3.new(mousePos.X, mousePos.Y - 36, 0) - resizeStart
        local newWidth = math.clamp(startSize.X.Offset + delta.X, 540, 880)
        local newHeight = math.clamp(startSize.Y.Offset + delta.Y, 360, 600)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    LogoBtn.Visible = true
    LogoBtn.Size = UDim2.new(0, 10, 0, 10)
    TweenService:Create(LogoBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)

LogoBtn.MouseButton1Click:Connect(function()
    LogoBtn.Visible = false
    MainFrame.Visible = true
end)

-- =======================================================
-- [[ 7. ANIMATION EXECUTION CORE ]]
-- =======================================================
TweenService:Create(IntroTitle, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
TweenService:Create(LoadingSpinner, TweenInfo.new(0.4), {ImageTransparency = 0}):Play()

local startTime = tick()
coroutine.wrap(function()
    while tick() - startTime < 2.2 do
        LoadingSpinner.Rotation = LoadingSpinner.Rotation + 6
        task.wait(0.01)
    end
end)()
task.wait(2.2)

TweenService:Create(IntroTitle, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
TweenService:Create(LoadingSpinner, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
task.wait(0.3)
IntroFrame:Destroy()

-- Buka Main Frame Solid
MainFrame.Size = UDim2.new(0, 630, 0, 55)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2.new(0, 630, 0, 390)}):Play()
TweenService:Create(MainStroke, TweenInfo.new(0.5), {Transparency = 0.2}):Play()

TweenService:Create(HeaderZone, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(Sidebar, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
task.wait(0.4)

TweenService:Create(VerticalDivider, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
TweenService:Create(HubIcon, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
TweenService:Create(TitleMain, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(TitleSub, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
TweenService:Create(ResizeBtn, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()

local tabs = {T1, T2, T3, T4, T5, T6}
for _, tab in ipairs(tabs) do
    TweenService:Create(tab, TweenInfo.new(0.2), {TextTransparency = 0, BackgroundTransparency = 0}):Play()
end

-- Aktifkan Seluruh Konten Baris Menu Secara Solid Sempurna
local rows = {R1, R2, R3, R4, RF1, RF2, RF3, RF4, RF5, RF6, RF7, LogContainer}
for _, row in ipairs(rows) do
    TweenService:Create(row, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play() 
end

local elements = {Cat1, Cat2, CatFarm1, CatFarm2, L1, B1, L2, B2, L3, B3, L4, B4, LF1, IF1, LF2, BF2, LF3, BF3, LF4, BF4, LF5, BF5, LF6, BF6, LF7, BF7, LogText, S1, S2, S3, S4, SF1, SF2, SF3, SF4, SF5, SF6, SF7, LogStroke}
for _, elem in ipairs(elements) do
    if elem:IsA("TextLabel") or elem:IsA("TextButton") or elem:IsA("TextBox") then
        TweenService:Create(elem, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
    end
    if elem:IsA("TextButton") or elem:IsA("TextBox") then
        TweenService:Create(elem, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
    if elem:IsA("UIStroke") then
        TweenService:Create(elem, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end
end
