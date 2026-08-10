local Shadow = {}
Shadow.__index = Shadow

-- Создание главного окна
function Shadow:CreateWindow(config)
    config = config or {}
    local hubTitle = config.Name or "SHADOW"
    
    -- Инициализация ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ShadowUI"
    ScreenGui.ResetOnSpawn = false
    
    -- Защита от обнаружения / вставка в CoreGui
    local parentTarget = (gethui and gethui()) or game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Parent = parentTarget

    -- Главное окно (стиль Rayfield: темный #131313, глубокие тени)
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 620, 0, 400)
    Main.Position = UDim2.new(0.5, -310, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    -- Обводка/Свечение в стиле Rayfield (Glow/Stroke)
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(45, 45, 55)
    MainStroke.Thickness = 1
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = Main

    -- Верхняя шапка (TopBar)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 42)
    TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Text = hubTitle
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TopBar

    -- Перетаскивание окна (Drag System)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

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
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Сайдбар слева (Стиль Fluent)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 160, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = Main

    local TabHolder = Instance.new("ScrollingFrame")
    TabHolder.Size = UDim2.new(1, 0, 1, -10)
    TabHolder.Position = UDim2.new(0, 0, 0, 5)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 2
    TabHolder.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    TabHolder.Parent = Sidebar

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabHolder

    -- Контейнер для содержимого вкладок
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -170, 1, -52)
    ContentContainer.Position = UDim2.new(0, 165, 0, 47)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = Main

    local Window = {
        CurrentTab = nil,
        Tabs = {}
    }

    -- Создание вкладки (Fluent Sidebar Style)
    function Window:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabName .. "_Button"
        TabButton.Size = UDim2.new(1, -10, 0, 35)
        TabButton.Position = UDim2.new(0, 5, 0, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
        TabButton.BackgroundTransparency = 1
        TabButton.Text = "   " .. tabName
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.TextSize = 13
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 160)
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        TabButton.Parent = TabHolder

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabButton

        -- Активный индикатор полоски слева (Как у Fluent)
        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(0, 3, 0, 18)
        Indicator.Position = UDim2.new(0, 0, 0.5, -9)
        Indicator.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Голубой акцент
        Indicator.Visible = false
        Indicator.Parent = TabButton

        local IndCorner = Instance.new("UICorner")
        IndCorner.CornerRadius = UDim.new(0, 2)
        IndCorner.Parent = Indicator

        -- Страница с кнопками/элементами
        local Page = Instance.new("ScrollingFrame")
        Page.Name = tabName .. "_Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 60)
        Page.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = Page

        -- Переключение страниц
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Window.Tabs) do
                t.Page.Visible = false
                t.Button.BackgroundTransparency = 1
                t.Button.TextColor3 = Color3.fromRGB(150, 150, 160)
                t.Indicator.Visible = false
            end
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.Visible = true
        end)

        local Tab = { Page = Page, Button = TabButton, Indicator = Indicator }
        table.insert(Window.Tabs, Tab)

        -- Если первая вкладка — активируем сразу
        if #Window.Tabs == 1 then
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Indicator.Visible = true
        end

        -- Элементы внутри вкладки (Стиль Rayfield)
        function Tab:CreateButton(btnText, callback)
            callback = callback or function() end

            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Size = UDim2.new(1, -5, 0, 38)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = Page

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = ButtonFrame

            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Color = Color3.fromRGB(40, 40, 48)
            BtnStroke.Thickness = 1
            BtnStroke.Parent = ButtonFrame

            local ClickBtn = Instance.new("TextButton")
            ClickBtn.Size = UDim2.new(1, 0, 1, 0)
            ClickBtn.BackgroundTransparency = 1
            ClickBtn.Text = btnText
            ClickBtn.Font = Enum.Font.GothamSemibold
            ClickBtn.TextSize = 13
            ClickBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
            ClickBtn.Parent = ButtonFrame

            -- Эффект клика Rayfield
            ClickBtn.MouseButton1Click:Connect(function()
                BtnStroke.Color = Color3.fromRGB(0, 150, 255)
                task.delay(0.15, function()
                    BtnStroke.Color = Color3.fromRGB(40, 40, 48)
                end)
                callback()
            end)
        end

        return Tab
    end

    return Window
end

return Shadow
