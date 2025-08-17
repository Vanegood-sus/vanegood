-- Vanegood Hub for Muscle Legends
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Удаляем старый хаб, если он существует
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем кнопку с изображением
local TinyImageGui = Instance.new("ScreenGui")
TinyImageGui.Name = "TinyDraggableImage"
TinyImageGui.Parent = CoreGui
TinyImageGui.ResetOnSpawn = false

local imageSize = 75
local imageFrame = Instance.new("Frame")
imageFrame.Name = "TinyRoundedImage"
imageFrame.Size = UDim2.new(0, imageSize, 0, imageSize)
imageFrame.Position = UDim2.new(0, 20, 0, 20)
imageFrame.BackgroundTransparency = 1
imageFrame.ClipsDescendants = true
imageFrame.Parent = TinyImageGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.25, 0)
uiCorner.Parent = imageFrame

local image = Instance.new("ImageLabel")
image.Name = "Image"
image.Image = "rbxassetid://111084287166716"
image.Size = UDim2.new(1, 0, 1, 0)
image.BackgroundTransparency = 1
image.BorderSizePixel = 0
image.Parent = imageFrame

-- Перетаскивание кнопки
local touchStartPos, frameStartPos
local isDragging = false

imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        touchStartPos = input.Position
        frameStartPos = imageFrame.Position
    end
end)

imageFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - touchStartPos
        imageFrame.Position = UDim2.new(
            frameStartPos.X.Scale,
            frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale,
            frameStartPos.Y.Offset + delta.Y
        )
    end
end)

-- Основное окно хаба
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 2, 1, 2)
Border.Position = UDim2.new(0, -1, 0, -1)
Border.BackgroundTransparency = 1
Border.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 165, 50)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.3
UIStroke.Parent = Border

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "VANEGOOD HUB"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Панель вкладок
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.Parent = MainFrame

local tabs = {"МЕНЮ", "ФАРМ", "ПЕТЫ", "УБИЙСТВА", "ТЕЛЕПОРТ", "СТАТИСТИКА", "ДРУГОЕ"}
local tabButtons = {}
local tabFrames = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    tabButton.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 12
    tabButton.Parent = TabBar
    tabButtons[tabName] = tabButton

    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Size = UDim2.new(1, -20, 1, -70)
    tabFrame.Position = UDim2.new(0, 10, 0, 65)
    tabFrame.BackgroundTransparency = 1
    tabFrame.ScrollBarThickness = 3
    tabFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
    tabFrame.Visible = false
    tabFrame.Parent = MainFrame
    tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = tabFrame
    tabFrames[tabName] = tabFrame
end

local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(1/#tabs, 0, 0, 2)
ActiveTabIndicator.Position = UDim2.new(0, 0, 1, -2)
ActiveTabIndicator.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
ActiveTabIndicator.Parent = TabBar

-- Функция переключения вкладок
local function switchTab(tabName)
    for _, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
    for _, frame in pairs(tabFrames) do
        frame.Visible = false
    end
    tabButtons[tabName].BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabButtons[tabName].TextColor3 = Color3.fromRGB(220, 220, 220)
    tabFrames[tabName].Visible = true
    TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new((tabs[table.find(tabs, tabName)]-1)/#tabs, 0, 1, -2)}):Play()
end

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
end

-- Функции для создания UI элементов
local function createLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 30)
    label.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*40)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function createSwitch(parent, text, callback, default)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*40)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    container.BackgroundTransparency = 0.5
    container.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 50, 0, 25)
    toggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggleFrame.Parent = container

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 21, 0, 21)
    toggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    toggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = toggleButton

    local enabled = default or false
    local function updateToggle()
        local goal = {
            Position = enabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = enabled and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
        }
        toggleFrame.BackgroundColor3 = enabled and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
        TweenService:Create(toggleButton, TweenInfo.new(0.2), goal):Play()
    end

    toggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        updateToggle()
        callback(enabled)
    end)

    updateToggle()
    return toggleButton
end

local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*40)
    button.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(callback)
    return button
end

local function createTextBox(parent, placeholder, callback)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -20, 0, 40)
    textBox.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*40)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    textBox.PlaceholderText = placeholder
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = textBox

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)
    return textBox
end

local function createDropdown(parent, text, options, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 40)
    container.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*40)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    container.BackgroundTransparency = 0.5
    container.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Size = UDim2.new(0, 100, 0, 25)
    dropdownButton.Position = UDim2.new(1, -110, 0.5, -12)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    dropdownButton.Text = options[1]
    dropdownButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.TextSize = 14
    dropdownButton.Parent = container

    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = dropdownButton

    local dropdownFrame = Instance.new("ScrollingFrame")
    dropdownFrame.Size = UDim2.new(0, 100, 0, 100)
    dropdownFrame.Position = UDim2.new(1, -110, 0.5, 13)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    dropdownFrame.Visible = false
    dropdownFrame.ScrollBarThickness = 3
    dropdownFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
    dropdownFrame.Parent = container
    dropdownFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.Parent = dropdownFrame

    for _, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, -10, 0, 25)
        optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 12
        optionButton.Parent = dropdownFrame

        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 4)
        optionCorner.Parent = optionButton

        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = option
            dropdownFrame.Visible = false
            callback(option)
        end)
    end

    dropdownButton.MouseButton1Click:Connect(function()
        dropdownFrame.Visible = not dropdownFrame.Visible
    end)
end

-- Минимизация
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 30)
        TabBar.Visible = false
        for _, frame in pairs(tabFrames) do
            frame.Visible = false
        end
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        TabBar.Visible = true
        switchTab(tabs[1])
        MinimizeButton.Text = "—"
    end
end)

-- Закрытие
CloseButton.MouseButton1Click:Connect(function()
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Size = UDim2.new(0, 250, 0, 120)
    MessageFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MessageFrame.Parent = ScreenGui

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 0, 60)
    MessageLabel.Position = UDim2.new(0, 10, 0, 10)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = "Закрыть Vanegood Hub?"
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Font = Enum.Font.GothamBold
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = MessageFrame

    local YesButton = Instance.new("TextButton")
    YesButton.Size = UDim2.new(0, 100, 0, 30)
    YesButton.Position = UDim2.new(0.5, -105, 1, -40)
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
    YesButton.Text = "Да"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.GothamBold
    YesButton.TextSize = 14
    YesButton.Parent = MessageFrame

    local NoButton = Instance.new("TextButton")
    NoButton.Size = UDim2.new(0, 100, 0, 30)
    NoButton.Position = UDim2.new(0.5, 5, 1, -40)
    NoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    NoButton.Text = "Нет"
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.GothamBold
    NoButton.TextSize = 14
    NoButton.Parent = MessageFrame

    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        TinyImageGui:Destroy()
    end)

    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end)

-- Показ/скрытие хаба
local hubVisible = true
imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubVisible = not hubVisible
        ScreenGui.Enabled = hubVisible
        TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = hubVisible and 0 or 0.5}):Play()
    end
end)

-- Anti-AFK
local antiAFKConnection
local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    antiAFKConnection = LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-АФК активирован")
    end)
end

createSwitch(tabFrames["МЕНЮ"], "Анти-АФК", function(bool)
    if bool then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
            print("Анти-АФК отключен")
        end
    end
end, true)

-- Авто бой
local autoBrawlsFolder = Instance.new("Frame")
autoBrawlsFolder.Size = UDim2.new(1, -20, 0, 40)
autoBrawlsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["МЕНЮ"]:GetChildren()*40)
autoBrawlsFolder.BackgroundTransparency = 1
autoBrawlsFolder.Parent = tabFrames["МЕНЮ"]

createLabel(autoBrawlsFolder, "Авто бой")

createSwitch(autoBrawlsFolder, "Авто выигрыш", function(bool)
    getgenv().autoWinBrawl = bool
    local function equipPunch()
        if not getgenv().autoWinBrawl then return end
        local character = LocalPlayer.Character
        if not character then return end
        if character:FindFirstChild("Punch") then return end
        local backpack = LocalPlayer.Backpack
        for _, tool in pairs(backpack:GetChildren()) do
            if tool.ClassName == "Tool" and tool.Name == "Punch" then
                tool.Parent = character
                return
            end
        end
    end

    local function isValidTarget(player)
        if player == LocalPlayer then return false end
        if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
            return true
        end
        return false
    end

    local function safeTouchInterest(targetPart, localPart)
        if not targetPart or not localPart then return end
        pcall(function()
            firetouchinterest(targetPart, localPart, 0)
            task.wait(0.01)
            firetouchinterest(targetPart, localPart, 1)
        end)
    end

    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)

    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            equipPunch()
        end
    end)

    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.1) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and ReplicatedStorage.brawlInProgress.Value then
                pcall(function()
                    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                end)
            end
        end
    end)

    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.05) do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and ReplicatedStorage.brawlInProgress.Value then
                local character = LocalPlayer.Character
                local leftHand = character:FindFirstChild("LeftHand")
                local rightHand = character:FindFirstChild("RightHand")
                for _, player in pairs(Players:GetPlayers()) do
                    if isValidTarget(player) then
                        pcall(function()
                            if leftHand then safeTouchInterest(player.Character.HumanoidRootPart, leftHand) end
                            if rightHand then safeTouchInterest(player.Character.HumanoidRootPart, rightHand) end
                        end)
                        task.wait(0.01)
                    end
                end
            end
        end
    end)
end)

createSwitch(autoBrawlsFolder, "Авто вступать в бой", function(bool)
    getgenv().autoJoinBrawl = bool
    task.spawn(function()
        while getgenv().autoJoinBrawl and task.wait(0.5) do
            if LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)
end)

-- Залы
local farmGymsFolder = Instance.new("Frame")
farmGymsFolder.Size = UDim2.new(1, -20, 0, 40)
farmGymsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["МЕНЮ"]:GetChildren()*40)
farmGymsFolder.BackgroundTransparency = 1
farmGymsFolder.Parent = tabFrames["МЕНЮ"]

createLabel(farmGymsFolder, "Залы")

local workoutPositions = {
    ["Жим лежа"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Портал Короля"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
    },
    ["Жим с присяда"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Становая тяга"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    },
    ["Поднимать камень"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
        ["Портал Короля"] = CFrame.new(-8940.12402, 13.1642084, -5699.13477)
    }
}

local workoutTypes = {"Жим лежа", "Жим с присяда", "Становая тяга", "Поднимать камень"}
local gymLocations = {"Портал Ад", "Портал Легенды", "Портал Короля"}
local gymToggles = {}

for _, workoutType in ipairs(workoutTypes) do
    local varName = "selected" .. string.gsub(workoutType, " ", "") .. "Gym"
    _G[varName] = gymLocations[1]
    createDropdown(farmGymsFolder, workoutType .. " - Зал", gymLocations, function(selected)
        _G[varName] = selected
    end)

    gymToggles[workoutType] = createSwitch(farmGymsFolder, workoutType, function(bool)
        getgenv().workingGym = bool
        getgenv().currentWorkoutType = workoutType
        if bool then
            local selectedGym = _G[varName]
            for otherType, toggle in pairs(gymToggles) do
                if otherType ~= workoutType then
                    toggle.Parent.Parent.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    toggle.Position = UDim2.new(0, 2, 0.5, -10)
                    toggle.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                end
            end
            local position = workoutPositions[workoutType][selectedGym]
            if position then
                local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                character:WaitForChild("HumanoidRootPart").CFrame = position
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Телепорт",
                    Text = "Телепортирован в зал " .. workoutType,
                    Duration = 3
                })
                task.spawn(function()
                    while getgenv().workingGym and task.wait(0.1) do
                        pcall(function()
                            if workoutType == "Жим лежа" then
                                ReplicatedStorage.rEvents.workoutEvent:FireServer("benchPress")
                            elseif workoutType == "Жим с присяда" then
                                ReplicatedStorage.rEvents.workoutEvent:FireServer("squat")
                            elseif workoutType == "Становая тяга" then
                                ReplicatedStorage.rEvents.workoutEvent:FireServer("deadlift")
                            elseif workoutType == "Поднимать камень" then
                                ReplicatedStorage.rEvents.workoutEvent:FireServer("pullUp")
                            end
                        end)
                    end
                end)
            else
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Ошибка",
                    Text = "Позиция не найдена для " .. workoutType .. " в " .. selectedGym,
                    Duration = 5
                })
            end
        end
    end)
end

-- Остальное
local opThingsFolder = Instance.new("Frame")
opThingsFolder.Size = UDim2.new(1, -20, 0, 40)
opThingsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["МЕНЮ"]:GetChildren()*40)
opThingsFolder.BackgroundTransparency = 1
opThingsFolder.Parent = tabFrames["МЕНЮ"]

createLabel(opThingsFolder, "Остальное")

createSwitch(opThingsFolder, "Анти отбрасывание", function(bool)
    if bool then
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1250
            bodyVelocity.Parent = rootPart
        end
    else
        local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
            if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                existingVelocity:Destroy()
            end
        end
    end
end)

local positionLockConnection
createSwitch(opThingsFolder, "Стоять на месте", function(bool)
    if bool then
        local currentPosition = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.CFrame
        if currentPosition then
            positionLockConnection = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = currentPosition
                end
            end)
        end
    else
        if positionLockConnection then
            positionLockConnection:Disconnect()
            positionLockConnection = nil
        end
    end
end)

createSwitch(opThingsFolder, "Скрывать рамки", function(bool)
    for _, obj in pairs(ReplicatedStorage:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

createSwitch(opThingsFolder, "Быстрая сила", function(bool)
    if bool then
        for i = 1, 14 do
            task.spawn(function()
                while bool do
                    LocalPlayer.muscleEvent:FireServer("rep")
                    task.wait()
                end
            end)
        end
    end
end)

-- Фарм камней
local autoRockFolder = Instance.new("Frame")
autoRockFolder.Size = UDim2.new(1, -20, 0, 40)
autoRockFolder.Position = UDim2.new(0, 10, 0, #tabFrames["ФАРМ"]:GetChildren()*40)
autoRockFolder.BackgroundTransparency = 1
autoRockFolder.Parent = tabFrames["ФАРМ"]

createLabel(autoRockFolder, "Бить камень")

local rockSettings = {
    {"Маленький камень - 0", "Tiny Island Rock", 0},
    {"Средний камень - 100", "Starter Island Rock", 100},
    {"Золотой камень - 5000", "Legend Beach Rock", 5000},
    {"Ледяной камень - 150000", "Frost Gym Rock", 150000},
    {"Мифический камень - 400000", "Mythical Gym Rock", 400000},
    {"Адский камень - 750000", "Eternal Gym Rock", 750000},
    {"Легендарный камень - 1000000", "Legend Gym Rock", 1000000},
    {"Королевский камень - 5000000", "Muscle King Gym Rock", 5000000},
    {"Камень в Джунглях - 10000000", "Ancient Jungle Rock", 10000000}
}

local function gettool()
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

for _, setting in ipairs(rockSettings) do
    createSwitch(autoRockFolder, setting[1], function(bool)
        selectrock = setting[2]
        getgenv().autoFarm = bool
        task.spawn(function()
            while getgenv().autoFarm and task.wait() do
                if LocalPlayer.Durability.Value >= setting[3] then
                    for _, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == setting[3] and LocalPlayer.Character:FindFirstChild("LeftHand") and LocalPlayer.Character:FindFirstChild("RightHand") then
                            firetouchinterest(v.Parent.Rock, LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end)
end)

-- Перерождения
local rebirthsFolder = Instance.new("Frame")
rebirthsFolder.Size = UDim2.new(1, -20, 0, 40)
rebirthsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["ФАРМ"]:GetChildren()*40)
rebirthsFolder.BackgroundTransparency = 1
rebirthsFolder.Parent = tabFrames["ФАРМ"]

createLabel(rebirthsFolder, "Перерождения")

local targetRebirthValue = 0
createTextBox(rebirthsFolder, "Сколько нужно?", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет " .. targetRebirthValue .. " перерождений",
            Duration = 3
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Всё",
            Text = "Остановил как и обещал",
            Duration = 3
        })
    end
end)

local targetSwitch = createSwitch(rebirthsFolder, "Начать перерождения по количеству", function(bool)
    _G.targetRebirthActive = bool
    if bool then
        task.spawn(function()
            while _G.targetRebirthActive and task.wait(0.1) do
                local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
                if currentRebirths >= targetRebirthValue then
                    _G.targetRebirthActive = false
                    targetSwitch.Parent.Parent.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    targetSwitch.Position = UDim2.new(0, 2, 0.5, -10)
                    targetSwitch.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Ооо",
                        Text = "Пошло дело пошло",
                        Duration = 5
                    })
                    break
                end
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

local infiniteSwitch = createSwitch(rebirthsFolder, "Перерождаться бесконечно", function(bool)
    _G.infiniteRebirthActive = bool
    if bool then
        if _G.targetRebirthActive then
            _G.targetRebirthActive = false
            targetSwitch.Parent.Parent.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            targetSwitch.Position = UDim2.new(0, 2, 0.5, -10)
            targetSwitch.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        end
        task.spawn(function()
            while _G.infiniteRebirthActive and task.wait(0.1) do
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

createSwitch(rebirthsFolder, "Всегда рост 1", function(bool)
    _G.autoSizeActive = bool
    if bool then
        task.spawn(function()
            while _G.autoSizeActive and task.wait() do
                ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)
    end
end)

createSwitch(rebirthsFolder, "Телепортироваться к королю", function(bool)
    _G.teleportActive = bool
    if bool then
        task.spawn(function()
            while _G.teleportActive and task.wait() do
                if LocalPlayer.Character then
                    LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end)

-- Авто кач
local autoEquipToolsFolder = Instance.new("Frame")
autoEquipToolsFolder.Size = UDim2.new(1, -20, 0, 40)
autoEquipToolsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["ФАРМ"]:GetChildren()*40)
autoEquipToolsFolder.BackgroundTransparency = 1
autoEquipToolsFolder.Parent = tabFrames["ФАРМ"]

createLabel(autoEquipToolsFolder, "Автоматически качаться")

createButton(autoEquipToolsFolder, "Автолифт", function()
    local gamepassFolder = ReplicatedStorage.gamepassIds
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = LocalPlayer.ownedGamepasses
    end
end)

local toolSwitches = {
    {"Авто гантеля", "Weight"},
    {"Авто отжимания", "Pushups"},
    {"Авто отжимания стоя на руках", "Handstands"},
    {"Авто пресс", "Situps"},
    {"Авто удары", "Punch"}
}

for _, tool in ipairs(toolSwitches) do
    createSwitch(autoEquipToolsFolder, tool[1], function(bool)
        _G["Auto" .. tool[2]] = bool
        if bool then
            local toolInstance = LocalPlayer.Backpack:FindFirstChild(tool[2])
            if toolInstance then
                LocalPlayer.Character.Humanoid:EquipTool(toolInstance)
            end
            if tool[2] == "Punch" then
                task.spawn(function()
                    while _G["Auto" .. tool[2]] and task.wait(0.1) do
                        local punch = LocalPlayer.Character:FindFirstChild("Punch")
                        if punch and punch:FindFirstChild("attackTime") then
                            punch.attackTime.Value = 0
                        end
                        LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                        LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        if punch then
                            punch:Activate()
                        end
                    end
                end)
            else
                task.spawn(function()
                    while _G["Auto" .. tool[2]] and task.wait(0.1) do
                        LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end)
            end
        else
            local equipped = LocalPlayer.Character:FindFirstChild(tool[2])
            if equipped then
                equipped.Parent = LocalPlayer.Backpack
            end
        end
    end)
end

createSwitch(autoEquipToolsFolder, "Быстрые предметы", function(bool)
    _G.FastTools = bool
    local defaultSpeeds = {
        {"Punch", "attackTime", bool and 0 or 0.35},
        {"Ground Slam", "attackTime", bool and 0 or 6},
        {"Stomp", "attackTime", bool and 0 or 7},
        {"Handstands", "repTime", bool and 0 or 2},
        {"Situps", "repTime", bool and 0 or 2.5},
        {"Pushups", "repTime", bool and 0 or 2.5},
        {"Weight", "repTime", bool and 0 or 3}
    }
    for _, toolData in pairs(defaultSpeeds) do
        local toolName, property, speed = toolData[1], toolData[2], toolData[3]
        local backpackTool = LocalPlayer.Backpack:FindFirstChild(toolName)
        if backpackTool and backpackTool:FindFirstChild(property) then
            backpackTool[property].Value = speed
        end
        local equippedTool = LocalPlayer.Character:FindFirstChild(toolName)
        if equippedTool and equippedTool:FindFirstChild(property) then
            equippedTool[property].Value = speed
        end
    end
end)

createSwitch(autoEquipToolsFolder, "Анти лаг", function(bool)
    _G.AntiLag = bool
    if bool then
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
            if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                obj.Material = "Plastic"
                obj.Reflectance = 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end
    end
end)

-- Статистика
local statsFolder = Instance.new("Frame")
statsFolder.Size = UDim2.new(1, -20, 0, 40)
statsFolder.Position = UDim2.new(0, 10, 0, #tabFrames["СТАТИСТИКА"]:GetChildren()*40)
statsFolder.BackgroundTransparency = 1
statsFolder.Parent = tabFrames["СТАТИСТИКА"]

createLabel(statsFolder, "Статистика")

local sessionStartTime, sessionStartStrength, sessionStartDurability, sessionStartKills, sessionStartRebirths, sessionStartBrawls = os.time(), 0, 0, 0, 0, 0
local hasStartedTracking = false

local function formatNumber(number)
    if number >= 1e15 then return string.format("%.2fQ", number/1e15)
    elseif number >= 1e12 then return string.format("%.2fT", number/1e12)
    elseif number >= 1e9 then return string.format("%.2fB", number/1e9)
    elseif number >= 1e6 then return string.format("%.2fM", number/1e6)
    elseif number >= 1e3 then return string.format("%.2fK", number/1e3)
    end
    return tostring(math.floor(number))
end

local function formatTime(seconds)
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    if days > 0 then
        return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
end

local function startTracking()
    if not hasStartedTracking then
        sessionStartStrength = LocalPlayer.leaderstats.Strength.Value
        sessionStartDurability = LocalPlayer.Durability.Value
        sessionStartKills = LocalPlayer.leaderstats.Kills.Value
        sessionStartRebirths = LocalPlayer.leaderstats.Rebirths.Value
        sessionStartBrawls = LocalPlayer.leaderstats.Brawls.Value
        hasStartedTracking = true
    end
end

local strengthStatsLabel = createLabel(statsFolder, "Сила: ...")
local strengthGainLabel = createLabel(statsFolder, "Достиг: 0")
local durabilityStatsLabel = createLabel(statsFolder, "Долговечность: ...")
local durabilityGainLabel = createLabel(statsFolder, "Достиг: 0")
local rebirthsStatsLabel = createLabel(statsFolder, "Перерождения: ...")
local rebirthsGainLabel = createLabel(statsFolder, "Достиг: 0")
local killsStatsLabel = createLabel(statsFolder, "Убийства: ...")
local killsGainLabel = createLabel(statsFolder, "Достиг: 0")
local brawlsStatsLabel = createLabel(statsFolder, "Поединки: ...")
local brawlsGainLabel = createLabel(statsFolder, "Достиг: 0")
local sessionTimeLabel = createLabel(statsFolder, "Время: 00:00:00")

local function updateStats()
    startTracking()
    local currentStrength = LocalPlayer.leaderstats.Strength.Value
    local currentDurability = LocalPlayer.Durability.Value
    local currentKills = LocalPlayer.leaderstats.Kills.Value
    local currentRebirths = LocalPlayer.leaderstats.Rebirths.Value
    local currentBrawls = LocalPlayer.leaderstats.Brawls.Value
    local elapsedTime = os.time() - sessionStartTime

    strengthStatsLabel.Text = "Сила: " .. formatNumber(currentStrength)
    strengthGainLabel.Text = "Достиг: " .. formatNumber(currentStrength - sessionStartStrength)
    durabilityStatsLabel.Text = "Долговечность: " .. formatNumber(currentDurability)
    durabilityGainLabel.Text = "Достиг: " .. formatNumber(currentDurability - sessionStartDurability)
    rebirthsStatsLabel.Text = "Перерождения: " .. formatNumber(currentRebirths)
    rebirthsGainLabel.Text = "Достиг: " .. formatNumber(currentRebirths - sessionStartRebirths)
    killsStatsLabel.Text = "Убийства: " .. formatNumber(currentKills)
    killsGainLabel.Text = "Достиг: " .. formatNumber(currentKills - sessionStartKills)
    brawlsStatsLabel.Text = "Поединки: " .. formatNumber(currentBrawls)
    brawlsGainLabel.Text = "Достиг: " .. formatNumber(currentBrawls - sessionStartBrawls)
    sessionTimeLabel.Text = "Время: " .. formatTime(elapsedTime)
end

task.spawn(function()
    while task.wait(2) do
        updateStats()
    end
end)

createButton(statsFolder, "Очистить статистику", function()
    sessionStartStrength = LocalPlayer.leaderstats.Strength.Value
    sessionStartDurability = LocalPlayer.Durability.Value
    sessionStartKills = LocalPlayer.leaderstats.Kills.Value
    sessionStartRebirths = LocalPlayer.leaderstats.Rebirths.Value
    sessionStartBrawls = LocalPlayer.leaderstats.Brawls.Value
    sessionStartTime = os.time()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Статистика очищена",
        Duration = 3
    })
end)

createButton(statsFolder, "Скопировать", function()
    local statsText = "Muscle Legends:\n\n"
    statsText = statsText .. "Сила: " .. formatNumber(LocalPlayer.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Долговечность: " .. formatNumber(LocalPlayer.Durability.Value) .. "\n"
    statsText = statsText .. "Перерождения: " .. formatNumber(LocalPlayer.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Убийства: " .. formatNumber(LocalPlayer.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Поединки: " .. formatNumber(LocalPlayer.leaderstats.Brawls.Value) .. "\n\n"
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        statsText = statsText .. "--- Статистика сессии ---\n"
        statsText = statsText .. "Время сессии: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Сила набрано: " .. formatNumber(LocalPlayer.leaderstats.Strength.Value - sessionStartStrength) .. "\n"
        statsText = statsText .. "Долговечность набрано: " .. formatNumber(LocalPlayer.Durability.Value - sessionStartDurability) .. "\n"
        statsText = statsText .. "Перерождения набрано: " .. formatNumber(LocalPlayer.leaderstats.Rebirths.Value - sessionStartRebirths) .. "\n"
        statsText = statsText .. "Убийства набрано: " .. formatNumber(LocalPlayer.leaderstats.Kills.Value - sessionStartKills) .. "\n"
        statsText = statsText .. "Поединки набрано: " .. formatNumber(LocalPlayer.leaderstats.Brawls.Value - sessionStartBrawls) .. "\n"
    end
    setclipboard(statsText)
end)

-- Петы
local petOptions = {
    "Neon Guardian", "Blue Birdie", "Blue Bunny", "Blue Firecaster", "Blue Pheonix", "Crimson Falcon",
    "Cybernetic Showdown Dragon", "Dark Golem", "Dark Legends Manticore", "Dark Vampy", "Darkstar Hunter",
    "Eternal Strike Leviathan", "Frostwave Legends Penguin", "Gold Warrior", "Golden Pheonix", "Golden Viking",
    "Green Butterfly", "Green Firecaster", "Infernal Dragon", "Lightning Strike Phantom", "Magic Butterfly",
    "Muscle Sensei", "Orange Hedgehog", "Orange Pegasus", "Phantom Genesis Dragon", "Purple Dragon",
    "Purple Falcon", "Red Dragon", "Red Firecaster", "Red Kitty", "Silver Dog", "Ultimate Supernova Pegasus",
    "Ultra Birdie", "White Pegasus", "White Pheonix", "Yellow Butterfly"
}

createLabel(tabFrames["ПЕТЫ"], "Петы")
local selectedPet = petOptions[1]
createDropdown(tabFrames["ПЕТЫ"], "Выбери пета", petOptions, function(text)
    selectedPet = text
end)

createSwitch(tabFrames["ПЕТЫ"], "Купить", function(bool)
    _G.AutoHatchPet = bool
    if bool then
        task.spawn(function()
            while _G.AutoHatchPet and selectedPet ~= "" do
                local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
                if petToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
                end
                task.wait(1)
            end
        end)
    end
end)

local auraOptions = {
    "Astral Electro", "Azure Tundra", "Blue Aura", "Dark Electro", "Dark Lightning", "Dark Storm",
    "Electro", "Enchanted Mirage", "Entropic Blast", "Eternal Megastrike", "Grand Supernova",
    "Green Aura", "Inferno", "Lightning", "Muscle King", "Power Lightning", "Purple Aura",
    "Purple Nova", "Red Aura", "Supernova", "Ultra Inferno", "Ultra Mirage", "Unstable Mirage",
    "Yellow Aura"
}

createLabel(tabFrames["ПЕТЫ"], "Ауры")
local selectedAura = auraOptions[1]
createDropdown(tabFrames["ПЕТЫ"], "Выбери ауру", auraOptions, function(text)
    selectedAura = text
end)

createSwitch(tabFrames["ПЕТЫ"], "Купить", function(bool)
    _G.AutoHatchAura = bool
    if bool then
        task.spawn(function()
            while _G.AutoHatchAura and selectedAura ~= "" do
                local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
                if auraToOpen then
                    ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
                end
                task.wait(1)
            end
        end)
    end
end)

-- Убийства
_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

local function checkCharacter()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local startTime = tick()
        repeat
            task.wait(0.1)
            if tick() - startTime > 5 then return nil end
        until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
    return LocalPlayer.Character
end

local function gettool()
    pcall(function()
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") then return end
        for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "Punch" then
                LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end
        end
        LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
        LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
    end)
end

local function killPlayer(target)
    local character = checkCharacter()
    if not character or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("LeftHand") then return end
    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
        task.wait(0.01)
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
        gettool()
    end)
end

local function findClosestPlayer(input)
    if not input or input == "" then return nil end
    input = input:lower()
    local bestMatch, bestScore = nil, 0
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local username = player.Name:lower()
            local displayName = player.DisplayName:lower()
            local usernameScore = (username:find(input, 1, true) and (#input / #username) * 100 + (username:sub(1, #input) == input and 50 or 0)) or 0
            local displayScore = (displayName:find(input, 1, true) and (#input / #displayName) * 100 + (displayName:sub(1, #input) == input and 50 or 0)) or 0
            local score = math.max(usernameScore, displayScore)
            if score > bestScore then
                bestScore = score
                bestMatch = player
            end
        end
    end
    return bestScore > 20 and bestMatch or nil
end

local whitelistedPlayersLabel = createLabel(tabFrames["УБИЙСТВА"], "Белый список: Нету")
local targetPlayerLabel = createLabel(tabFrames["УБИЙСТВА"], "Кого убивать: Нету")

local function updateWhitelistedPlayersLabel()
    whitelistedPlayersLabel.Text = #_G.whitelistedPlayers == 0 and "Белый список: Нету" or "Белый список: " .. table.concat(_G.whitelistedPlayers, ", ")
end

local function updateTargetPlayerLabel()
    targetPlayerLabel.Text = _G.targetPlayer == "" and "Кого убивать: Нету" or "Кого убивать: " .. _G.targetPlayer
end

createSwitch(tabFrames["УБИЙСТВА"], "Автоматом друзей в белый список", function(bool)
    _G.autoWhitelistFriends = bool
    if bool then
        pcall(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player:IsFriendsWith(LocalPlayer.UserId) and not table.find(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")") then
                    table.insert(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")")
                end
            end
            updateWhitelistedPlayersLabel()
        end)
    end
end)

Players.PlayerAdded:Connect(function(player)
    if _G.autoWhitelistFriends then
        pcall(function()
            if player:IsFriendsWith(LocalPlayer.UserId) and not table.find(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")") then
                table.insert(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")")
                updateWhitelistedPlayersLabel()
            end
        end)
    end
end)

createTextBox(tabFrames["УБИЙСТВА"], "Добавить в белый список (ник)", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
            if not table.find(_G.whitelistedPlayers, playerInfo) then
                table.insert(_G.whitelistedPlayers, playerInfo)
                updateWhitelistedPlayersLabel()
            end
        end
    end
end)

createTextBox(tabFrames["УБИЙСТВА"], "Удалить с белого списка (ник)", function(text)
    if text and text ~= "" then
        local textLower = text:lower()
        for i, playerInfo in ipairs(_G.whitelistedPlayers) do
            if playerInfo:lower():find(textLower, 1, true) then
                table.remove(_G.whitelistedPlayers, i)
                updateWhitelistedPlayersLabel()
                return
            end
        end
        local player = findClosestPlayer(text)
        if player then
            for i, playerInfo in ipairs(_G.whitelistedPlayers) do
                if playerInfo:find(player.Name, 1, true) then
                    table.remove(_G.whitelistedPlayers, i)
                    updateWhitelistedPlayersLabel()
                    break
                end
            end
        end
    end
end)

createButton(tabFrames["УБИЙСТВА"], "Очистить белый список", function()
    _G.whitelistedPlayers = {}
    updateWhitelistedPlayersLabel()
end)

createSwitch(tabFrames["УБИЙСТВА"], "Убивать всех (кроме белого списка)", function(bool)
    _G.autoKillAll = bool
    if bool then
        task.spawn(function()
            while _G.autoKillAll and task.wait(0.2) do
                pcall(function()
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and not table.find(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                            killPlayer(player)
                            task.wait(0.05)
                        end
                    end
                end)
            end
        end)
    end
end)

createTextBox(tabFrames["УБИЙСТВА"], "Убивать кого: (ник)", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end
    end
end)

createButton(tabFrames["УБИЙСТВА"], "Очистить убийство", function()
    _G.targetPlayer = ""
    updateTargetPlayerLabel()
end)

createSwitch(tabFrames["УБИЙСТВА"], "Убийство выбранного", function(bool)
    _G.autoKillTarget = bool
    if bool and _G.targetPlayer ~= "" then
        task.spawn(function()
            while _G.autoKillTarget and _G.targetPlayer ~= "" and task.wait(0.1) do
                pcall(function()
                    local targetName = _G.targetPlayer:match("^([^%(]+)")
                    if targetName then
                        targetName = targetName:gsub("%s+$", "")
                        local targetPlayer = Players:FindFirstChild(targetName)
                        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and targetPlayer.Character:FindFirstChild("Humanoid") and targetPlayer.Character.Humanoid.Health > 0 then
                            killPlayer(targetPlayer)
                        end
                    end
                end)
            end
        end)
    end
end)

createButton(tabFrames["УБИЙСТВА"], "Очистить всё (кроме белого списка)", function()
    pcall(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and not table.find(_G.whitelistedPlayers, player.Name .. " (" .. player.DisplayName .. ")") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                killPlayer(player)
                task.wait(0.05)
            end
        end
    end)
end)

createButton(tabFrames["УБИЙСТВА"], "Удалить куклу для киллов", function()
    if _G.targetPlayer ~= "" then
        pcall(function()
            local targetName = _G.targetPlayer:match("^([^%(]+)")
            if targetName then
                targetName = targetName:gsub("%s+$", "")
                local targetPlayer = Players:FindFirstChild(targetName)
                if targetPlayer then
                    killPlayer(targetPlayer)
                end
            end
        end)
    end
end)

-- Телепорт
local teleportLocations = {
    {"Спавн", CFrame.new(2, 8, 115), "Прямиком на спавн"},
    {"Секретная арена", CFrame.new(1947, 2, 6191), "У-хх СЕКРЕТ!"},
    {"Маленький остров 0-1к", CFrame.new(-34, 7, 1903), "Это для тебя малыш"},
    {"Ледяной зал", CFrame.new(-2600.00244, 3.67686558, -403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, -3.7464023e-09, -0.99617666, 3.09302628e-08, 0.0873617008), "Тут холодновато"},
    {"Мифический портал", CFrame.new(2255, 7, 1071), "Вот это Да,Мистика!"},
    {"Адский портал", CFrame.new(-6768, 7, -1287), "Жарковье,прям под сатану"},
    {"Легендарный остров", CFrame.new(4604, 991, -3887), "Тихо!Он только для легенд"},
    {"Портал мускульного короля", CFrame.new(-8646, 17, -5738), "Ты на стояке у Роналдо,двойная сила!"},
    {"Джунгли", CFrame.new(-8659, 6, 2384), "Алё,надо побрить,тут уже обезьянки бегают"},
    {"Бой в лаве", CFrame.new(4471, 119, -8836), "Это бой в лаве"},
    {"Бой в пустыне", CFrame.new(960, 17, -7398), "Это бой в песчанике"},
    {"Бой на ринге", CFrame.new(-1849, 20, -6335), "Тебе завидует Майк Тайсон"}
}

for _, loc in ipairs(teleportLocations) do
    createButton(tabFrames["ТЕЛЕПОРТ"], loc[1], function()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        character:WaitForChild("HumanoidRootPart").CFrame = loc[2]
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Телепорт",
            Text = loc[3],
            Duration = 3
        })
    end)
end

-- Авто рулетка и подарки
local miscFolder = Instance.new("Frame")
miscFolder.Size = UDim2.new(1, -20, 0, 40)
miscFolder.Position = UDim2.new(0, 10, 0, #tabFrames["ДРУГОЕ"]:GetChildren()*40)
miscFolder.BackgroundTransparency = 1
miscFolder.Parent = tabFrames["ДРУГОЕ"]

createLabel(miscFolder, "Авто рулетка и подарки")

createSwitch(miscFolder, "Авто прокрутка колеса удачи", function(bool)
    _G.AutoSpinWheel = bool
    if bool then
        task.spawn(function()
            while _G.AutoSpinWheel and task.wait(1) do
                ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
            end
        end)
    end
end)

createSwitch(miscFolder, "Авто сбор подарков", function(bool)
    _G.AutoClaimGifts = bool
    if bool then
        task.spawn(function()
            while _G.AutoClaimGifts and task.wait(1) do
                for i = 1, 8 do
                    ReplicatedStorage.rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
            end
        end)
    end
end)

-- Инициализация
switchTab("МЕНЮ")
setupAntiAFK()
