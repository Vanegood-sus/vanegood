-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Parent Resolver
local parentObj = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")

-- Clean up old instance
if parentObj:FindFirstChild("vanegood_UI") then
    parentObj.vanegood_UI:Destroy()
end

-- ==========================================
-- ОСНОВНОЙ МОДУЛЬ БИБЛИОТЕКИ
-- ==========================================
local Library = {}
Library.__index = Library

-- Хелпер для извлечения названия из любой структуры конфига
local function parseName(cfg, default)
    if type(cfg) == "string" then
        return cfg
    elseif type(cfg) == "table" then
        return cfg.Name or cfg.Title or cfg.Text or default
    end
    return default
end

function Library:CreateWindow(config)
    local TitleText = parseName(config, "vanegood")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vanegood_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = parentObj

    -- 1. Свернутая плашка
    local MinimizedBar = Instance.new("TextButton")
    MinimizedBar.Name = "MinimizedBar"
    MinimizedBar.Size = UDim2.new(0, 180, 0, 30)
    MinimizedBar.Position = UDim2.new(0.5, -90, 0, 10)
    MinimizedBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MinimizedBar.BackgroundTransparency = 0.45
    MinimizedBar.BorderSizePixel = 0
    MinimizedBar.Text = ""
    MinimizedBar.AutoButtonColor = false
    MinimizedBar.Visible = false
    MinimizedBar.ZIndex = 50
    MinimizedBar.Parent = ScreenGui

    local MinBarCorner = Instance.new("UICorner")
    MinBarCorner.CornerRadius = UDim.new(0, 8)
    MinBarCorner.Parent = MinimizedBar

    local MinBarStroke = Instance.new("UIStroke")
    MinBarStroke.Color = Color3.fromRGB(255, 255, 255)
    MinBarStroke.Transparency = 0.75
    MinBarStroke.Thickness = 1
    MinBarStroke.Parent = MinimizedBar

    local MinBarLabel = Instance.new("TextLabel")
    MinBarLabel.Size = UDim2.new(1, 0, 1, 0)
    MinBarLabel.BackgroundTransparency = 1
    MinBarLabel.Font = Enum.Font.GothamMedium
    MinBarLabel.Text = TitleText .. " (Открыть)"
    MinBarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinBarLabel.TextSize = 12
    MinBarLabel.ZIndex = 51
    MinBarLabel.Parent = MinimizedBar

    -- 2. Основное окно
    local OutlineFrame = Instance.new("Frame")
    OutlineFrame.Name = "OutlineFrame"
    OutlineFrame.Size = UDim2.new(0, 620, 0, 420)
    OutlineFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
    OutlineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    OutlineFrame.BorderSizePixel = 0
    OutlineFrame.Parent = ScreenGui

    local OutlineCorner = Instance.new("UICorner")
    OutlineCorner.CornerRadius = UDim.new(0, 14)
    OutlineCorner.Parent = OutlineFrame

    local MainGradient = Instance.new("UIGradient")
    MainGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(45, 48, 55)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(20, 20, 25)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(45, 48, 55))
    })
    MainGradient.Rotation = 0
    MainGradient.Parent = OutlineFrame

    local rotSpeed = 90
    local renderConn
    renderConn = RunService.RenderStepped:Connect(function(dt)
        if not OutlineFrame or not OutlineFrame.Parent then
            if renderConn then renderConn:Disconnect() end
            return
        end
        MainGradient.Rotation = (MainGradient.Rotation + (rotSpeed * dt)) % 360
    end)

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(1, -4, 1, -4)
    MainFrame.Position = UDim2.new(0, 2, 0, 2)
    MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = OutlineFrame

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    -- Шапка (Topbar)
    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Size = UDim2.new(1, 0, 0, 42)
    Topbar.BackgroundTransparency = 1
    Topbar.ZIndex = 5
    Topbar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 16, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = TitleText
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 6
    Title.Parent = Topbar

    -- Контролы окна
    local ControlsHolder = Instance.new("Frame")
    ControlsHolder.Name = "Controls"
    ControlsHolder.Size = UDim2.new(0, 70, 1, 0)
    ControlsHolder.Position = UDim2.new(1, -75, 0, 0)
    ControlsHolder.BackgroundTransparency = 1
    ControlsHolder.ZIndex = 6
    ControlsHolder.Parent = Topbar

    local ControlsLayout = Instance.new("UIListLayout")
    ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
    ControlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ControlsLayout.Padding = UDim.new(0, 6)
    ControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ControlsLayout.Parent = ControlsHolder

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "Minimize"
    MinimizeBtn.LayoutOrder = 1
    MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(25, 27, 34)
    MinimizeBtn.AutoButtonColor = false
    MinimizeBtn.Text = "-"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.ZIndex = 7
    MinimizeBtn.Parent = ControlsHolder

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "Close"
    CloseBtn.LayoutOrder = 2
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 27, 34)
    CloseBtn.AutoButtonColor = false
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 13
    CloseBtn.ZIndex = 7
    CloseBtn.Parent = ControlsHolder

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    local lastFramePos = OutlineFrame.Position

    MinimizeBtn.MouseButton1Click:Connect(function()
        lastFramePos = OutlineFrame.Position
        OutlineFrame.Visible = false
        MinimizedBar.Visible = true
    end)

    MinimizedBar.MouseButton1Click:Connect(function()
        MinimizedBar.Visible = false
        OutlineFrame.Position = lastFramePos
        OutlineFrame.Visible = true
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        if renderConn then renderConn:Disconnect() end
        ScreenGui:Destroy()
    end)

    local TopbarDivider = Instance.new("Frame")
    TopbarDivider.Size = UDim2.new(1, 0, 0, 1)
    TopbarDivider.Position = UDim2.new(0, 0, 1, -1)
    TopbarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    TopbarDivider.BorderSizePixel = 0
    TopbarDivider.Parent = Topbar

    -- Перетаскивание основного окна
    local dragging, dragStart, startPos = false, nil, nil
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = OutlineFrame.Position
        end
    end)

    -- Перетаскивание свернутой плашки
    local minDragging, minDragStart, minStartPos, hasMovedMin = false, nil, nil, false
    MinimizedBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            minDragging = true
            minDragStart = input.Position
            minStartPos = MinimizedBar.Position
            hasMovedMin = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging and dragStart and startPos then
                local delta = input.Position - dragStart
                OutlineFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            elseif minDragging and minDragStart and minStartPos then
                local delta = input.Position - minDragStart
                if delta.Magnitude > 5 then hasMovedMin = true end
                MinimizedBar.Position = UDim2.new(minStartPos.X.Scale, minStartPos.X.Offset + delta.X, minStartPos.Y.Scale, minStartPos.Y.Offset + delta.Y)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if minDragging then
                minDragging = false
                if hasMovedMin then
                    task.defer(function()
                        MinimizedBar.Visible = true
                    end)
                end
            end
        end
    end)

    -- Боковая панель вкладок
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 160, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Sidebar.ZIndex = 3
    Sidebar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 8)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Parent = Sidebar

    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 12)
    SidebarPadding.PaddingLeft = UDim.new(0, 10)
    SidebarPadding.PaddingRight = UDim.new(0, 10)
    SidebarPadding.PaddingBottom = UDim.new(0, 12)
    SidebarPadding.Parent = Sidebar

    local SidebarDivider = Instance.new("Frame")
    SidebarDivider.Size = UDim2.new(0, 1, 1, -42)
    SidebarDivider.Position = UDim2.new(0, 160, 0, 42)
    SidebarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    SidebarDivider.BorderSizePixel = 0
    SidebarDivider.ZIndex = 4
    SidebarDivider.Parent = MainFrame

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -161, 1, -42)
    ContentContainer.Position = UDim2.new(0, 161, 0, 42)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 3
    ContentContainer.Parent = MainFrame

    local Window = {}
    local Tabs = {}
    local activeTab = nil
    local tabCount = 0

    function Window:CreateTab(tabConfig)
        tabCount = tabCount + 1
        local TabName = parseName(tabConfig, "Tab " .. tabCount)

        local TabButton = Instance.new("TextButton")
        TabButton.LayoutOrder = tabCount
        TabButton.Size = UDim2.new(1, 0, 0, 36)
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
        TabButton.AutoButtonColor = false
        TabButton.Text = ""
        TabButton.ZIndex = 4
        TabButton.Parent = Sidebar

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton

        local ArrowIcon = Instance.new("ImageLabel")
        ArrowIcon.Size = UDim2.new(0, 14, 0, 14)
        ArrowIcon.Position = UDim2.new(0, 4, 0.5, -7)
        ArrowIcon.BackgroundTransparency = 1
        ArrowIcon.Image = "rbxassetid://10709790948"
        ArrowIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        ArrowIcon.ImageTransparency = 1
        ArrowIcon.ZIndex = 5
        ArrowIcon.Parent = TabButton

        local TitleLbl = Instance.new("TextLabel")
        TitleLbl.Size = UDim2.new(1, -24, 1, 0)
        TitleLbl.Position = UDim2.new(0, 12, 0, 0)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Font = Enum.Font.GothamMedium
        TitleLbl.Text = TabName
        TitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLbl.TextSize = 13
        TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        TitleLbl.ZIndex = 5
        TitleLbl.Parent = TabButton

        local BottomGlow = Instance.new("Frame")
        BottomGlow.Size = UDim2.new(0.85, 0, 0, 2)
        BottomGlow.Position = UDim2.new(0.5, 0, 1, -2)
        BottomGlow.AnchorPoint = Vector2.new(0.5, 0)
        BottomGlow.BorderSizePixel = 0
        BottomGlow.BackgroundTransparency = 1
        BottomGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BottomGlow.ZIndex = 6
        BottomGlow.Parent = TabButton

        local GlowCorner = Instance.new("UICorner")
        GlowCorner.CornerRadius = UDim.new(1, 0)
        GlowCorner.Parent = BottomGlow

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabPage.Visible = false
        TabPage.ZIndex = 4
        TabPage.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Parent = TabPage

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 12)
        PagePadding.PaddingLeft = UDim.new(0, 12)
        PagePadding.PaddingRight = UDim.new(0, 12)
        PagePadding.PaddingBottom = UDim.new(0, 12)
        PagePadding.Parent = TabPage

        local function SetActive(state)
            if state then
                TweenService:Create(TabButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(28, 31, 39)}):Play()
                TweenService:Create(TitleLbl, TweenInfo.new(0.25), {Position = UDim2.new(0, 26, 0, 0)}):Play()
                TweenService:Create(ArrowIcon, TweenInfo.new(0.25), {ImageTransparency = 0, Position = UDim2.new(0, 8, 0.5, -7)}):Play()
                TweenService:Create(BottomGlow, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
                TabPage.Visible = true
            else
                TweenService:Create(TabButton, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(20, 22, 28)}):Play()
                TweenService:Create(TitleLbl, TweenInfo.new(0.25), {Position = UDim2.new(0, 12, 0, 0)}):Play()
                TweenService:Create(ArrowIcon, TweenInfo.new(0.25), {ImageTransparency = 1, Position = UDim2.new(0, 4, 0.5, -7)}):Play()
                TweenService:Create(BottomGlow, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
                TabPage.Visible = false
            end
        end

        TabButton.MouseButton1Click:Connect(function()
            if activeTab == TabName then return end
            for _, data in pairs(Tabs) do data.SetActive(false) end
            activeTab = TabName
            SetActive(true)
        end)

        Tabs[TabName] = {SetActive = SetActive}
        if activeTab == nil then 
            activeTab = TabName 
            SetActive(true) 
        end

        local TabElements = {}

        -- Кнопка (Button)
        function TabElements:CreateButton(btnConfig, altCallback)
            local btnName = parseName(btnConfig, "Button")
            local callback = (type(btnConfig) == "table" and (btnConfig.Callback or btnConfig.Function)) or (type(altCallback) == "function" and altCallback) or function() end

            local BtnFrame = Instance.new("TextButton")
            BtnFrame.Size = UDim2.new(1, 0, 0, 36)
            BtnFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            BtnFrame.AutoButtonColor = false
            BtnFrame.Text = ""
            BtnFrame.ZIndex = 5
            BtnFrame.Parent = TabPage

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 8)
            BtnCorner.Parent = BtnFrame

            local BtnTitle = Instance.new("TextLabel")
            BtnTitle.Size = UDim2.new(1, -45, 1, 0)
            BtnTitle.Position = UDim2.new(0, 12, 0, 0)
            BtnTitle.BackgroundTransparency = 1
            BtnTitle.Font = Enum.Font.GothamMedium
            BtnTitle.Text = btnName
            BtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BtnTitle.TextSize = 13
            BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
            BtnTitle.ZIndex = 6
            BtnTitle.Parent = BtnFrame

            local HandIcon = Instance.new("ImageLabel")
            HandIcon.Size = UDim2.new(0, 18, 0, 18)
            HandIcon.Position = UDim2.new(1, -26, 0.5, -9)
            HandIcon.BackgroundTransparency = 1
            HandIcon.Image = "rbxassetid://6034292263"
            HandIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            HandIcon.ZIndex = 6
            HandIcon.Parent = BtnFrame

            BtnFrame.MouseButton1Click:Connect(function()
                TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(45, 48, 60)}):Play()
                task.wait(0.1)
                TweenService:Create(BtnFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 24, 30)}):Play()
                pcall(callback)
            end)

            return {
                Set = function(_, newText)
                    BtnTitle.Text = tostring(newText)
                end
            }
        end

        -- Переключатель (Toggle)
        function TabElements:CreateToggle(toggleConfig, altCallback)
            local toggleName = parseName(toggleConfig, "Toggle")
            local state = false
            local callback = function() end

            if type(toggleConfig) == "table" then
                if toggleConfig.CurrentValue ~= nil then
                    state = toggleConfig.CurrentValue
                elseif toggleConfig.Default ~= nil then
                    state = toggleConfig.Default
                elseif toggleConfig.Value ~= nil then
                    state = toggleConfig.Value
                end
                callback = toggleConfig.Callback or toggleConfig.Function or function() end
            elseif type(altCallback) == "function" then
                callback = altCallback
            end

            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            ToggleFrame.AutoButtonColor = false
            ToggleFrame.Text = ""
            ToggleFrame.ZIndex = 5
            ToggleFrame.Parent = TabPage

            local TglCorner = Instance.new("UICorner")
            TglCorner.CornerRadius = UDim.new(0, 8)
            TglCorner.Parent = ToggleFrame

            local TglTitle = Instance.new("TextLabel")
            TglTitle.Size = UDim2.new(1, -60, 1, 0)
            TglTitle.Position = UDim2.new(0, 12, 0, 0)
            TglTitle.BackgroundTransparency = 1
            TglTitle.Font = Enum.Font.GothamMedium
            TglTitle.Text = toggleName
            TglTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TglTitle.TextSize = 13
            TglTitle.TextXAlignment = Enum.TextXAlignment.Left
            TglTitle.ZIndex = 6
            TglTitle.Parent = ToggleFrame

            local SwitchOuter = Instance.new("Frame")
            SwitchOuter.Size = UDim2.new(0, 38, 0, 20)
            SwitchOuter.Position = UDim2.new(1, -50, 0.5, -10)
            SwitchOuter.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(35, 37, 45)
            SwitchOuter.BorderSizePixel = 0
            SwitchOuter.ZIndex = 6
            SwitchOuter.Parent = ToggleFrame

            local SwitchOuterCorner = Instance.new("UICorner")
            SwitchOuterCorner.CornerRadius = UDim.new(1, 0)
            SwitchOuterCorner.Parent = SwitchOuter

            local SwitchDot = Instance.new("Frame")
            SwitchDot.Size = UDim2.new(0, 14, 0, 14)
            SwitchDot.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            SwitchDot.BackgroundColor3 = state and Color3.fromRGB(16, 16, 20) or Color3.fromRGB(255, 255, 255)
            SwitchDot.BorderSizePixel = 0
            SwitchDot.ZIndex = 7
            SwitchDot.Parent = SwitchOuter

            local SwitchDotCorner = Instance.new("UICorner")
            SwitchDotCorner.CornerRadius = UDim.new(1, 0)
            SwitchDotCorner.Parent = SwitchDot

            local function UpdateToggle()
                if state then
                    TweenService:Create(SwitchOuter, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    TweenService:Create(SwitchDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.fromRGB(16, 16, 20)}):Play()
                else
                    TweenService:Create(SwitchOuter, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 37, 45)}):Play()
                    TweenService:Create(SwitchDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                end
                pcall(callback, state)
            end

            ToggleFrame.MouseButton1Click:Connect(function()
                state = not state
                UpdateToggle()
            end)

            return {
                Set = function(_, val) 
                    state = val 
                    UpdateToggle() 
                end,
                GetValue = function(_)
                    return state
                end
            }
        end

        -- Ползунок (Slider)
        function TabElements:CreateSlider(sliderConfig)
            sliderConfig = sliderConfig or {}
            local sliderName = parseName(sliderConfig, "Slider")
            local min = sliderConfig.Min or sliderConfig.Minimum or 0
            local max = sliderConfig.Max or sliderConfig.Maximum or 100
            local default = sliderConfig.CurrentValue or sliderConfig.Default or sliderConfig.Value or min
            local callback = sliderConfig.Callback or sliderConfig.Function or function() end

            local value = math.clamp(default, min, max)

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.ZIndex = 5
            SliderFrame.Parent = TabPage

            local SldCorner = Instance.new("UICorner")
            SldCorner.CornerRadius = UDim.new(0, 8)
            SldCorner.Parent = SliderFrame

            local SldTitle = Instance.new("TextLabel")
            SldTitle.Size = UDim2.new(1, -70, 0, 25)
            SldTitle.Position = UDim2.new(0, 12, 0, 4)
            SldTitle.BackgroundTransparency = 1
            SldTitle.Font = Enum.Font.GothamMedium
            SldTitle.Text = sliderName
            SldTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SldTitle.TextSize = 13
            SldTitle.TextXAlignment = Enum.TextXAlignment.Left
            SldTitle.ZIndex = 6
            SldTitle.Parent = SliderFrame

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 25)
            ValueLabel.Position = UDim2.new(1, -62, 0, 4)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.ZIndex = 6
            ValueLabel.Parent = SliderFrame

            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(1, -24, 0, 6)
            Track.Position = UDim2.new(0, 12, 0, 32)
            Track.BackgroundColor3 = Color3.fromRGB(35, 37, 45)
            Track.BorderSizePixel = 0
            Track.ZIndex = 6
            Track.Parent = SliderFrame

            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = Track

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((value - min)/(max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Fill.BorderSizePixel = 0
            Fill.ZIndex = 7
            Fill.Parent = Track

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill

            local function UpdateValue(inputPos)
                local sizeX = math.clamp((inputPos - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                value = math.floor(min + ((max - min) * sizeX))
                Fill.Size = UDim2.new(sizeX, 0, 1, 0)
                ValueLabel.Text = tostring(value)
                pcall(callback, value)
            end

            local sliding = false
            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    UpdateValue(input.Position.X)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateValue(input.Position.X)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)

            return {
                Set = function(_, val)
                    value = math.clamp(val, min, max)
                    local sizeX = (value - min) / (max - min)
                    Fill.Size = UDim2.new(sizeX, 0, 1, 0)
                    ValueLabel.Text = tostring(value)
                    pcall(callback, value)
                end,
                GetValue = function(_)
                    return value
                end
            }
        end

        -- Выпадающий список (Dropdown)
        function TabElements:CreateDropdown(dropConfig)
            dropConfig = dropConfig or {}
            local dropName = parseName(dropConfig, "Dropdown")
            local options = dropConfig.Options or dropConfig.Values or dropConfig.List or {"Опция 1", "Опция 2"}
            local callback = dropConfig.Callback or dropConfig.Function or function() end

            local opened = false
            local selected = dropConfig.CurrentValue or dropConfig.Default or dropConfig.Value or options[1] or ""

            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, 0, 0, 36)
            DropFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            DropFrame.BorderSizePixel = 0
            DropFrame.ClipsDescendants = true
            DropFrame.ZIndex = 5
            DropFrame.Parent = TabPage

            local DropCorner = Instance.new("UICorner")
            DropCorner.CornerRadius = UDim.new(0, 8)
            DropCorner.Parent = DropFrame

            local MainBtn = Instance.new("TextButton")
            MainBtn.Size = UDim2.new(1, 0, 0, 36)
            MainBtn.BackgroundTransparency = 1
            MainBtn.Text = ""
            MainBtn.ZIndex = 6
            MainBtn.Parent = DropFrame

            local DropTitle = Instance.new("TextLabel")
            DropTitle.Size = UDim2.new(1, -40, 0, 36)
            DropTitle.Position = UDim2.new(0, 12, 0, 0)
            DropTitle.BackgroundTransparency = 1
            DropTitle.Font = Enum.Font.GothamMedium
            DropTitle.Text = dropName .. ": " .. tostring(selected)
            DropTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropTitle.TextSize = 13
            DropTitle.TextXAlignment = Enum.TextXAlignment.Left
            DropTitle.ZIndex = 7
            DropTitle.Parent = MainBtn

            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 0, 36)
            Arrow.Position = UDim2.new(1, -28, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Font = Enum.Font.GothamBold
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(255, 255, 255)
            Arrow.TextSize = 12
            Arrow.ZIndex = 7
            Arrow.Parent = MainBtn

            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, 0, 0, (#options * 32))
            OptionContainer.Position = UDim2.new(0, 0, 0, 36)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.ZIndex = 6
            OptionContainer.Parent = DropFrame

            local OptLayout = Instance.new("UIListLayout")
            OptLayout.SortOrder = Enum.SortOrder.LayoutOrder
            OptLayout.Parent = OptionContainer

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 32)
                OptBtn.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
                OptBtn.BorderSizePixel = 0
                OptBtn.Font = Enum.Font.GothamMedium
                OptBtn.Text = "  " .. tostring(opt)
                OptBtn.TextColor3 = Color3.fromRGB(200, 200, 215)
                OptBtn.TextSize = 12
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.ZIndex = 7
                OptBtn.Parent = OptionContainer

                OptBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    DropTitle.Text = dropName .. ": " .. tostring(selected)
                    opened = false
                    TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 36)}):Play()
                    TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    pcall(callback, selected)
                end)
            end

            MainBtn.MouseButton1Click:Connect(function()
                opened = not opened
                local targetHeight = opened and (36 + (#options * 32)) or 36
                TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
                TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = opened and 180 or 0}):Play()
            end)

            return {
                Set = function(_, val)
                    selected = val
                    DropTitle.Text = dropName .. ": " .. tostring(selected)
                    pcall(callback, selected)
                end,
                GetValue = function(_)
                    return selected
                end
            }
        end

        -- Поле ввода текста / чисел (Input)
        function TabElements:CreateInput(inputConfig)
            inputConfig = inputConfig or {}
            local inputTitle = parseName(inputConfig, "Input")
            local placeholder = inputConfig.PlaceholderText or inputConfig.Placeholder or "Введите..."
            local clearOnFocus = (inputConfig.ClearTextOnFocus ~= nil) and inputConfig.ClearTextOnFocus or false
            local numericOnly = inputConfig.Numeric or false
            local defaultText = inputConfig.Default or inputConfig.CurrentValue or inputConfig.Value or ""
            local callback = inputConfig.Callback or inputConfig.Function or function() end

            local InputFrame = Instance.new("Frame")
            InputFrame.Size = UDim2.new(1, 0, 0, 36)
            InputFrame.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
            InputFrame.BorderSizePixel = 0
            InputFrame.ZIndex = 5
            InputFrame.Parent = TabPage

            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 8)
            InputCorner.Parent = InputFrame

            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(0.45, 0, 1, 0)
            TitleLabel.Position = UDim2.new(0, 12, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = inputTitle
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            TitleLabel.ZIndex = 6
            TitleLabel.Parent = InputFrame

            local TextBoxContainer = Instance.new("Frame")
            TextBoxContainer.Size = UDim2.new(0.5, -12, 0, 26)
            TextBoxContainer.Position = UDim2.new(0.5, 0, 0.5, -13)
            TextBoxContainer.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
            TextBoxContainer.BorderSizePixel = 0
            TextBoxContainer.ZIndex = 6
            TextBoxContainer.Parent = InputFrame

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 6)
            BoxCorner.Parent = TextBoxContainer

            local BoxStroke = Instance.new("UIStroke")
            BoxStroke.Color = Color3.fromRGB(35, 37, 45)
            BoxStroke.Thickness = 1
            BoxStroke.Parent = TextBoxContainer

            local TextBox = Instance.new("TextBox")
            TextBox.Size = UDim2.new(1, -12, 1, 0)
            TextBox.Position = UDim2.new(0, 6, 0, 0)
            TextBox.BackgroundTransparency = 1
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = placeholder
            TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
            TextBox.Text = tostring(defaultText)
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12
            TextBox.ClearTextOnFocus = clearOnFocus
            TextBox.ClipsDescendants = true
            TextBox.ZIndex = 7
            TextBox.Parent = TextBoxContainer

            TextBox.Focused:Connect(function()
                TweenService:Create(BoxStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(255, 255, 255)}):Play()
            end)

            TextBox.FocusLost:Connect(function(enterPressed)
                TweenService:Create(BoxStroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(35, 37, 45)}):Play()
                if numericOnly then
                    local cleanNum = TextBox.Text:gsub("%D+", "")
                    TextBox.Text = cleanNum
                end
                pcall(callback, TextBox.Text, enterPressed)
            end)

            if numericOnly then
                TextBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local cleanNum = TextBox.Text:gsub("%D+", "")
                    if TextBox.Text ~= cleanNum then
                        TextBox.Text = cleanNum
                    end
                end)
            end

            return {
                Set = function(_, text)
                    TextBox.Text = tostring(text)
                    pcall(callback, TextBox.Text, false)
                end,
                Get = function(_)
                    return TextBox.Text
                end
            }
        end

        return TabElements
    end

    return Window
end

return Library
