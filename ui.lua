-- [[ ui.lua ]]
local UI = {}

function UI.Create()
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local MarketplaceService = game:GetService("MarketplaceService")
    local LocalPlayer = Players.LocalPlayer

    -- [[ FITUR AUTO-DETECT NAMA GAME ]]
    local GameName = "NexoHub"
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    if success and result then
        GameName = result
    end

    if CoreGui:FindFirstChild("NexoHubUI") then
        CoreGui.NexoHubUI:Destroy()
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
    IntroTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
    IntroTitle.TextTransparency = 1

    local LoadingSpinner = Instance.new("ImageLabel")
    LoadingSpinner.Parent = IntroFrame
    LoadingSpinner.BackgroundTransparency = 1
    LoadingSpinner.Position = UDim2.new(0.5, -25, 0.55, 0)
    LoadingSpinner.Size = UDim2.new(0, 50, 0, 50)
    LoadingSpinner.Image = "rbxassetid://6031267431" 
    LoadingSpinner.ImageColor3 = Color3.fromRGB(0, 0, 0)
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

    -- TOPBAR / HEADER (Seamless - Tanpa Garis Hitam)
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

    -- SIDEBAR MENU KIRI (Clean & Seamless)
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

    -- SEKAT VERTIKAL TENGAH
    local VerticalDivider = Instance.new("Frame")
    VerticalDivider.Name = "VerticalDivider"
    VerticalDivider.Parent = MainFrame
    VerticalDivider.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
    VerticalDivider.BorderSizePixel = 0
    VerticalDivider.Position = UDim2.new(0, 165, 0, 55)
    VerticalDivider.Size = UDim2.new(0, 1, 1, -55)
    VerticalDivider.BackgroundTransparency = 1

    -- CONTENT CONTAINER KANAN
    local ContentContainer = Instance.new("ScrollingFrame")
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundTransparency = 1 
    ContentContainer.Position = UDim2.new(0, 182, 0, 70)
    ContentContainer.Size = UDim2.new(1, -198, 1, -88)
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentContainer.ScrollBarThickness = 4
    ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 125)
    ContentContainer.Active = true

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentContainer
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ContentContainer.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
    end)

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

    -- =======================================================
    -- [[ 3. LOGO MINIMIZE "N" ]]
    -- =======================================================
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
    -- [[ 4. DYNAMIC INTERFACE BUILDERS ]]
    -- =======================================================
    local function CreateTab(icon, name)
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
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(48, 48, 54), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() 
        end)
        TabBtn.MouseLeave:Connect(function() 
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(36, 36, 40), TextColor3 = Color3.fromRGB(175, 175, 180)}):Play() 
        end)
        return TabBtn
    end

    local function CreateCategory(title)
        local CategoryLabel = Instance.new("TextLabel")
        CategoryLabel.Parent = ContentContainer
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

    local function CreateFeatureRow(text, btnText, callback)
        local RowFrame = Instance.new("Frame")
        RowFrame.Parent = ContentContainer
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
        FeatureLabel.Size = UDim2.new(0.6, 0, 1, 0)
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
            callback() 
        end)

        RowFrame.MouseEnter:Connect(function() TweenService:Create(RowStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(130, 130, 135)}):Play() end)
        RowFrame.MouseLeave:Connect(function() TweenService:Create(RowStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80, 80, 85)}):Play() end)

        return RowFrame, FeatureLabel, ActionBtn, RowStroke
    end

    -- =======================================================
    -- [[ 5. DRAG ENGINE SYSTEM ]]
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

    -- RESIZE SYSTEM
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
            local newWidth = math.clamp(startSize.X.Offset + delta.X, 520, 880)
            local newHeight = math.clamp(startSize.Y.Offset + delta.Y, 320, 580)
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

    -- Mengirim fungsi-fungsi builder keluar agar bisa digunakan oleh file features
    return {
        CreateTab = CreateTab,
        CreateCategory = CreateCategory,
        CreateFeatureRow = CreateFeatureRow,
        ExecuteAnimations = function(tabs, rows, elements)
            -- =======================================================
            -- [[ 6. EXECUTE ANIMATIONS ]]
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

            -- Buka Main Frame
            MainFrame.Size = UDim2.new(0, 630, 0, 55)
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2.new(0, 630, 0, 390)}):Play()
            TweenService:Create(MainStroke, TweenInfo.new(0.5), {Transparency = 0.2}):Play()

            -- Mengaktifkan Bagian Atas & Kiri secara Solid
            TweenService:Create(HeaderZone, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Sidebar, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
            task.wait(0.4)

            -- Fade In Text, Ikon, Divider Tengah
            TweenService:Create(VerticalDivider, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
            TweenService:Create(HubIcon, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
            TweenService:Create(TitleMain, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
            TweenService:Create(TitleSub, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
            TweenService:Create(MinimizeBtn, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
            TweenService:Create(ResizeBtn, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()

            for _, tab in ipairs(tabs) do
                TweenService:Create(tab, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
            end

            -- KANAN SOLID
            for _, row in ipairs(rows) do
                TweenService:Create(row, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play() 
            end

            for _, elem in ipairs(elements) do
                if elem:IsA("TextLabel") or elem:IsA("TextButton") then
                    TweenService:Create(elem, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
                end
                if elem:IsA("TextButton") then
                    TweenService:Create(elem, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
                end
                if elem:IsA("UIStroke") then
                    TweenService:Create(elem, TweenInfo.new(0.2), {Transparency = 0}):Play()
                end
            end
        end
    }
end

return UI
