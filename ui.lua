-- [[ NEXO HUB - SYSTEM INTERFACE WITH MULTI-TAB & FARM MACRO (V11) ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local GameName = _G.NexoHub_GameName or "NexoHub"

if CoreGui:FindFirstChild("NexoHubUI") then CoreGui.NexoHubUI:Destroy() end

local NexoHubUI = Instance.new("ScreenGui")
NexoHubUI.Name = "NexoHubUI"
NexoHubUI.Parent = CoreGui

-- =======================================================
-- [[ WINDOW FRAME SETUP ]]
-- =======================================================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = NexoHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.Position = UDim2.new(0.5, -315, 0.5, -195)
MainFrame.Size = UDim2.new(0, 630, 0, 390)
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- TOPBAR
local HeaderZone = Instance.new("Frame")
HeaderZone.Parent = MainFrame
HeaderZone.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
HeaderZone.Size = UDim2.new(1, 0, 0, 55)

local TitleMain = Instance.new("TextLabel")
TitleMain.Parent = HeaderZone
TitleMain.BackgroundTransparency = 1
TitleMain.Position = UDim2.new(0, 20, 0, 11)
TitleMain.Size = UDim2.new(0, 450, 0, 18)
TitleMain.Font = Enum.Font.GothamBold
TitleMain.Text = "NexoHub - " .. GameName
TitleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleMain.TextSize = 16
TitleMain.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = HeaderZone
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -48, 0, 14)
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
MinimizeBtn.TextSize = 16

-- SIDEBAR KIRI
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
Sidebar.Position = UDim2.new(0, 0, 0, 55)
Sidebar.Size = UDim2.new(0, 165, 1, -55)

local TabContainer = Instance.new("Frame")
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 12, 0, 12)
TabContainer.Size = UDim2.new(1, -24, 1, -24)

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.Padding = UDim.new(0, 6)

-- WIDGET HALAMAN KANAN (Multi-Tab Core)
local Pages = {}

local function CreatePage(id)
    local PageFrame = Instance.new("ScrollingFrame")
    PageFrame.Name = "Page_" .. id
    PageFrame.Parent = MainFrame
    PageFrame.BackgroundTransparency = 1
    PageFrame.Position = UDim2.new(0, 182, 0, 70)
    PageFrame.Size = UDim2.new(1, -198, 1, -88)
    PageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    PageFrame.ScrollBarThickness = 4
    PageFrame.Visible = false
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = PageFrame
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
    end)
    
    Pages[id] = PageFrame
    return PageFrame
end

local function SwitchToTab(id)
    for pageId, pageFrame in pairs(Pages) do
        pageFrame.Visible = (pageId == id)
    end
end

-- =======================================================
-- [[ INTERFACE BUILDERS ]]
-- =======================================================
local function CreateTabButton(icon, name, id)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabContainer
    TabBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    TabBtn.Size = UDim2.new(1, 0, 0, 42)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.Text = " " .. icon .. "  " .. name
    TabBtn.TextColor3 = Color3.fromRGB(180, 180, 185)
    TabBtn.TextSize = 14
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = TabBtn
    
    TabBtn.MouseButton1Click:Connect(function()
        SwitchToTab(id)
    end)
    return TabBtn
end

local function AddCategory(parent, title)
    local Lbl = Instance.new("TextLabel")
    Lbl.Parent = parent
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, 0, 0, 30)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.Text = title
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.TextSize = 18
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
end

local function AddButtonRow(parent, labelText, btnText, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    Frame.Size = UDim2.new(1, -12, 0, 48)
    
    local Crnr = Instance.new("UICorner")
    Crnr.CornerRadius = UDim.new(0, 8)
    Crnr.Parent = Frame
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Parent = Frame
    Lbl.BackgroundTransparency = 1
    Lbl.Position = UDim2.new(0, 15, 0, 0)
    Lbl.Size = UDim2.new(0.6, 0, 1, 0)
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.Text = labelText
    Lbl.TextColor3 = Color3.fromRGB(240, 240, 245)
    Lbl.TextSize = 14
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local Btn = Instance.new("TextButton")
    Btn.Parent = Frame
    Btn.BackgroundColor3 = Color3.fromRGB(58, 58, 64)
    Btn.Position = UDim2.new(1, -105, 0, 9)
    Btn.Size = UDim2.new(0, 95, 0, 30)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = btnText
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
    return Frame
end

-- Input Text Box Khusus untuk Setting Nama Makro
local function AddTextBoxRow(parent, labelText, defaultText, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    Frame.Size = UDim2.new(1, -12, 0, 48)
    
    local Crnr = Instance.new("UICorner")
    Crnr.CornerRadius = UDim.new(0, 8)
    Crnr.Parent = Frame
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Parent = Frame
    Lbl.BackgroundTransparency = 1
    Lbl.Position = UDim2.new(0, 15, 0, 0)
    Lbl.Size = UDim2.new(0.5, 0, 1, 0)
    Lbl.Font = Enum.Font.GothamMedium
    Lbl.Text = labelText
    Lbl.TextColor3 = Color3.fromRGB(240, 240, 245)
    Lbl.TextSize = 14
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local Box = Instance.new("TextBox")
    Box.Parent = Frame
    Box.BackgroundColor3 = Color3.fromRGB(40, 40, 44)
    Box.Position = UDim2.new(1, -155, 0, 9)
    Box.Size = UDim2.new(0, 145, 0, 30)
    Box.Font = Enum.Font.GothamSemibold
    Box.Text = defaultText
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 12
    
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 6)
    BCorner.Parent = Box
    
    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)
end

-- =======================================================
-- [[ GENERATE TABS & PAGES ]]
-- =======================================================
CreateTabButton("ⓘ", "Info", "info")
CreateTabButton("⚓", "Farm Menu", "farm")
CreateTabButton("⚙", "Settings", "settings")

local InfoPage = CreatePage("info")
local FarmPage = CreatePage("farm")
local SettingsPage = CreatePage("settings")

-- Isi Halaman Info & Settings Lama
AddCategory(InfoPage, "Informasi")
AddButtonRow(InfoPage, "Kecepatan Karakter", "Set 100", function() if _G.NexoHub_Features then _G.NexoHub_Features.SetWalkSpeed(100) end end)

AddCategory(SettingsPage, "Pengaturan Tambahan")
AddButtonRow(SettingsPage, "Lompatan Tinggi", "Set 120", function() if _G.NexoHub_Features then _G.NexoHub_Features.SetJumpPower(120) end end)

-- =======================================================
-- [[ ADVANCED FARM MENU CONTENT (FITUR MAKRO) ]]
-- =======================================================
AddCategory(FarmPage, "Perekam Makro (Bee Swarm TD)")

-- 1. Input Nama Makro
AddTextBoxRow(FarmPage, "Nama File Makro:", "MAKRO_V1", function(txt)
    if _G.NexoHub_Features then _G.NexoHub_Features.SetMacroName(txt) end
end)

-- 2. Kontrol Record
AddButtonRow(FarmPage, "Mulai Rekam Aksi", "RECORD", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StartRecord() end
end)

AddButtonRow(FarmPage, "Berhenti & Simpan", "STOP REC", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StopRecord() end
end)

-- 3. Kontrol Playback & Manajemen File
AddButtonRow(FarmPage, "Jalankan Makro Terpilih", "PLAY", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.PlayMacro() end
end)

AddButtonRow(FarmPage, "Hentikan Pemutaran", "STOP PLAY", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.StopMacro() end
end)

AddButtonRow(FarmPage, "Hapus File Makro Aktif", "DELETE", function()
    if _G.NexoHub_Features then _G.NexoHub_Features.DeleteMacro() end
end)

-- 4. Toggle Auto Loop Playback
local LoopFrame = Instance.new("Frame")
LoopFrame.Parent = FarmPage
LoopFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
LoopFrame.Size = UDim2.new(1, -12, 0, 48)
local LCrnr = Instance.new("UICorner") ; LCrnr.CornerRadius = UDim.new(0, 8) ; LCrnr.Parent = LoopFrame

local LoopLbl = Instance.new("TextLabel")
LoopLbl.Parent = LoopFrame ; LoopLbl.BackgroundTransparency = 1 ; LoopLbl.Position = UDim2.new(0, 15, 0, 0)
LoopLbl.Size = UDim2.new(0.6, 0, 1, 0) ; LoopLbl.Font = Enum.Font.GothamMedium
LoopLbl.Text = "Putar Otomatis Terus-menerus" ; LoopLbl.TextColor3 = Color3.fromRGB(240, 240, 245) ; LoopLbl.TextSize = 14 ; LoopLbl.TextXAlignment = Enum.TextXAlignment.Left

local LoopBtn = Instance.new("TextButton")
LoopBtn.Parent = LoopFrame ; LoopBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
LoopBtn.Position = UDim2.new(1, -105, 0, 9) ; LoopBtn.Size = UDim2.new(0, 95, 0, 30)
LoopBtn.Font = Enum.Font.GothamSemibold ; LoopBtn.Text = "LOOP: OFF" ; LoopBtn.TextColor3 = Color3.fromRGB(255, 255, 255) ; LoopBtn.TextSize = 11
local LBCrnr = Instance.new("UICorner") ; LBCrnr.CornerRadius = UDim.new(0, 6) ; LBCrnr.Parent = LoopBtn

local isLooping = false
LoopBtn.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    LoopBtn.Text = isLooping and "LOOP: ON" or "LOOP: OFF"
    LoopBtn.BackgroundColor3 = isLooping and Color3.fromRGB(40, 120, 40) or Color3.fromRGB(150, 40, 40)
    if _G.NexoHub_Features then _G.NexoHub_Features.SetAutoLoop(isLooping) end
end)

-- 5. REAL-TIME LOG MONITOR WINDOW
AddCategory(FarmPage, "Konsol Log Makro")
local LogContainer = Instance.new("Frame")
LogContainer.Parent = FarmPage
LogContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
LogContainer.Size = UDim2.new(1, -12, 0, 100)
local LogCrnr = Instance.new("UICorner") ; LogCrnr.CornerRadius = UDim.new(0, 8) ; LogCrnr.Parent = LogContainer

local LogText = Instance.new("TextLabel")
LogText.Parent = LogContainer
LogText.BackgroundTransparency = 1
LogText.Position = UDim2.new(0, 12, 0, 8)
LogText.Size = UDim2.new(1, -24, 1, -16)
LogText.Font = Enum.Font.Code
LogText.Text = "Sistem makro siap...\nMenunggu instruksi pemain."
LogText.TextColor3 = Color3.fromRGB(100, 230, 100)
LogText.TextSize = 11
LogText.TextXAlignment = Enum.TextXAlignment.Left
LogText.TextYAlignment = Enum.TextYAlignment.Top

-- Daftarkan fungsi update log agar bisa dipanggil dari File Fitur
_G.NexoHub_AddLogUI = function(msg)
    local currentText = LogText.Text
    local lines = {}
    for line in string.gmatch(currentText, "[^\n]+") do table.insert(lines, line) end
    if #lines >= 5 then table.remove(lines, 1) end -- Batasi maksimal 5 baris log di layar
    table.insert(lines, msg)
    LogText.Text = table.concat(lines, "\n")
end

-- Default Tampilan Aktif Pertama kali
SwitchToTab("info")

-- Dragging System Minimalist
local dragStart, startPos, dragging = nil, nil, false
HeaderZone.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
RunService.RenderStepped:Connect(function()
    if dragging then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = Vector3.new(mousePos.X, mousePos.Y - 36, 0) - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MinimizeBtn.MouseButton1Click:Connect(function() NexoHubUI:Destroy() end)
