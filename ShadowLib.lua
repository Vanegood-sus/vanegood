local Shadow = {}
Shadow.__index = Shadow

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Уведомления (Rayfield Notify)
function Shadow:Notify(config)
    config = config or {}
    local title = config.Title or "Shadow Hub"
    local content = config.Content or "Уведомление"
    local duration = config.Duration or 4

    local parentTarget = CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
    local NotifyGui = parentTarget:FindFirstChild("ShadowNotifyGui")
    
    if not NotifyGui then
        NotifyGui = Instance.new("ScreenGui")
        NotifyGui.Name = "ShadowNotifyGui"
        NotifyGui.ResetOnSpawn = false
        NotifyGui.Parent = parentTarget
        
        local Holder = Instance.new("Frame")
        Holder.Name = "Holder"
        Holder.Size = UDim2.new(0, 280, 1, -20)
        Holder.Position = UDim2.new(1, -290, 0, 10)
        Holder.BackgroundTransparency = 1
        Holder.Parent = NotifyGui

        local Layout = Instance.new("UIListLayout")
        Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        Layout.Padding = UDim.new(0, 8)
        Layout.Parent = Holder
    end

    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 60)
    Card.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Card.BorderSizePixel = 0
    Card.BackgroundTransparency = 1
    Card.Parent = NotifyGui.Holder

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Card

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(0, 150, 255)
    Stroke.Thickness = 1
    Stroke.Transparency = 1
    Stroke.Parent = Card

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 22)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 13
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextTransparency = 1
    TitleLabel.Parent = Card

    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Size = UDim2.new(1, -20, 0, 28)
    ContentLabel.Position = UDim2.new(0, 10, 0, 25)
    ContentLabel.Text = content
    ContentLabel.Font = Enum.Font.Gotham
    ContentLabel.TextSize = 11
    ContentLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.TextWrapped = true
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.TextTransparency = 1
    ContentLabel.Parent = Card

    TweenService:Create(Card, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    TweenService:Create(TitleLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    TweenService:Create(ContentLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()

    task.delay(duration, function()
        local tw = TweenService:Create(Card, TweenInfo.new(0.3), {BackgroundTransparency = 1})
        TweenService:Create(Stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(ContentLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        tw:Play()
        tw.Completed:Connect(function() Card:Destroy() end)
    end)
end

-- Создание главного окна
function Shadow:CreateWindow(config)
    config = config or {}
    local hubTitle = config.Name or "SHADOW HUB"
    local toggleKey = config.ToggleKey or Enum.KeyCode.RightControl

    local parentTarget = CoreGui:FindFirstChild("RobloxGui") or Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ShadowUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = parentTarget

    -- Главный Frame
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 600, 0, 380)
    Main.Position = UDim2.new(0.5, -300, 0.5, -190)
    Main.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(40, 40, 50)
    MainStroke.Thickness = 1
    MainStroke.Parent = Main

    -- Шапка
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 38)
    TopBar.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -80, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.Text = hubTitle
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 13
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TopBar

    -- Кнопка закрыть X
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -34, 0, 4)
    CloseBtn.Text = "×"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 18
    CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Parent = TopBar

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- Кнопка свернуть -
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -60, 0, 4)
    MinimizeBtn.Text = "─"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 12
    MinimizeBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Parent = TopBar

    MinimizeBtn.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)

    -- Назначенная клавиша открытия/закрытия
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == toggleKey then
            Main.Visible = not Main.Visible
        end
    end)

    -- Перетаскивание
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Сайдбар Fluent
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 140, 1, -38)
    Sidebar.Position = UDim2.new(0, 0, 0, 38)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    local TabHolder = Instance.new("ScrollingFrame")
    TabHolder.Size = UDim2.new(1, 0, 1, -10)
    TabHolder.Position = UDim2.new(0, 0, 0, 5)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    TabHolder.Parent = Sidebar

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.Padding = UDim.new(0, 4)
    TabLayout.Parent = TabHolder

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -150, 1, -48)
    ContentContainer.Position = UDim2.new(0, 145, 0, 43)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = Main

    -- Приветствие
    Shadow:Notify({
        Title = hubTitle,
        Content = "Shadow Hub загружен! Кнопка скрытия: [" .. toggleKey.Name .. "]",
        Duration = 5
    })

    local Window = { Tabs = {} }

    function Window:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, -8, 0, 32)
        TabBtn.Position = UDim2.new(0, 4, 0, 0)
        TabBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "   " .. tabName
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextSize = 12
        TabBtn.TextColor3 = Color3.fromRGB(140, 140, 150)
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.Parent = TabHolder

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 3, 0, 16)
        Indicator.Position = UDim2.new(0, 0, 0.5, -8)
        Indicator.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        Indicator.Visible = false
        Indicator.Parent = TabBtn

        local Page = Instance.new("ScrollingFrame")
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
        Page.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = Page

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Page.Visible = false
                t.Button.BackgroundTransparency = 1
                t.Button.TextColor3 = Color3.fromRGB(140, 140, 150)
                t.Indicator.Visible = false
            end
            Page.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.Visible = true
        end)

        local Tab = { Page = Page, Button = TabBtn, Indicator = Indicator }
        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            Page.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.Visible = true
        end

        -- Кнопка
        function Tab:CreateButton(btnText, callback)
            callback = callback or function() end
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 34)
            Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(35, 35, 45)
            Stroke.Thickness = 1
            Stroke.Parent = Frame

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 1, 0)
            Btn.BackgroundTransparency = 1
            Btn.Text = btnText
            Btn.Font = Enum.Font.GothamSemibold
            Btn.TextSize = 12
            Btn.TextColor3 = Color3.fromRGB(220, 220, 230)
            Btn.Parent = Frame

            Btn.MouseButton1Click:Connect(function()
                Stroke.Color = Color3.fromRGB(0, 150, 255)
                task.delay(0.15, function() Stroke.Color = Color3.fromRGB(35, 35, 45) end)
                callback()
            end)
        end

        -- Слайдер
        function Tab:CreateSlider(text, min, max, default, callback)
            callback = callback or function() end
            default = math.clamp(default or min, min, max)

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 46)
            Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -20, 0, 20)
            Label.Position = UDim2.new(0, 10, 0, 4)
            Label.Text = text .. ": " .. tostring(default)
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 11
            Label.TextColor3 = Color3.fromRGB(200, 200, 210)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.BackgroundTransparency = 1
            Label.Parent = Frame

            local SliderBack = Instance.new("Frame")
            SliderBack.Size = UDim2.new(1, -20, 0, 5)
            SliderBack.Position = UDim2.new(0, 10, 0, 28)
            SliderBack.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
            SliderBack.BorderSizePixel = 0
            SliderBack.Parent = Frame

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBack

            local Sliding = false

            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + ((max - min) * pos))
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                Label.Text = text .. ": " .. tostring(val)
                callback(val)
            end

            SliderBack.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Sliding = true
                    updateSlider(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Sliding = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if Sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
        end

        -- Дропдаун
        function Tab:CreateDropdown(text, options, default, callback)
            callback = callback or function() end
            options = options or {}
            local selected = default or options[1] or "None"

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, -10, 0, 36)
            Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            Frame.ClipsDescendants = true
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local DropBtn = Instance.new("TextButton")
            DropBtn.Size = UDim2.new(1, 0, 0, 36)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = "  " .. text .. ": " .. tostring(selected)
            DropBtn.Font = Enum.Font.GothamMedium
            DropBtn.TextSize = 12
            DropBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            DropBtn.TextXAlignment = Enum.TextXAlignment.Left
            DropBtn.Parent = Frame

            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, -10, 0, #options * 26)
            OptionContainer.Position = UDim2.new(0, 5, 0, 36)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.Parent = Frame

            local OptionLayout = Instance.new("UIListLayout")
            OptionLayout.Padding = UDim.new(0, 2)
            OptionLayout.Parent = OptionContainer

            local isOpen = false
            DropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                local targetSize = isOpen and UDim2.new(1, -10, 0, 38 + (#options * 26)) or UDim2.new(1, -10, 0, 36)
                TweenService:Create(Frame, TweenInfo.new(0.2), {Size = targetSize}):Play()
            end)

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 24)
                OptBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
                OptBtn.Text = opt
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 11
                OptBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
                OptBtn.Parent = OptionContainer

                local OptCorner = Instance.new("UICorner")
                OptCorner.CornerRadius = UDim.new(0, 4)
                OptCorner.Parent = OptBtn

                OptBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    DropBtn.Text = "  " .. text .. ": " .. tostring(selected)
                    isOpen = false
                    TweenService:Create(Frame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 36)}):Play()
                    callback(selected)
                end)
            end
        end

        return Tab
    end

    return Window
end

return Shadow
