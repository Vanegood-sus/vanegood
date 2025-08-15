-- Vanegood Hub 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем кнопку с фоткой
local TinyImageGui = Instance.new("ScreenGui")
TinyImageGui.Name = "TinyDraggableImage"
TinyImageGui.Parent = CoreGui
TinyImageGui.ResetOnSpawn = false

-- Размеры изображения
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

-- Перетаскивание
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
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Оранжевая обводка
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

-- Заголовок
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

-- Кнопка закрытия (оранжевая)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации (оранжевая)
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

-- Вкладки
local Tabs = {
    "МЕНЮ",
    "ФАРМ",
    "УБИЙСТВА",
    "ТЕЛЕПОРТ",
    "ПЕРЕРОЖДЕНИЕ",
    "ДРУГОЕ"
}

local TabButtons = {}
for i, tabName in ipairs(Tabs) do
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1/#Tabs, 0, 1, 0)
    tab.Position = UDim2.new((i-1)/#Tabs, 0, 0, 0)
    tab.BackgroundColor3 = i == 1 and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(30, 30, 40)
    tab.Text = tabName
    tab.TextColor3 = i == 1 and Color3.fromRGB(220, 220, 220) or Color3.fromRGB(180, 180, 180)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 12
    tab.Parent = TabBar
    TabButtons[i] = tab
end

-- Индикатор вкладки (оранжевый)
local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(1/#Tabs, 0, 0, 2)
ActiveTabIndicator.Position = UDim2.new(0, 0, 1, -2)
ActiveTabIndicator.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
ActiveTabIndicator.Parent = TabBar

-- Контент
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -70)
ContentFrame.Position = UDim2.new(0, 10, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Фреймы для контента
local ContentFrames = {}
for i = 1, #Tabs do
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.Position = UDim2.new(0, 0, 0, 0)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 3
    frame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    frame.Visible = i == 1
    frame.Parent = ContentFrame
    ContentFrames[i] = frame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = frame
end

-- Функция переключения вкладок
local function switchTab(index)
    for i, tab in ipairs(TabButtons) do
        tab.BackgroundColor3 = i == index and Color3.fromRGB(40, 40, 50) or Color3.fromRGB(30, 30, 40)
        tab.TextColor3 = i == index and Color3.fromRGB(220, 220, 220) or Color3.fromRGB(180, 180, 180)
        ContentFrames[i].Visible = i == index
    end
    TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new((index-1)/#Tabs, 0, 1, -2)}):Play()
end

-- Обработчики вкладок
for i, tab in ipairs(TabButtons) do
    tab.MouseButton1Click:Connect(function()
        switchTab(i)
    end)
end

-- Функция минимизации
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 30)
        ContentFrame.Visible = false
        TabBar.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 400)
        ContentFrame.Visible = true
        TabBar.Visible = true
        MinimizeButton.Text = "-"
    end
end)

-- Функция закрытия
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

-- Функция для кнопки с картинкой
local hubVisible = true
imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubVisible = not hubVisible
        ScreenGui.Enabled = hubVisible
        
        -- Анимация для обратной связи
        if hubVisible then
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
        else
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
        end
    end
end)

-- Функция для создания кнопок
local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    
    return button
end

-- Функция для создания переключателей
local function createToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 30)
    toggleFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 50, 1, 0)
    toggleButton.Position = UDim2.new(1, -50, 0, 0)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    toggleButton.Text = default and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 12
    toggleButton.Parent = toggleFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = toggleButton
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleFrame
    
    toggleButton.MouseButton1Click:Connect(function()
        local newState = not (toggleButton.Text == "ON")
        toggleButton.Text = newState and "ON" or "OFF"
        toggleButton.BackgroundColor3 = newState and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        callback(newState)
    end)
    
    return toggleButton
end

-- Функция для создания папок (разворачивающихся списков)
local function createFolder(parent, name)
    local folderFrame = Instance.new("Frame")
    folderFrame.Size = UDim2.new(1, -10, 0, 30)
    folderFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    folderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    folderFrame.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = folderFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 30, 1, 0)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = "+"
    toggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 16
    toggleButton.Parent = folderFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 35, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = folderFrame
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.Position = UDim2.new(0, 0, 1, 5)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    contentFrame.Parent = folderFrame
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Padding = UDim.new(0, 5)
    contentLayout.Parent = contentFrame
    
    local isExpanded = false
    
    toggleButton.MouseButton1Click:Connect(function()
        isExpanded = not isExpanded
        contentFrame.Visible = isExpanded
        toggleButton.Text = isExpanded and "-" or "+"
        
        if isExpanded then
            contentFrame.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y)
        else
            contentFrame.Size = UDim2.new(1, 0, 0, 0)
        end
    end)
    
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if isExpanded then
            contentFrame.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y)
        end
    end)
    
    return contentFrame
end

-- Функция для создания полей ввода
local function createInput(parent, text, default, callback)
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -10, 0, 30)
    inputFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35)
    inputFrame.BackgroundTransparency = 1
    inputFrame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, -5, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = inputFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.5, -5, 1, 0)
    textBox.Position = UDim2.new(0.5, 0, 0, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    textBox.Text = tostring(default)
    textBox.TextColor3 = Color3.fromRGB(220, 220, 220)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 12
    textBox.Parent = inputFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = textBox
    
    textBox.FocusLost:Connect(function()
        callback(textBox.Text)
    end)
    
    return textBox
end

-- ================ МЕНЮ ================
local MenuFrame = ContentFrames[1]

-- Авто бой
createToggle(MenuFrame, "Авто бой", false, function(value)
    getgenv().autoFight = value
    
    if value then
        spawn(function()
            while getgenv().autoFight do
                if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                    game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                    game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
                end
                wait(0.5)
            end
        end)
    end
end)

createToggle(MenuFrame, "Авто выигрыш", false, function(value)
    getgenv().autoWin = value
    
    local function equipPunch()
        if not getgenv().autoWin then return end
        local character = game.Players.LocalPlayer.Character
        if not character then return false end
        
        if character:FindFirstChild("Punch") then return true end
        
        local backpack = game.Players.LocalPlayer.Backpack
        if not backpack then return false end
        
        for _, tool in pairs(backpack:GetChildren()) do
            if tool.ClassName == "Tool" and tool.Name == "Punch" then
                tool.Parent = character
                return true
            end
        end
        return false
    end
    
    task.spawn(function()
        while getgenv().autoWin and task.wait(0.5) do
            equipPunch()
        end
    end)
    
    task.spawn(function()
        while getgenv().autoWin and task.wait(0.1) do
            if game.ReplicatedStorage.brawlInProgress.Value then
                pcall(function() game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand") end)
                pcall(function() game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand") end)
            end
        end
    end)
end)

-- Стоять на месте
local positionLockConnection
createToggle(MenuFrame, "Стоять на месте", false, function(value)
    if value then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local position = character.HumanoidRootPart.CFrame
            positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = position
                end
            end)
        end
    elseif positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
end)

-- Скрывать интерфейс прокачки
createToggle(MenuFrame, "Скрывать UI прокачки", false, function(value)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not value
        end
    end
end)

-- ================ ФАРМ ================
local FarmFrame = ContentFrames[2]

-- Папка с камнями
local rocksFolder = createFolder(FarmFrame, "Фарм камней")

local rocks = {
    ["Маленький камень (0)"] = 0,
    ["Средний камень (100)"] = 100,
    ["Золотой камень (5k)"] = 5000,
    ["Ледяной камень (150k)"] = 150000,
    ["Мифический камень (400k)"] = 400000,
    ["Адский камень (750k)"] = 750000,
    ["Легендарный камень (1M)"] = 1000000,
    ["Королевский камень (5M)"] = 5000000,
    ["Камень в Джунглях (10M)"] = 10000000
}

local function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

for rockName, rockValue in pairs(rocks) do
    createToggle(rocksFolder, rockName, false, function(value)
        getgenv()["autoFarmRock"..rockValue] = value
        
        task.spawn(function()
            while getgenv()["autoFarmRock"..rockValue] do
                task.wait()
                if game:GetService("Players").LocalPlayer.Durability.Value >= rockValue then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == rockValue and 
                           game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and 
                           game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.RightHand, 1)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(v.Parent.Rock, game:GetService("Players").LocalPlayer.Character.LeftHand, 1)
                            gettool()
                        end
                    end
                end
            end
        end)
    end)
end

-- Авто прокачка
local autoTrainFolder = createFolder(FarmFrame, "Авто прокачка")

local tools = {
    ["Гантели"] = "Weight",
    ["Отжимания"] = "Pushups",
    ["Стойка на руках"] = "Handstands",
    ["Пресс"] = "Situps"
}

local function equipTool(toolName)
    local player = game.Players.LocalPlayer
    local tool = player.Backpack:FindFirstChild(toolName)
    if tool and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:EquipTool(tool)
    end
end

-- Обработчик смерти для перезапуска авто прокачки
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    for toolName, _ in pairs(tools) do
        if getgenv()["Auto"..toolName] then
            wait(1) -- Даем время на появление персонажа
            equipTool(tools[toolName])
        end
    end
end)

for toolName, toolType in pairs(tools) do
    createToggle(autoTrainFolder, toolName, false, function(value)
        getgenv()["Auto"..toolName] = value
        
        if value then
            equipTool(toolType)
        else
            local character = game.Players.LocalPlayer.Character
            local equipped = character:FindFirstChild(toolType)
            if equipped then
                equipped.Parent = game.Players.LocalPlayer.Backpack
            end
        end
        
        task.spawn(function()
            while getgenv()["Auto"..toolName] do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                task.wait(0.1)
            end
        end)
    end)
end

-- ================ УБИЙСТВА ================
local KillFrame = ContentFrames[3]

_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

-- Белый список
local whitelistLabel = Instance.new("TextLabel")
whitelistLabel.Size = UDim2.new(1, -10, 0, 20)
whitelistLabel.Position = UDim2.new(0, 5, 0, #KillFrame:GetChildren() * 35)
whitelistLabel.BackgroundTransparency = 1
whitelistLabel.Text = "Белый список: "..(#_G.whitelistedPlayers > 0 and table.concat(_G.whitelistedPlayers, ", ") or "нет")
whitelistLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
whitelistLabel.Font = Enum.Font.Gotham
whitelistLabel.TextSize = 12
whitelistLabel.TextXAlignment = Enum.TextXAlignment.Left
whitelistLabel.Parent = KillFrame

local function updateWhitelistLabel()
    whitelistLabel.Text = "Белый список: "..(#_G.whitelistedPlayers > 0 and table.concat(_G.whitelistedPlayers, ", ") or "нет")
end

createButton(KillFrame, "Добавить в белый список", function()
    local playerName = game.Players.LocalPlayer.Name
    table.insert(_G.whitelistedPlayers, playerName)
    updateWhitelistLabel()
end)

createButton(KillFrame, "Очистить белый список", function()
    _G.whitelistedPlayers = {}
    updateWhitelistLabel()
end)

-- Авто убийства
createToggle(KillFrame, "Убивать всех (кроме белого списка)", false, function(value)
    _G.autoKillAll = value
    
    local function killPlayer(target)
        local character = game.Players.LocalPlayer.Character
        if not character or not target.Character then return end
        
        local leftHand = character:FindFirstChild("LeftHand")
        local rightHand = character:FindFirstChild("RightHand")
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        
        if leftHand and targetRoot then
            firetouchinterest(targetRoot, leftHand, 0)
            firetouchinterest(targetRoot, leftHand, 1)
        end
        
        if rightHand and targetRoot then
            firetouchinterest(targetRoot, rightHand, 0)
            firetouchinterest(targetRoot, rightHand, 1)
        end
    end
    
    if value then
        spawn(function()
            while _G.autoKillAll do
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and not table.find(_G.whitelistedPlayers, player.Name) then
                        killPlayer(player)
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

-- Убийство выбранного игрока
local targetLabel = Instance.new("TextLabel")
targetLabel.Size = UDim2.new(1, -10, 0, 20)
targetLabel.Position = UDim2.new(0, 5, 0, #KillFrame:GetChildren() * 35)
targetLabel.BackgroundTransparency = 1
targetLabel.Text = "Цель: "..(_G.targetPlayer ~= "" and _G.targetPlayer or "нет")
targetLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
targetLabel.Font = Enum.Font.Gotham
targetLabel.TextSize = 12
targetLabel.TextXAlignment = Enum.TextXAlignment.Left
targetLabel.Parent = KillFrame

createButton(KillFrame, "Выбрать цель", function()
    _G.targetPlayer = game.Players.LocalPlayer.Name -- Пример, можно добавить выбор из списка
    targetLabel.Text = "Цель: ".._G.targetPlayer
end)

createToggle(KillFrame, "Убивать выбранного", false, function(value)
    _G.autoKillTarget = value
    
    if value and _G.targetPlayer ~= "" then
        spawn(function()
            while _G.autoKillTarget do
                local target = game.Players:FindFirstChild(_G.targetPlayer)
                if target then
                    -- Аналогично killPlayer из предыдущей функции
                    local character = game.Players.LocalPlayer.Character
                    if character and target.Character then
                        local leftHand = character:FindFirstChild("LeftHand")
                        local rightHand = character:FindFirstChild("RightHand")
                        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                        
                        if leftHand and targetRoot then
                            firetouchinterest(targetRoot, leftHand, 0)
                            firetouchinterest(targetRoot, leftHand, 1)
                        end
                        
                        if rightHand and targetRoot then
                            firetouchinterest(targetRoot, rightHand, 0)
                            firetouchinterest(targetRoot, rightHand, 1)
                        end
                    end
                end
                wait(0.1)
            end
        end)
    end
end)

-- ================ ТЕЛЕПОРТ ================
local TeleportFrame = ContentFrames[4]

local teleports = {
    ["Спавн"] = CFrame.new(2, 8, 115),
    ["Маленький остров"] = CFrame.new(-34, 7, 1903),
    ["Ледяной зал"] = CFrame.new(-2600.00244, 3.67686558, -403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, -3.7464023e-09, -0.99617666, 3.09302628e-08, 0.0873617008),
    ["Мифический зал"] = CFrame.new(2255, 7, 1071),
    ["Адский зал"] = CFrame.new(-6768, 7, -1287),
    ["Легендарный зал"] = CFrame.new(4604, 991, -3887),
    ["Мускульный зал"] = CFrame.new(-8646, 17, -5738),
    ["Секретная арена"] = CFrame.new(1947, 2, 6191),
    ["Бой в лаве"] = CFrame.new(4471, 119, -8836),
    ["Бой в пустыне"] = CFrame.new(960, 17, -7398),
    ["Бой на ринге"] = CFrame.new(-1849, 20, -6335)
}

for name, position in pairs(teleports) do
    createButton(TeleportFrame, name, function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = position
    end)
end

-- ================ ПЕРЕРОЖДЕНИЕ ================
local RebirthFrame = ContentFrames[5]

local targetRebirths = 0
createInput(RebirthFrame, "Цель перерождений:", "0", function(text)
    targetRebirths = tonumber(text) or 0
end)

createToggle(RebirthFrame, "Авто перерождение до цели", false, function(value)
    _G.autoRebirthToTarget = value
    
    if value then
        spawn(function()
            while _G.autoRebirthToTarget do
                local current = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                if current >= targetRebirths then
                    _G.autoRebirthToTarget = false
                    break
                end
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                wait(0.1)
            end
        end)
    end
end)

createToggle(RebirthFrame, "Бесконечное перерождение", false, function(value)
    _G.infiniteRebirth = value
    
    if value then
        spawn(function()
            while _G.infiniteRebirth do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                wait(0.1)
            end
        end)
    end
end)

createToggle(RebirthFrame, "Всегда рост 1", false, function(value)
    _G.alwaysSize1 = value
    
    if value then
        spawn(function()
            while _G.alwaysSize1 do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
                wait(1)
            end
        end)
    end
end)

createToggle(RebirthFrame, "Телепорт к королю", false, function(value)
    _G.teleportToKing = value
    
    if value then
        spawn(function()
            while _G.teleportToKing do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
                wait(1)
            end
        end)
    end
end)

-- ================ ДРУГОЕ ================
local OtherFrame = ContentFrames[6]

-- Авто сбор подарков
createToggle(OtherFrame, "Авто сбор подарков", false, function(value)
    _G.autoClaimGifts = value
    
    if value then
        spawn(function()
            while _G.autoClaimGifts do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
                wait(60) -- Проверка каждую минуту
            end
        end)
    end
end)

-- Авто рулетка
createToggle(OtherFrame, "Авто рулетка", false, function(value)
    _G.autoSpinWheel = value
    
    if value then
        spawn(function()
            while _G.autoSpinWheel do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
                wait(60) -- Проверка каждую минуту
            end
        end)
    end
end)

-- Статистика
local statsLabel = Instance.new("TextLabel")
statsLabel.Size = UDim2.new(1, -10, 0, 100)
statsLabel.Position = UDim2.new(0, 5, 0, #OtherFrame:GetChildren() * 35)
statsLabel.BackgroundTransparency = 1
statsLabel.Text = "Статистика загружается..."
statsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
statsLabel.Font = Enum.Font.Gotham
statsLabel.TextSize = 12
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.TextYAlignment = Enum.TextYAlignment.Top
statsLabel.Parent = OtherFrame

spawn(function()
    while wait(2) do
        local player = game.Players.LocalPlayer
        local stats = player.leaderstats
        local durability = player.Durability.Value
        
        local text = string.format(
            "Сила: %s\nДолговечность: %s\nПерерождения: %s\nУбийства: %s\nБои: %s",
            tostring(stats.Strength.Value),
            tostring(durability),
            tostring(stats.Rebirths.Value),
            tostring(stats.Kills.Value),
            tostring(stats.Brawls.Value)
        )
        
        statsLabel.Text = text
    end
end)

-- Покупка петов (упрощенная версия)
createButton(OtherFrame, "Купить случайного пета", function()
    local pets = {
        "Neon Guardian",
        "Blue Birdie",
        "Dark Golem",
        "Golden Viking",
        "Red Dragon"
    }
    
    local randomPet = pets[math.random(1, #pets)]
    local pet = ReplicatedStorage.cPetShopFolder:FindFirstChild(randomPet)
    if pet then
        ReplicatedStorage.cPetShopRemote:InvokeServer(pet)
    end
end)

-- Инициализация
switchTab(1)
