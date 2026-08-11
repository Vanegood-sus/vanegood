-- [[ vanegood UI Library ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local vanegood = {}
vanegood.__index = vanegood

-- Хелпер для анимаций
local function tween(object, goal, duration)
    duration = duration or 0.2
    local info = TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local anim = TweenService:Create(object, info, goal)
    anim:Play()
    return anim
end

-- Система загрузки и кэширования иконок Lucide
local function ApplyLucideIcon(imageLabel, iconName)
    if not iconName or iconName == "" then 
        imageLabel.Visible = false
        return 
    end

    imageLabel.Visible = true
    imageLabel.Image = "rbxassetid://6031068421" -- Запасной плейсхолдер на время загрузки

    task.spawn(function()
        local folder = "vanegood_assets"
        local path = folder .. "/" .. iconName .. ".png"
        local url = "https://raw.githubusercontent.com/lucide-icons/lucide/main/icons/" .. iconName .. ".png"

        if writefile and readfile and isfile and getcustomasset then
            if not isfolder or not isfolder(folder) then
                if makefolder then makefolder(folder) end
            end

            if not isfile(path) then
                local success, data = pcall(function() return game:HttpGet(url) end)
                if success and data and #data > 0 then
                    writefile(path, data)
                end
            end

            if isfile(path) then
                imageLabel.Image = getcustomasset(path)
            end
        end
    end)
end

-- Функция создания окна
function vanegood:CreateWindow(config)
    -- Удаляем старое окно при повторном запуске
    local existing = (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui"):FindFirstChild("vanegood_UI")) 
        or LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("vanegood_UI")
    if existing then existing:Destroy() end

    local windowTitle = config.Title or "vanegood"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "vanegood_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local parentTarget = (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui")) or LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Parent = parentTarget

    -- Главный фрейм
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 580, 0, 360)
    Main.Position = UDim2.new(0.5, -290, 0.5, -180)
    Main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
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

    -- Верхняя панель (Header / Drag)
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 42)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = Main

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = windowTitle
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Position = UDim2.new(0, 16, 0, 0)
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = TopBar

    -- Перемещение окна мышью / тачем
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Боковая панель вкладок (Sidebar)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 140, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundTransparency = 1
    Sidebar.BorderSizePixel = 0
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = Main

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, 6)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Parent = Sidebar

    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 6)
    SidebarPadding.Parent = Sidebar

    -- Контейнер страниц
    local PagesFolder = Instance.new("Frame")
    PagesFolder.Name = "Pages"
    PagesFolder.Size = UDim2.new(1, -150, 1, -48)
    PagesFolder.Position = UDim2.new(0, 144, 0, 42)
    PagesFolder.BackgroundTransparency = 1
    PagesFolder.Parent = Main

    local WindowObj = {
        Tabs = {},
        ActiveTab = nil
    }

    -- Метод добавления вкладки (с иконкой Lucide)
    function WindowObj:CreateTab(name, iconName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 126, 0, 34)
        TabBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
        TabBtn.AutoButtonColor = false
        TabBtn.Text = ""
        TabBtn.Parent = Sidebar

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabBtn

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 8, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.ImageColor3 = Color3.fromRGB(160, 160, 175)
        TabIcon.Parent = TabBtn
        ApplyLucideIcon(TabIcon, iconName)

        local TabText = Instance.new("TextLabel")
        TabText.Text = name
        TabText.Font = Enum.Font.GothamMedium
        TabText.TextSize = 13
        TabText.TextColor3 = Color3.fromRGB(160, 160, 175)
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.Position = iconName and UDim2.new(0, 32, 0, 0) or UDim2.new(0, 12, 0, 0)
        TabText.Size = iconName and UDim2.new(1, -36, 1, 0) or UDim2.new(1, -16, 1, 0)
        TabText.BackgroundTransparency = 1
        TabText.Parent = TabBtn

        -- Контейнер элементов страницы
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "_Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 3
        Page.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 65)
        Page.Visible = false
        Page.Parent = PagesFolder

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = Page

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 4)
        PagePadding.PaddingRight = UDim.new(0, 8)
        PagePadding.Parent = Page

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 12)
        end)

        local function activateTab()
            for _, t in pairs(WindowObj.Tabs) do
                tween(t.Button, {BackgroundColor3 = Color3.fromRGB(24, 24, 30)})
                tween(t.TextLabel, {TextColor3 = Color3.fromRGB(160, 160, 175)})
                tween(t.Icon, {ImageColor3 = Color3.fromRGB(160, 160, 175)})
                t.Page.Visible = false
            end
            tween(TabBtn, {BackgroundColor3 = Color3.fromRGB(35, 35, 48)})
            tween(TabText, {TextColor3 = Color3.fromRGB(255, 255, 255)})
            tween(TabIcon, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            Page.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(activateTab)

        local TabObj = {
            Button = TabBtn,
            TextLabel = TabText,
            Icon = TabIcon,
            Page = Page
        }
        table.insert(WindowObj.Tabs, TabObj)

        if #WindowObj.Tabs == 1 then
            activateTab()
        end

        -- 1. Кнопка (Button)
        function TabObj:CreateButton(btnText, iconName, callback)
            if type(iconName) == "function" then
                callback = iconName
                iconName = nil
            end
            callback = callback or function() end
            
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 36)
            Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            Btn.Text = ""
            Btn.AutoButtonColor = false
            Btn.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Btn

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(45, 45, 58)
            Stroke.Thickness = 1
            Stroke.Parent = Btn

            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 18, 0, 18)
            Icon.Position = UDim2.new(0, 12, 0.5, -9)
            Icon.BackgroundTransparency = 1
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 215)
            Icon.Parent = Btn
            ApplyLucideIcon(Icon, iconName)

            local Label = Instance.new("TextLabel")
            Label.Text = btnText
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(230, 230, 235)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = iconName and UDim2.new(0, 38, 0, 0) or UDim2.new(0, 12, 0, 0)
            Label.Size = iconName and UDim2.new(1, -44, 1, 0) or UDim2.new(1, -24, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Parent = Btn

            Btn.MouseEnter:Connect(function() tween(Btn, {BackgroundColor3 = Color3.fromRGB(32, 32, 42)}) end)
            Btn.MouseLeave:Connect(function() tween(Btn, {BackgroundColor3 = Color3.fromRGB(25, 25, 32)}) end)
            Btn.MouseButton1Click:Connect(function()
                tween(Btn, {BackgroundColor3 = Color3.fromRGB(45, 45, 60)}, 0.08).Completed:Connect(function()
                    tween(Btn, {BackgroundColor3 = Color3.fromRGB(32, 32, 42)}, 0.1)
                end)
                task.spawn(callback)
            end)
        end

        -- 2. Переключатель (Toggle)
        function TabObj:CreateToggle(toggleText, default, iconName, callback)
            if type(iconName) == "function" then
                callback = iconName
                iconName = nil
            end
            local state = default or false
            callback = callback or function() end

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 38)
            Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(45, 45, 58)
            Stroke.Thickness = 1
            Stroke.Parent = Frame

            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 18, 0, 18)
            Icon.Position = UDim2.new(0, 12, 0.5, -9)
            Icon.BackgroundTransparency = 1
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 215)
            Icon.Parent = Frame
            ApplyLucideIcon(Icon, iconName)

            local Label = Instance.new("TextLabel")
            Label.Text = toggleText
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(220, 220, 230)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = iconName and UDim2.new(0, 38, 0, 0) or UDim2.new(0, 12, 0, 0)
            Label.Size = iconName and UDim2.new(1, -95, 1, 0) or UDim2.new(1, -65, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Parent = Frame

            local Switch = Instance.new("TextButton")
            Switch.Size = UDim2.new(0, 38, 0, 20)
            Switch.Position = UDim2.new(1, -48, 0.5, -10)
            Switch.BackgroundColor3 = state and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(45, 45, 55)
            Switch.Text = ""
            Switch.AutoButtonColor = false
            Switch.Parent = Frame

            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = Switch

            local Dot = Instance.new("Frame")
            Dot.Size = UDim2.new(0, 14, 0, 14)
            Dot.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
            Dot.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
            Dot.BorderSizePixel = 0
            Dot.Parent = Switch

            local DotCorner = Instance.new("UICorner")
            DotCorner.CornerRadius = UDim.new(1, 0)
            DotCorner.Parent = Dot

            local function updateToggle()
                if state then
                    tween(Switch, {BackgroundColor3 = Color3.fromRGB(0, 130, 230)})
                    tween(Dot, {Position = UDim2.new(1, -17, 0.5, -7)})
                else
                    tween(Switch, {BackgroundColor3 = Color3.fromRGB(45, 45, 55)})
                    tween(Dot, {Position = UDim2.new(0, 3, 0.5, -7)})
                end
                task.spawn(callback, state)
            end

            Switch.MouseButton1Click:Connect(function()
                state = not state
                updateToggle()
            end)
        end

        -- 3. Ползунок (Slider)
        function TabObj:CreateSlider(sliderText, min, max, default, iconName, callback)
            if type(iconName) == "function" then
                callback = iconName
                iconName = nil
            end
            min = min or 0
            max = max or 100
            default = default or min
            callback = callback or function() end
            local value = default

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 48)
            Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(45, 45, 58)
            Stroke.Thickness = 1
            Stroke.Parent = Frame

            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 16, 0, 16)
            Icon.Position = UDim2.new(0, 12, 0, 7)
            Icon.BackgroundTransparency = 1
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 215)
            Icon.Parent = Frame
            ApplyLucideIcon(Icon, iconName)

            local Label = Instance.new("TextLabel")
            Label.Text = sliderText
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(220, 220, 230)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = iconName and UDim2.new(0, 34, 0, 6) or UDim2.new(0, 12, 0, 6)
            Label.Size = UDim2.new(0.5, 0, 0, 18)
            Label.BackgroundTransparency = 1
            Label.Parent = Frame

            local ValLabel = Instance.new("TextLabel")
            ValLabel.Text = tostring(value)
            ValLabel.Font = Enum.Font.Gotham
            ValLabel.TextSize = 12
            ValLabel.TextColor3 = Color3.fromRGB(160, 160, 175)
            ValLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValLabel.Position = UDim2.new(0.5, 0, 0, 6)
            ValLabel.Size = UDim2.new(0.5, -12, 0, 18)
            ValLabel.BackgroundTransparency = 1
            ValLabel.Parent = Frame

            local Track = Instance.new("Frame")
            Track.Size = UDim2.new(1, -24, 0, 4)
            Track.Position = UDim2.new(0, 12, 0, 32)
            Track.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
            Track.BorderSizePixel = 0
            Track.Parent = Frame

            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(1, 0)
            TrackCorner.Parent = Track

            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = Color3.fromRGB(0, 130, 230)
            Fill.BorderSizePixel = 0
            Fill.Parent = Track

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = Fill

            local isSliding = false
            local function updateSlide(input)
                local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                value = math.floor(min + ((max - min) * pos))
                ValLabel.Text = tostring(value)
                tween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.05)
                task.spawn(callback, value)
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isSliding = true
                    updateSlide(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isSliding = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlide(input)
                end
            end)
        end

        -- 4. Поле ввода (Input Box)
        function TabObj:CreateInput(inputText, placeholder, iconName, callback)
            if type(iconName) == "function" then
                callback = iconName
                iconName = nil
            end
            callback = callback or function() end

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 42)
            Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(45, 45, 58)
            Stroke.Thickness = 1
            Stroke.Parent = Frame

            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 18, 0, 18)
            Icon.Position = UDim2.new(0, 12, 0.5, -9)
            Icon.BackgroundTransparency = 1
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 215)
            Icon.Parent = Frame
            ApplyLucideIcon(Icon, iconName)

            local Label = Instance.new("TextLabel")
            Label.Text = inputText
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(220, 220, 230)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = iconName and UDim2.new(0, 38, 0, 0) or UDim2.new(0, 12, 0, 0)
            Label.Size = iconName and UDim2.new(0.45, 0, 1, 0) or UDim2.new(0.5, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Parent = Frame

            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(0.45, 0, 0, 26)
            Box.Position = UDim2.new(0.55, -10, 0.5, -13)
            Box.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
            Box.PlaceholderText = placeholder or "Введите..."
            Box.PlaceholderColor3 = Color3.fromRGB(110, 110, 120)
            Box.Text = ""
            Box.Font = Enum.Font.Gotham
            Box.TextSize = 12
            Box.TextColor3 = Color3.fromRGB(240, 240, 245)
            Box.ClearTextOnFocus = false
            Box.Parent = Frame

            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 4)
            BoxCorner.Parent = Box

            local BoxStroke = Instance.new("UIStroke")
            BoxStroke.Color = Color3.fromRGB(40, 40, 50)
            BoxStroke.Thickness = 1
            BoxStroke.Parent = Box

            Box.FocusLost:Connect(function(enterPressed)
                task.spawn(callback, Box.Text, enterPressed)
            end)
        end

        -- 5. Выпадающий список (Dropdown)
        function TabObj:CreateDropdown(dropdownText, options, iconName, callback)
            if type(iconName) == "function" then
                callback = iconName
                iconName = nil
            end
            options = options or {}
            callback = callback or function() end
            local opened = false

            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1, 0, 0, 38)
            Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            Frame.ClipsDescendants = true
            Frame.Parent = Page

            local Corner = Instance.new("UICorner")
            Corner.CornerRadius = UDim.new(0, 6)
            Corner.Parent = Frame

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Color3.fromRGB(45, 45, 58)
            Stroke.Thickness = 1
            Stroke.Parent = Frame

            local HeaderBtn = Instance.new("TextButton")
            HeaderBtn.Size = UDim2.new(1, 0, 0, 38)
            HeaderBtn.BackgroundTransparency = 1
            HeaderBtn.Text = ""
            HeaderBtn.Parent = Frame

            local Icon = Instance.new("ImageLabel")
            Icon.Size = UDim2.new(0, 18, 0, 18)
            Icon.Position = UDim2.new(0, 12, 0.5, -9)
            Icon.BackgroundTransparency = 1
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 215)
            Icon.Parent = HeaderBtn
            ApplyLucideIcon(Icon, iconName)

            local Label = Instance.new("TextLabel")
            Label.Text = dropdownText
            Label.Font = Enum.Font.GothamMedium
            Label.TextSize = 13
            Label.TextColor3 = Color3.fromRGB(220, 220, 230)
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Position = iconName and UDim2.new(0, 38, 0, 0) or UDim2.new(0, 12, 0, 0)
            Label.Size = iconName and UDim2.new(0.55, 0, 0, 38) or UDim2.new(0.6, 0, 0, 38)
            Label.BackgroundTransparency = 1
            Label.Parent = HeaderBtn

            local SelectedLabel = Instance.new("TextLabel")
            SelectedLabel.Text = options[1] or "None"
            SelectedLabel.Font = Enum.Font.Gotham
            SelectedLabel.TextSize = 12
            SelectedLabel.TextColor3 = Color3.fromRGB(150, 150, 165)
            SelectedLabel.TextXAlignment = Enum.TextXAlignment.Right
            SelectedLabel.Position = UDim2.new(0.6, 0, 0, 0)
            SelectedLabel.Size = UDim2.new(0.4, -12, 0, 38)
            SelectedLabel.BackgroundTransparency = 1
            SelectedLabel.Parent = HeaderBtn

            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, -20, 0, #options * 28)
            OptionContainer.Position = UDim2.new(0, 10, 0, 40)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.Parent = Frame

            local OptLayout = Instance.new("UIListLayout")
            OptLayout.Padding = UDim.new(0, 2)
            OptLayout.Parent = OptionContainer

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 26)
                OptBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
                OptBtn.Text = opt
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 12
                OptBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
                OptBtn.Parent = OptionContainer

                local OptCorner = Instance.new("UICorner")
                OptCorner.CornerRadius = UDim.new(0, 4)
                OptCorner.Parent = OptBtn

                OptBtn.MouseButton1Click:Connect(function()
                    SelectedLabel.Text = opt
                    opened = false
                    tween(Frame, {Size = UDim2.new(1, 0, 0, 38)})
                    task.spawn(callback, opt)
                end)
            end

            HeaderBtn.MouseButton1Click:Connect(function()
                opened = not opened
                local targetHeight = opened and (44 + (#options * 28)) or 38
                tween(Frame, {Size = UDim2.new(1, 0, 0, targetHeight)})
            end)
        end

        return TabObj
    end

    return WindowObj
end

-- ==========================================
-- Пример использования / Демонстрация
-- ==========================================

local Window = vanegood:CreateWindow({
    Title = "vanegood"
})

-- Вкладки с Lucide иконками
local MainTab = Window:CreateTab("Главная", "home")
local VisualsTab = Window:CreateTab("Бой / Аим", "crosshair")
local SettingsTab = Window:CreateTab("Настройки", "settings")

-- Элементы с иконками
MainTab:CreateButton("Телепорт на базу", "map-pin", function()
    print("Кнопка нажата!")
end)

MainTab:CreateToggle("Авто-фарм", false, "zap", function(state)
    print("Авто-фарм:", state)
end)

MainTab:CreateSlider("Скорость бега (WalkSpeed)", 16, 150, 16, "gauge", function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

MainTab:CreateInput("Кастомная команда", "Введи текст...", "terminal", function(text)
    print("Введено:", text)
end)

MainTab:CreateDropdown("Выбор цели", {"Ближайший", "Слабый HP", "Случайный"}, "target", function(selected)
    print("Цель:", selected)
end)
