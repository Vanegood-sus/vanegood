-- Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Parent Resolver
local parentObj = (gethui and gethui()) or CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Clean up old instance
if parentObj:FindFirstChild("vanegood_UI") then
    parentObj.vanegood_UI:Destroy()
end

-- ==========================================
-- ОСНОВНОЙ МОДУЛЬ БИБЛИОТЕКИ (vanegood)
-- ==========================================
local Library = {}
Library.__index = Library

function Library:CreateWindow(config)
    config = config or {}
    local TitleText = config.Name or "vanegood"

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vanegood_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = parentObj

    local lastFramePos = UDim2.new(0.5, -310, 0.5, -210)

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
    OutlineFrame.Position = lastFramePos
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
    RunService.RenderStepped:Connect(function(dt)
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
        ScreenGui:Destroy()
    end)

    local TopbarDivider = Instance.new("Frame")
    TopbarDivider.Size = UDim2.new(1, 0, 0, 1)
    TopbarDivider.Position = UDim2.new(0, 0, 1, -1)
    TopbarDivider.BackgroundColor3 = Color3.fromRGB(30, 32, 38)
    TopbarDivider.BorderSizePixel = 0
    TopbarDivider.Parent = Topbar

    -- Dragging
    local dragging, dragStart, startPos
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = OutlineFrame.Position
        end
    end)

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
            if dragging then
                local delta = input.Position - dragStart
                OutlineFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            elseif minDragging then
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

    -- Sidebar
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
        local TabName = (type(tabConfig) == "table" and tabConfig.Name) or tabConfig or ("Tab " .. tabCount)

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
        if activeTab == nil then activeTab = TabName SetActive(true) end

        local TabElements = {}

        function TabElements:CreateButton(btnConfig)
            btnConfig = btnConfig or {}
            local btnName = btnConfig.Name or "Button"
            local callback = btnConfig.Callback or function() end

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

            return BtnFrame
        end

        function TabElements:CreateToggle(toggleConfig)
            toggleConfig = toggleConfig or {}
            local toggleName = toggleConfig.Name or "Toggle"
            local state = toggleConfig.CurrentValue or toggleConfig.Default or false
            local callback = toggleConfig.Callback or function() end

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

            return {Set = function(_, val) state = val UpdateToggle() end}
        end

        function TabElements:CreateSlider(sliderConfig)
            sliderConfig = sliderConfig or {}
            local sliderName = sliderConfig.Name or "Slider"
            local min = sliderConfig.Min or 0
            local max = sliderConfig.Max or 100
            local default = sliderConfig.Default or min
            local callback = sliderConfig.Callback or function() end

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
            Track.Parent = Track or SliderFrame

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

            return SliderFrame
        end

        function TabElements:CreateDropdown(dropConfig)
            dropConfig = dropConfig or {}
            local dropName = dropConfig.Name or "Dropdown"
            local options = dropConfig.Options or {"Опция 1"}
            local callback = dropConfig.Callback or function() end

            local opened = false
            local selected = options[1] or ""

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
            DropTitle.Text = dropName .. ": " .. selected
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

            local function RefreshOptions(newOptions)
                for _, child in ipairs(OptionContainer:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                options = newOptions
                OptionContainer.Size = UDim2.new(1, 0, 0, (#options * 32))
                for _, opt in ipairs(options) do
                    local OptBtn = Instance.new("TextButton")
                    OptBtn.Size = UDim2.new(1, 0, 0, 32)
                    OptBtn.BackgroundColor3 = Color3.fromRGB(28, 30, 38)
                    OptBtn.BorderSizePixel = 0
                    OptBtn.Font = Enum.Font.GothamMedium
                    OptBtn.Text = "  " .. opt
                    OptBtn.TextColor3 = Color3.fromRGB(200, 200, 215)
                    OptBtn.TextSize = 12
                    OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                    OptBtn.ZIndex = 7
                    OptBtn.Parent = OptionContainer

                    OptBtn.MouseButton1Click:Connect(function()
                        selected = opt
                        DropTitle.Text = dropName .. ": " .. selected
                        opened = false
                        TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 36)}):Play()
                        TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                        pcall(callback, selected)
                    end)
                end
            end

            RefreshOptions(options)

            MainBtn.MouseButton1Click:Connect(function()
                opened = not opened
                local targetHeight = opened and (36 + (#options * 32)) or 36
                TweenService:Create(DropFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
                TweenService:Create(Arrow, TweenInfo.new(0.2), {Rotation = opened and 180 or 0}):Play()
            end)

            return {Refresh = RefreshOptions}
        end

        return TabElements
    end

    return Window
end

-- ==========================================
-- ИНИЦИАЛИЗАЦИЯ VANEGOOD HUB ЧЕРЕЗ БИБЛИОТЕКУ
-- ==========================================
local Window = Library:CreateWindow({Name = "VANEGOOD HUB"})

local ScriptsTab = Window:CreateTab("СКРИПТЫ")
local GamesTab = Window:CreateTab("ИГРЫ")
local TrollTab = Window:CreateTab("ТРОЛЛИНГ")

-- ------------------------------------------
-- 1. Anti-AFK
-- ------------------------------------------
local afkEnabled = false
local virtualUser = game:GetService("VirtualUser")

LocalPlayer.Idled:Connect(function()
    if afkEnabled then
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new())
    end
end)

ScriptsTab:CreateToggle({
    Name = "Anti-AFK",
    Default = false,
    Callback = function(val)
        afkEnabled = val
    end
})

-- ------------------------------------------
-- 2. ESP
-- ------------------------------------------
local espEnabled = false
local espObjects = {}
local lastUpdate = 0
local updateInterval = 0.2

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj.highlight then obj.highlight:Destroy() end
        if obj.label then obj.label:Destroy() end
    end
    espObjects = {}
end

local function isEnemy(player)
    if player:FindFirstChild("Team") and player.Team.Name:lower():find("killer") then return true end
    if player.Team and LocalPlayer.Team then return player.Team ~= LocalPlayer.Team end
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local tool = player.Character:FindFirstChildOfClass("Tool")
        if tool or (humanoid and humanoid:GetAttribute("CanAttack") == true) then return true end
    end
    return false
end

local function isAlly(player)
    if player.Team and LocalPlayer.Team then return player.Team == LocalPlayer.Team end
    return false
end

local function updateESP()
    if not espEnabled then return end
    local currentTime = os.clock()
    if currentTime - lastUpdate < updateInterval then return end
    lastUpdate = currentTime

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = player.Character:FindFirstChild("Humanoid")

            if rootPart and humanoid and humanoid.Health > 0 then
                local enemy = isEnemy(player)
                local ally = isAlly(player)

                if not espObjects[player] then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 0.85
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = player.Character

                    local label = Instance.new("TextLabel")
                    label.Name = "ESPLabel"
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.Font = Enum.Font.Gotham
                    label.TextSize = 12
                    label.TextStrokeTransparency = 0.7
                    label.TextStrokeColor3 = Color3.new(0, 0, 0)
                    label.Parent = parentObj:FindFirstChild("vanegood_UI") or parentObj

                    espObjects[player] = {highlight = highlight, label = label}
                end

                local espData = espObjects[player]
                if enemy then
                    espData.highlight.FillColor = Color3.fromRGB(255, 70, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(180, 0, 0)
                elseif ally then
                    espData.highlight.FillColor = Color3.fromRGB(70, 255, 70)
                    espData.highlight.OutlineColor = Color3.fromRGB(0, 180, 0)
                else
                    espData.highlight.FillColor = Color3.fromRGB(70, 70, 255)
                    espData.highlight.OutlineColor = Color3.fromRGB(0, 0, 180)
                end

                local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                if onScreen then
                    local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
                        and (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude or 0
                    espData.label.Text = string.format("%s [%d]", player.Name, math.floor(dist))
                    espData.label.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 35)
                    espData.label.Visible = true
                else
                    espData.label.Visible = false
                end
            else
                if espObjects[player] then
                    if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
                    if espObjects[player].label then espObjects[player].label:Destroy() end
                    espObjects[player] = nil
                end
            end
        else
            if espObjects[player] then
                if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
                if espObjects[player].label then espObjects[player].label:Destroy() end
                espObjects[player] = nil
            end
        end
    end
end

RunService.Heartbeat:Connect(updateESP)

Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        if espObjects[player].highlight then espObjects[player].highlight:Destroy() end
        if espObjects[player].label then espObjects[player].label:Destroy() end
        espObjects[player] = nil
    end
end)

ScriptsTab:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(val)
        espEnabled = val
        if not espEnabled then clearESP() end
    end
})

-- ------------------------------------------
-- 3. HitBox
-- ------------------------------------------
local hitBoxEnabled = false
local hitBoxSize = 20

local function resetHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Size = Vector3.new(2, 2, 1)
                rootPart.Transparency = 0
                rootPart.BrickColor = BrickColor.new("Medium stone grey")
                rootPart.Material = Enum.Material.Plastic
                rootPart.CanCollide = true
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if hitBoxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                pcall(function()
                    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        rootPart.Size = Vector3.new(hitBoxSize, hitBoxSize, hitBoxSize)
                        rootPart.Transparency = 0.7
                        rootPart.BrickColor = BrickColor.new("Really red")
                        rootPart.Material = Enum.Material.Neon
                        rootPart.CanCollide = false
                    end
                end)
            end
        end
    end
end)

ScriptsTab:CreateToggle({
    Name = "HitBox Extender",
    Default = false,
    Callback = function(val)
        hitBoxEnabled = val
        if not hitBoxEnabled then resetHitboxes() end
    end
})

ScriptsTab:CreateSlider({
    Name = "HitBox Size",
    Min = 2,
    Max = 100,
    Default = 20,
    Callback = function(val)
        hitBoxSize = val
    end
})

-- ------------------------------------------
-- 4. Fly
-- ------------------------------------------
local flyEnabled = false
local flySpeed = 50
local bv, bg
local flyConnections = {}

local function setupFlyChar(character)
    if flyEnabled and character and character:FindFirstChild("HumanoidRootPart") then
        if character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
            character.HumanoidRootPart.VelocityHandler:Destroy()
        end
        if character.HumanoidRootPart:FindFirstChild("GyroHandler") then
            character.HumanoidRootPart.GyroHandler:Destroy()
        end

        bv = Instance.new("BodyVelocity")
        bv.Name = "VelocityHandler"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = character.HumanoidRootPart

        bg = Instance.new("BodyGyro")
        bg.Name = "GyroHandler"
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 1000
        bg.D = 50
        bg.Parent = character.HumanoidRootPart

        local hum = character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = true end
    end
end

local function disableFly()
    flyEnabled = false
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.PlatformStand = false
        if LocalPlayer.Character.HumanoidRootPart then
            if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("VelocityHandler") then
                LocalPlayer.Character.HumanoidRootPart.VelocityHandler:Destroy()
            end
            if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("GyroHandler") then
                LocalPlayer.Character.HumanoidRootPart.GyroHandler:Destroy()
            end
        end
    end
    for _, conn in pairs(flyConnections) do conn:Disconnect() end
    flyConnections = {}
end

local function enableFly()
    flyEnabled = true
    if #flyConnections == 0 then
        table.insert(flyConnections, LocalPlayer.CharacterAdded:Connect(function(char)
            setupFlyChar(char)
            local hum = char:WaitForChild("Humanoid", 5)
            if hum then
                hum.Died:Connect(function()
                    if flyEnabled then
                        task.wait()
                        if LocalPlayer.Character then setupFlyChar(LocalPlayer.Character) end
                    end
                end)
            end
        end))

        table.insert(flyConnections, RunService.RenderStepped:Connect(function()
            if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local vh = hrp:FindFirstChild("VelocityHandler")
                local gh = hrp:FindFirstChild("GyroHandler")
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                if vh and gh and hum then
                    hum.PlatformStand = true
                    gh.CFrame = Camera.CoordinateFrame
                    local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
                    local dir = controlModule:GetMoveVector()
                    local vel = Vector3.new()

                    if dir.X > 0 then vel = vel + Camera.CFrame.RightVector * (dir.X * flySpeed) end
                    if dir.X < 0 then vel = vel + Camera.CFrame.RightVector * (dir.X * flySpeed) end
                    if dir.Z > 0 then vel = vel - Camera.CFrame.LookVector * (dir.Z * flySpeed) end
                    if dir.Z < 0 then vel = vel - Camera.CFrame.LookVector * (dir.Z * flySpeed) end

                    vh.Velocity = vel
                end
            end
        end))
    end
    if LocalPlayer.Character then setupFlyChar(LocalPlayer.Character) end
end

ScriptsTab:CreateToggle({
    Name = "Fly",
    Default = false,
    Callback = function(val)
        if val then enableFly() else disableFly() end
    end
})

ScriptsTab:CreateSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 300,
    Default = 50,
    Callback = function(val)
        flySpeed = val
    end
})

-- ------------------------------------------
-- 5. Speed (WalkSpeed)
-- ------------------------------------------
local speedEnabled = false
local currentSpeed = 16
local speedConn = nil

local function setCharSpeed(speed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end

ScriptsTab:CreateToggle({
    Name = "WalkSpeed Hack",
    Default = false,
    Callback = function(val)
        speedEnabled = val
        if speedEnabled then
            if not speedConn then
                speedConn = RunService.Heartbeat:Connect(function()
                    if speedEnabled then setCharSpeed(currentSpeed) end
                end)
            end
            setCharSpeed(currentSpeed)
        else
            if speedConn then speedConn:Disconnect() speedConn = nil end
            setCharSpeed(16)
        end
    end
})

ScriptsTab:CreateSlider({
    Name = "Speed Value",
    Min = 16,
    Max = 300,
    Default = 16,
    Callback = function(val)
        currentSpeed = val
        if speedEnabled then setCharSpeed(currentSpeed) end
    end
})

-- ------------------------------------------
-- 6. InfJump
-- ------------------------------------------
local infJumpEnabled = false
local infJumpConn = nil

ScriptsTab:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(val)
        infJumpEnabled = val
        if infJumpEnabled then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                if infJumpEnabled and LocalPlayer.Character then
                    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end)
        else
            if infJumpConn then infJumpConn:Disconnect() infJumpConn = nil end
        end
    end
})

-- ------------------------------------------
-- 7. Spectate (Вкладка ТРОЛЛИНГ / СКРИПТЫ)
-- ------------------------------------------
local spectateTarget = nil

local function getPlayerNames()
    local list = {"Сбросить (Себя)"}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

local specDropdown = TrollTab:CreateDropdown({
    Name = "Spectate Player",
    Options = getPlayerNames(),
    Callback = function(selected)
        if selected == "Сбросить (Себя)" then
            spectateTarget = nil
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
            end
        else
            local targetPlayer = Players:FindFirstChild(selected)
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                spectateTarget = targetPlayer
                Camera.CameraSubject = targetPlayer.Character.Humanoid
            end
        end
    end
})

TrollTab:CreateButton({
    Name = "Обновить список игроков",
    Callback = function()
        specDropdown.Refresh(getPlayerNames())
    end
})
