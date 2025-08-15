-- Vanegood Hub (чистая база)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем кнопку с фоткой (для открытия/закрытия)
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

-- Перетаскивание иконки
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

-- Основное содержимое (пустое)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -50)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = MainFrame

-- Функция минимизации
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0, 500, 0, 30)
        ContentFrame.Visible = false
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        ContentFrame.Visible = true
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

-- Функция для кнопки с картинкой (открыть/закрыть хаб)
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

-- Создаем вкладки
local Tabs = {}

-- Функция для создания вкладки
local function createTab(name)
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = name
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Position = UDim2.new(0, 0, 0, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.ScrollBarThickness = 3
    tabFrame.Parent = ContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = tabFrame
    
    Tabs[name] = tabFrame
    return tabFrame
end

-- Функция для создания кнопки
local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Функция для создания переключателя
-- Новая функция для создания переключателя с ползунком
local function createToggle(parent, text, default, callback)
    local toggleContainer = Instance.new("Frame")
    toggleContainer.Name = "ToggleContainer"
    toggleContainer.Size = UDim2.new(1, -10, 0, 30)
    toggleContainer.BackgroundTransparency = 1
    toggleContainer.Parent = parent
    
    -- Текст переключателя
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = toggleContainer
    
    -- Фрейм для ползунка
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = "ToggleFrame"
    toggleFrame.Size = UDim2.new(0, 50, 0, 25)
    toggleFrame.Position = UDim2.new(0.7, 5, 0.5, -12)
    toggleFrame.BackgroundColor3 = default and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
    toggleFrame.Parent = toggleContainer
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleFrame
    
    -- Кнопка ползунка
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 21, 0, 21)
    toggleButton.Position = default and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = toggleButton
    
    -- Функция обновления состояния
    local function updateToggle(state)
        local goal = {
            Position = state and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
            BackgroundColor3 = state and Color3.fromRGB(0, 230, 100) or Color3.fromRGB(220, 220, 220)
        }
        
        toggleFrame.BackgroundColor3 = state and Color3.fromRGB(0, 60, 30) or Color3.fromRGB(50, 50, 60)
        
        local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2), goal)
        tween:Play()
        
        if callback then
            callback(state)
        end
    end
    
    -- Обработчик клика
    toggleButton.MouseButton1Click:Connect(function()
        local newState = not (toggleButton.Position == UDim2.new(1, -23, 0.5, -10))
        updateToggle(newState)
    end)
    
    -- Возвращаем функцию для внешнего управления
    return {
        Set = function(self, state)
            updateToggle(state)
        end,
        Get = function(self)
            return toggleButton.Position == UDim2.new(1, -23, 0.5, -10)
        end
    }
end

-- Создаем вкладки
local mainTab = createTab("Меню")
local farmTab = createTab("Фарм")

-- Показываем основную вкладку по умолчанию
Tabs["Меню"].Visible = true

-- Добавляем заголовок
local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, -10, 0, 30)
welcomeLabel.Position = UDim2.new(0, 5, 0, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Добро пожаловать!"
welcomeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextSize = 16
welcomeLabel.Parent = mainTab

-- Anti-AFK System
local VirtualUser = game:GetService("VirtualUser")
local antiAFKConnection

local function setupAntiAFK()
    -- Disconnect previous connection if it exists
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    
    -- Connect to PlayerIdleEvent to prevent AFK kicks
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-Афк сработал")
    end)
    
    print("Включено Анти-Афк")
end

-- Добавляем переключатель Anti-AFK
createToggle(mainTab, "Анти-Афк", true, function(state)
    if state then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
            print("Анти-Афк отключен")
        end
    end
end)

-- Функция для скрытия индикаторов
local function toggleIndicators(hide)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not hide
        end
    end
end

-- Добавляем переключатель для скрытия индикаторов
createToggle(mainTab, "Скрывать индикаторы", false, function(state)
    toggleIndicators(state)
end)

-- Функция для Anti Knockback
local function toggleAntiKnockback(enable)
    if enable then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1250
            bodyVelocity.Parent = rootPart
        end
    else
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
            if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
                existingVelocity:Destroy()
            end
        end
    end
end

-- Добавляем переключатель Anti Knockback
createToggle(mainTab, "Анти отбрасывание", false, toggleAntiKnockback)

-- Функция для блокировки позиции
local positionLockConnection = nil

local function lockPlayerPosition(enable)
    if enable then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = currentPosition
                end
            end)
        end
    else
        if positionLockConnection then
            positionLockConnection:Disconnect()
            positionLockConnection = nil
        end
    end
end

-- Добавляем переключатель блокировки позиции
createToggle(mainTab, "Стоять на месте", false, lockPlayerPosition)

-- Функция для быстрой прокачки силы
local function toggleSpeedGrind(enable)
    if enable then
        -- Здесь должна быть логика для быстрой прокачки силы
        -- Пока просто имитация
        for i = 1, 14 do
            task.spawn(function()
                while enable do
                    player.muscleEvent:FireServer("rep")
                    task.wait()
                end
            end)
        end
    else
        -- Остановка прокачки
    end
end

-- Добавляем переключатель быстрой прокачки
createToggle(farmTab, "Быстрая сила", false, toggleSpeedGrind)

local farmTab = createTab("Фарм")

-- Создаем папку для битья камней с аккордеоном
local autoRockFolder = Instance.new("Frame")
autoRockFolder.Name = "AutoRockFolder"
autoRockFolder.Size = UDim2.new(1, -10, 0, 30)
autoRockFolder.Position = UDim2.new(0, 5, 0, 0)
autoRockFolder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
autoRockFolder.Parent = farmTab

local autoRockCorner = Instance.new("UICorner")
autoRockCorner.CornerRadius = UDim.new(0, 4)
autoRockCorner.Parent = autoRockFolder

local autoRockTitle = Instance.new("TextButton")
autoRockTitle.Size = UDim2.new(1, 0, 1, 0)
autoRockTitle.Position = UDim2.new(0, 0, 0, 0)
autoRockTitle.BackgroundTransparency = 1
autoRockTitle.Text = "Бить камень ▼"
autoRockTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
autoRockTitle.Font = Enum.Font.GothamBold
autoRockTitle.TextSize = 14
autoRockTitle.Parent = autoRockFolder

local autoRockContent = Instance.new("Frame")
autoRockContent.Name = "Content"
autoRockContent.Size = UDim2.new(1, 0, 0, 0)
autoRockContent.Position = UDim2.new(0, 0, 0, 35)
autoRockContent.BackgroundTransparency = 1
autoRockContent.ClipsDescendants = true
autoRockContent.Parent = autoRockFolder

local autoRockLayout = Instance.new("UIListLayout")
autoRockLayout.Padding = UDim.new(0, 5)
autoRockLayout.Parent = autoRockContent

-- Функция для открытия/закрытия аккордеона
local autoRockExpanded = false
autoRockTitle.MouseButton1Click:Connect(function()
    autoRockExpanded = not autoRockExpanded
    if autoRockExpanded then
        autoRockTitle.Text = "Бить камень ▲"
        autoRockContent.Size = UDim2.new(1, 0, 0, 360) -- Высота для 9 кнопок
    else
        autoRockTitle.Text = "Бить камень ▼"
        autoRockContent.Size = UDim2.new(1, 0, 0, 0)
    end
end)

-- Функция для битья камней
function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

-- Создаем переключатели для камней
local rockTypes = {
    {name = "Маленький камень - 0", durability = 0, rockName = "Tiny Island Rock"},
    {name = "Средний камень - 100", durability = 100, rockName = "Starter Island Rock"},
    {name = "Золотой камень - 5000", durability = 5000, rockName = "Legend Beach Rock"},
    {name = "Ледяной камень - 150000", durability = 150000, rockName = "Frost Gym Rock"},
    {name = "Мифический камень - 400000", durability = 400000, rockName = "Mythical Gym Rock"},
    {name = "Адский камень - 750000", durability = 750000, rockName = "Eternal Gym Rock"},
    {name = "Легендарный камень - 1000000", durability = 1000000, rockName = "Legend Gym Rock"},
    {name = "Королевский камень - 5000000", durability = 5000000, rockName = "Muscle King Gym Rock"},
    {name = "Камень в Джунглях - 10000000", durability = 10000000, rockName = "Ancient Jungle Rock"}
}

for _, rock in pairs(rockTypes) do
    createToggle(autoRockContent, rock.name, false, function(Value)
        getgenv().autoFarm = Value
        selectrock = rock.rockName
        
        task.spawn(function()
            while getgenv().autoFarm do
                task.wait()
                if not getgenv().autoFarm then break end
                
                if game:GetService("Players").LocalPlayer.Durability.Value >= rock.durability then
                    for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == rock.durability and 
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

-- Создаем папку для перерождений с аккордеоном
local rebirthsFolder = Instance.new("Frame")
rebirthsFolder.Name = "RebirthsFolder"
rebirthsFolder.Size = UDim2.new(1, -10, 0, 30)
rebirthsFolder.Position = UDim2.new(0, 5, 0, 0)
rebirthsFolder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
rebirthsFolder.Parent = farmTab

local rebirthsCorner = Instance.new("UICorner")
rebirthsCorner.CornerRadius = UDim.new(0, 4)
rebirthsCorner.Parent = rebirthsFolder

local rebirthsTitle = Instance.new("TextButton")
rebirthsTitle.Size = UDim2.new(1, 0, 1, 0)
rebirthsTitle.Position = UDim2.new(0, 0, 0, 0)
rebirthsTitle.BackgroundTransparency = 1
rebirthsTitle.Text = "Перерождения ▼"
rebirthsTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
rebirthsTitle.Font = Enum.Font.GothamBold
rebirthsTitle.TextSize = 14
rebirthsTitle.Parent = rebirthsFolder

local rebirthsContent = Instance.new("Frame")
rebirthsContent.Name = "Content"
rebirthsContent.Size = UDim2.new(1, 0, 0, 0)
rebirthsContent.Position = UDim2.new(0, 0, 0, 35)
rebirthsContent.BackgroundTransparency = 1
rebirthsContent.ClipsDescendants = true
rebirthsContent.Parent = rebirthsFolder

local rebirthsLayout = Instance.new("UIListLayout")
rebirthsLayout.Padding = UDim.new(0, 5)
rebirthsLayout.Parent = rebirthsContent

-- Функция для открытия/закрытия аккордеона
local rebirthsExpanded = false
rebirthsTitle.MouseButton1Click:Connect(function()
    rebirthsExpanded = not rebirthsExpanded
    if rebirthsExpanded then
        rebirthsTitle.Text = "Перерождения ▲"
        rebirthsContent.Size = UDim2.new(1, 0, 0, 180) -- Высота для всех элементов
    else
        rebirthsTitle.Text = "Перерождения ▼"
        rebirthsContent.Size = UDim2.new(1, 0, 0, 0)
    end
end)

-- Текстовое поле для ввода количества перерождений
local rebirthInputFrame = Instance.new("Frame")
rebirthInputFrame.Size = UDim2.new(1, 0, 0, 30)
rebirthInputFrame.BackgroundTransparency = 1
rebirthInputFrame.Parent = rebirthsContent

local rebirthInputBox = Instance.new("TextBox")
rebirthInputBox.Size = UDim2.new(0.7, 0, 1, 0)
rebirthInputBox.Position = UDim2.new(0, 0, 0, 0)
rebirthInputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
rebirthInputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
rebirthInputBox.Font = Enum.Font.Gotham
rebirthInputBox.TextSize = 14
rebirthInputBox.PlaceholderText = "Сколько нужно?"
rebirthInputBox.Parent = rebirthInputFrame

local rebirthInputButton = Instance.new("TextButton")
rebirthInputButton.Size = UDim2.new(0.3, -5, 1, 0)
rebirthInputButton.Position = UDim2.new(0.7, 5, 0, 0)
rebirthInputButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
rebirthInputButton.Text = "OK"
rebirthInputButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rebirthInputButton.Font = Enum.Font.GothamBold
rebirthInputButton.TextSize = 14
rebirthInputButton.Parent = rebirthInputFrame

local targetRebirthValue = 0
local _G = {
    targetRebirthActive = false,
    infiniteRebirthActive = false,
    autoSizeActive = false,
    teleportActive = false
}

rebirthInputButton.MouseButton1Click:Connect(function()
    local text = rebirthInputBox.Text
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats()
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет " .. targetRebirthValue .. " перерождений",
            Duration = 2
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Ошибка",
            Text = "Введите число больше 0",
            Duration = 2
        })
    end
end)

-- Переключатели для перерождений
createToggle(rebirthsContent, "Начать перерождаться по количеству", false, function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        if _G.infiniteRebirthActive then
            _G.infiniteRebirthActive = false
        end
        
        task.spawn(function()
            while _G.targetRebirthActive and task.wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    _G.targetRebirthActive = false
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Готово",
                        Text = "Достигнуто " .. targetRebirthValue .. " перерождений",
                        Duration = 2
                    })
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

createToggle(rebirthsContent, "Перерождаться бесконечно", false, function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        if _G.targetRebirthActive then
            _G.targetRebirthActive = false
        end
        
        task.spawn(function()
            while _G.infiniteRebirthActive and task.wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end)

createToggle(rebirthsContent, "Всегда рост 1", false, function(bool)
    _G.autoSizeActive = bool
    
    task.spawn(function()
        while _G.autoSizeActive and task.wait() do
            game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
        end
    end)
end)

createToggle(rebirthsContent, "Телепортироваться к королю", false, function(bool)
    _G.teleportActive = bool
    
    task.spawn(function()
        while _G.teleportActive and task.wait() do
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
            end
        end
    end)
end)

-- Создаем папку для автоматического кача с аккордеоном
local autoEquipFolder = Instance.new("Frame")
autoEquipFolder.Name = "AutoEquipFolder"
autoEquipFolder.Size = UDim2.new(1, -10, 0, 30)
autoEquipFolder.Position = UDim2.new(0, 5, 0, 0)
autoEquipFolder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
autoEquipFolder.Parent = farmTab

local autoEquipCorner = Instance.new("UICorner")
autoEquipCorner.CornerRadius = UDim.new(0, 4)
autoEquipCorner.Parent = autoEquipFolder

local autoEquipTitle = Instance.new("TextButton")
autoEquipTitle.Size = UDim2.new(1, 0, 1, 0)
autoEquipTitle.Position = UDim2.new(0, 0, 0, 0)
autoEquipTitle.BackgroundTransparency = 1
autoEquipTitle.Text = "Автоматически качаться ▼"
autoEquipTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
autoEquipTitle.Font = Enum.Font.GothamBold
autoEquipTitle.TextSize = 14
autoEquipTitle.Parent = autoEquipFolder

local autoEquipContent = Instance.new("Frame")
autoEquipContent.Name = "Content"
autoEquipContent.Size = UDim2.new(1, 0, 0, 0)
autoEquipContent.Position = UDim2.new(0, 0, 0, 35)
autoEquipContent.BackgroundTransparency = 1
autoEquipContent.ClipsDescendants = true
autoEquipContent.Parent = autoEquipFolder

local autoEquipLayout = Instance.new("UIListLayout")
autoEquipLayout.Padding = UDim.new(0, 5)
autoEquipLayout.Parent = autoEquipContent

-- Функция для открытия/закрытия аккордеона
local autoEquipExpanded = false
autoEquipTitle.MouseButton1Click:Connect(function()
    autoEquipExpanded = not autoEquipExpanded
    if autoEquipExpanded then
        autoEquipTitle.Text = "Автоматически качаться ▲"
        autoEquipContent.Size = UDim2.new(1, 0, 0, 220) -- Высота для всех элементов
    else
        autoEquipTitle.Text = "Автоматически качаться ▼"
        autoEquipContent.Size = UDim2.new(1, 0, 0, 0)
    end
end)

-- Кнопка для автолифта
local autoLiftButton = Instance.new("TextButton")
autoLiftButton.Size = UDim2.new(1, 0, 0, 30)
autoLiftButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
autoLiftButton.Text = "Автолифт"
autoLiftButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoLiftButton.Font = Enum.Font.GothamBold
autoLiftButton.TextSize = 14
autoLiftButton.Parent = autoEquipContent

autoLiftButton.MouseButton1Click:Connect(function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Автолифт активирован",
        Duration = 2
    })
end)

-- Переключатели для автоматического кача
local exerciseTypes = {
    {name = "Авто гантеля", tool = "Weight"},
    {name = "Авто отжимания", tool = "Pushups"},
    {name = "Авто отжимания стоя", tool = "Handstands"},
    {name = "Авто пресс", tool = "Situps"},
    {name = "Авто удары", tool = "Punch"}
}

for _, exercise in pairs(exerciseTypes) do
    createToggle(autoEquipContent, exercise.name, false, function(Value)
        _G["Auto"..exercise.tool] = Value
        
        if Value then
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(exercise.tool)
            if tool then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
            end
        else
            local character = game.Players.LocalPlayer.Character
            local equipped = character:FindFirstChild(exercise.tool)
            if equipped then
                equipped.Parent = game.Players.LocalPlayer.Backpack
            end
        end
        
        if exercise.tool ~= "Punch" then
            task.spawn(function()
                while _G["Auto"..exercise.tool] do
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    task.wait(0.1)
                end
            end)
        else
            task.spawn(function()
                while _G.AutoPunch do
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                    task.wait(0)
                end
            end)
        end
    end)
end

-- Переключатель для быстрых предметов
createToggle(autoEquipContent, "Быстрые предметы", false, function(Value)
    _G.FastTools = Value
    
    local defaultSpeeds = {
        {"Punch", "attackTime", Value and 0 or 0.35},
        {"Ground Slam", "attackTime", Value and 0 or 6},
        {"Stomp", "attackTime", Value and 0 or 7},
        {"Handstands", "repTime", Value and 0 or 2},
        {"Situps", "repTime", Value and 0 or 2.5},
        {"Pushups", "repTime", Value and 0 or 2.5},
        {"Weight", "repTime", Value and 0 or 3}
    }
    
    for _, toolData in pairs(defaultSpeeds) do
        local toolName, property, speed = toolData[1], toolData[2], toolData[3]
        
        local backpackTool = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
        if backpackTool and backpackTool:FindFirstChild(property) then
            backpackTool[property].Value = speed
        end
        
        local equippedTool = game.Players.LocalPlayer.Character:FindFirstChild(toolName)
        if equippedTool and equippedTool:FindFirstChild(property) then
            equippedTool[property].Value = speed
        end
    end
end)

-- Переключатель для антилага
createToggle(autoEquipContent, "Анти лаг", false, function(Value)
    _G.AntiLag = Value
    
    if Value then
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

-- Создаем папку для статистики с аккордеоном
local statsFolder = Instance.new("Frame")
statsFolder.Name = "StatsFolder"
statsFolder.Size = UDim2.new(1, -10, 0, 30)
statsFolder.Position = UDim2.new(0, 5, 0, 0)
statsFolder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
statsFolder.Parent = farmTab

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 4)
statsCorner.Parent = statsFolder

local statsTitle = Instance.new("TextButton")
statsTitle.Size = UDim2.new(1, 0, 1, 0)
statsTitle.Position = UDim2.new(0, 0, 0, 0)
statsTitle.BackgroundTransparency = 1
statsTitle.Text = "Статистика ▼"
statsTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
statsTitle.Font = Enum.Font.GothamBold
statsTitle.TextSize = 14
statsTitle.Parent = statsFolder

local statsContent = Instance.new("Frame")
statsContent.Name = "Content"
statsContent.Size = UDim2.new(1, 0, 0, 0)
statsContent.Position = UDim2.new(0, 0, 0, 35)
statsContent.BackgroundTransparency = 1
statsContent.ClipsDescendants = true
statsContent.Parent = statsFolder

local statsLayout = Instance.new("UIListLayout")
statsLayout.Padding = UDim.new(0, 5)
statsLayout.Parent = statsContent

-- Функция для открытия/закрытия аккордеона
local statsExpanded = false
statsTitle.MouseButton1Click:Connect(function()
    statsExpanded = not statsExpanded
    if statsExpanded then
        statsTitle.Text = "Статистика ▲"
        statsContent.Size = UDim2.new(1, 0, 0, 250) -- Высота для всех элементов
    else
        statsTitle.Text = "Статистика ▼"
        statsContent.Size = UDim2.new(1, 0, 0, 0)
    end
end)

-- Инициализация переменных для статистики
local sessionStartTime = os.time()
local sessionStartStrength = 0
local sessionStartDurability = 0
local sessionStartKills = 0
local sessionStartRebirths = 0
local sessionStartBrawls = 0
local hasStartedTracking = false

-- Функции для форматирования
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
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

-- Создаем элементы статистики
local statLabels = {
    {title = "Сила", name = "Strength"},
    {title = "Долговечность", name = "Durability"},
    {title = "Перерождения", name = "Rebirths"},
    {title = "Убийства", name = "Kills"},
    {title = "Поединки", name = "Brawls"}
}

local statElements = {}

for _, stat in pairs(statLabels) do
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = stat.title
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = statsContent
    
    local currentLabel = Instance.new("TextLabel")
    currentLabel.Size = UDim2.new(1, 0, 0, 20)
    currentLabel.BackgroundTransparency = 1
    currentLabel.Text = "Текущее: 0"
    currentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    currentLabel.Font = Enum.Font.Gotham
    currentLabel.TextSize = 12
    currentLabel.TextXAlignment = Enum.TextXAlignment.Left
    currentLabel.Parent = statsContent
    
    local gainLabel = Instance.new("TextLabel")
    gainLabel.Size = UDim2.new(1, 0, 0, 20)
    gainLabel.BackgroundTransparency = 1
    gainLabel.Text = "Получено: 0"
    gainLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    gainLabel.Font = Enum.Font.Gotham
    gainLabel.TextSize = 12
    gainLabel.TextXAlignment = Enum.TextXAlignment.Left
    gainLabel.Parent = statsContent
    
    statElements[stat.name] = {
        current = currentLabel,
        gain = gainLabel
    }
end

-- Время сессии
local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, 0, 0, 20)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Время: 00:00:00"
timeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 14
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = statsContent

-- Кнопки управления статистикой
local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(0.48, 0, 0, 30)
resetButton.Position = UDim2.new(0, 0, 0, 0)
resetButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
resetButton.Text = "Очистить статистику"
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.Font = Enum.Font.GothamBold
resetButton.TextSize = 14
resetButton.Parent = statsContent

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.48, 0, 0, 30)
copyButton.Position = UDim2.new(0.52, 0, 0, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
copyButton.Text = "Скопировать"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 14
copyButton.Parent = statsContent

-- Функция для обновления статистики
local function updateStats()
    local player = game.Players.LocalPlayer
    
    if not hasStartedTracking then
        sessionStartStrength = player.leaderstats.Strength.Value
        sessionStartDurability = player.Durability.Value
        sessionStartKills = player.leaderstats.Kills.Value
        sessionStartRebirths = player.leaderstats.Rebirths.Value
        sessionStartBrawls = player.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end
    
    local currentStats = {
        Strength = player.leaderstats.Strength.Value,
        Durability = player.Durability.Value,
        Kills = player.leaderstats.Kills.Value,
        Rebirths = player.leaderstats.Rebirths.Value,
        Brawls = player.leaderstats.Brawls.Value
    }
    
    for statName, elements in pairs(statElements) do
        elements.current.Text = "Текущее: " .. formatNumber(currentStats[statName])
        elements.gain.Text = "Получено: " .. formatNumber(currentStats[statName] - sessionStartStats[statName])
    end
    
    local elapsedTime = os.time() - sessionStartTime
    timeLabel.Text = "Время: " .. formatTime(elapsedTime)
end

-- Обработчики кнопок
resetButton.MouseButton1Click:Connect(function()
    sessionStartStrength = game.Players.LocalPlayer.leaderstats.Strength.Value
    sessionStartDurability = game.Players.LocalPlayer.Durability.Value
    sessionStartKills = game.Players.LocalPlayer.leaderstats.Kills.Value
    sessionStartRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
    sessionStartBrawls = game.Players.LocalPlayer.leaderstats.Brawls.Value
    sessionStartTime = os.time()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Статистика очищена",
        Duration = 2
    })
end)

copyButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local statsText = "Muscle Legends Статистика:\n\n"
    
    statsText = statsText .. "Сила: " .. formatNumber(player.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Долговечность: " .. formatNumber(player.Durability.Value) .. "\n"
    statsText = statsText .. "Перерождения: " .. formatNumber(player.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Убийства: " .. formatNumber(player.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Поединки: " .. formatNumber(player.leaderstats.Brawls.Value) .. "\n"
    
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        statsText = statsText .. "\nСтатистика сессии:\n"
        statsText = statsText .. "Время: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Сила: +" .. formatNumber(player.leaderstats.Strength.Value - sessionStartStrength) .. "\n"
        statsText = statsText .. "Долговечность: +" .. formatNumber(player.Durability.Value - sessionStartDurability) .. "\n"
        statsText = statsText .. "Перерождения: +" .. formatNumber(player.leaderstats.Rebirths.Value - sessionStartRebirths) .. "\n"
        statsText = statsText .. "Убийства: +" .. formatNumber(player.leaderstats.Kills.Value - sessionStartKills) .. "\n"
        statsText = statsText .. "Поединки: +" .. formatNumber(player.leaderstats.Brawls.Value - sessionStartBrawls) .. "\n"
    end
    
    setclipboard(statsText)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Статистика скопирована",
        Duration = 2
    })
end)

-- Обновление статистики каждые 2 секунды
task.spawn(function()
    while task.wait(2) do
        updateStats()
    end
end)

-- Создаем вкладку для питомцев
local petsTab = createTab("Петы")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Добавляем заголовок для питомцев
local petsLabel = Instance.new("TextLabel")
petsLabel.Size = UDim2.new(1, -10, 0, 30)
petsLabel.Position = UDim2.new(0, 5, 0, 0)
petsLabel.BackgroundTransparency = 1
petsLabel.Text = "Петы"
petsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
petsLabel.Font = Enum.Font.GothamBold
petsLabel.TextSize = 16
petsLabel.Parent = petsTab

-- Выпадающий список для выбора питомца
local selectedPet = "Neon Guardian"
local petDropdownFrame = Instance.new("Frame")
petDropdownFrame.Size = UDim2.new(1, -10, 0, 30)
petDropdownFrame.BackgroundTransparency = 1
petDropdownFrame.Parent = petsTab

local petDropdownLabel = Instance.new("TextLabel")
petDropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
petDropdownLabel.Position = UDim2.new(0, 0, 0, 0)
petDropdownLabel.BackgroundTransparency = 1
petDropdownLabel.Text = "Выбери пета:"
petDropdownLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
petDropdownLabel.Font = Enum.Font.Gotham
petDropdownLabel.TextSize = 14
petDropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
petDropdownLabel.Parent = petDropdownFrame

local petDropdownButton = Instance.new("TextButton")
petDropdownButton.Size = UDim2.new(0.3, -5, 1, 0)
petDropdownButton.Position = UDim2.new(0.7, 5, 0, 0)
petDropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
petDropdownButton.Text = selectedPet
petDropdownButton.TextColor3 = Color3.fromRGB(220, 220, 220)
petDropdownButton.Font = Enum.Font.Gotham
petDropdownButton.TextSize = 14
petDropdownButton.Parent = petDropdownFrame

local petDropdownCorner = Instance.new("UICorner")
petDropdownCorner.CornerRadius = UDim.new(0, 4)
petDropdownCorner.Parent = petDropdownButton

-- Список питомцев
local petOptions = {
    "Neon Guardian", "Blue Birdie", "Blue Bunny", "Blue Firecaster", "Blue Pheonix",
    "Crimson Falcon", "Cybernetic Showdown Dragon", "Dark Golem", "Dark Legends Manticore",
    "Dark Vampy", "Darkstar Hunter", "Eternal Strike Leviathan", "Frostwave Legends Penguin",
    "Gold Warrior", "Golden Pheonix", "Golden Viking", "Green Butterfly", "Green Firecaster",
    "Infernal Dragon", "Lightning Strike Phantom", "Magic Butterfly", "Muscle Sensei",
    "Orange Hedgehog", "Orange Pegasus", "Phantom Genesis Dragon", "Purple Dragon",
    "Purple Falcon", "Red Dragon", "Red Firecaster", "Red Kitty", "Silver Dog",
    "Ultimate Supernova Pegasus", "Ultra Birdie", "White Pegasus", "White Pheonix",
    "Yellow Butterfly"
}

-- Фрейм для списка питомцев (появляется при нажатии)
local petOptionsFrame = Instance.new("ScrollingFrame")
petOptionsFrame.Size = UDim2.new(0.3, -5, 0, 150)
petOptionsFrame.Position = UDim2.new(0.7, 5, 0, 35)
petOptionsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
petOptionsFrame.Visible = false
petOptionsFrame.Parent = petsTab

local petOptionsLayout = Instance.new("UIListLayout")
petOptionsLayout.Padding = UDim.new(0, 5)
petOptionsLayout.Parent = petOptionsFrame

-- Заполняем список питомцев
for _, petName in ipairs(petOptions) do
    local petOption = Instance.new("TextButton")
    petOption.Size = UDim2.new(1, -10, 0, 30)
    petOption.Position = UDim2.new(0, 5, 0, 0)
    petOption.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    petOption.Text = petName
    petOption.TextColor3 = Color3.fromRGB(220, 220, 220)
    petOption.Font = Enum.Font.Gotham
    petOption.TextSize = 14
    petOption.Parent = petOptionsFrame
    
    petOption.MouseButton1Click:Connect(function()
        selectedPet = petName
        petDropdownButton.Text = petName
        petOptionsFrame.Visible = false
    end)
end

-- Обработчик открытия/закрытия списка
petDropdownButton.MouseButton1Click:Connect(function()
    petOptionsFrame.Visible = not petOptionsFrame.Visible
end)

-- Переключатель для автоматической покупки питомцев
createToggle(petsTab, "Купить", false, function(state)
    _G.AutoHatchPet = state
    
    if state then
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

-- Добавляем разделитель
local separator1 = Instance.new("Frame")
separator1.Size = UDim2.new(1, -10, 0, 1)
separator1.Position = UDim2.new(0, 5, 0, 0)
separator1.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
separator1.BorderSizePixel = 0
separator1.Parent = petsTab

-- Добавляем заголовок для аур
local aurasLabel = Instance.new("TextLabel")
aurasLabel.Size = UDim2.new(1, -10, 0, 30)
aurasLabel.Position = UDim2.new(0, 5, 0, 0)
aurasLabel.BackgroundTransparency = 1
aurasLabel.Text = "Ауры"
aurasLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
aurasLabel.Font = Enum.Font.GothamBold
aurasLabel.TextSize = 16
aurasLabel.Parent = petsTab

-- Выпадающий список для выбора ауры
local selectedAura = "Blue Aura"
local auraDropdownFrame = Instance.new("Frame")
auraDropdownFrame.Size = UDim2.new(1, -10, 0, 30)
auraDropdownFrame.BackgroundTransparency = 1
auraDropdownFrame.Parent = petsTab

local auraDropdownLabel = Instance.new("TextLabel")
auraDropdownLabel.Size = UDim2.new(0.7, 0, 1, 0)
auraDropdownLabel.Position = UDim2.new(0, 0, 0, 0)
auraDropdownLabel.BackgroundTransparency = 1
auraDropdownLabel.Text = "Выбери ауру:"
auraDropdownLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
auraDropdownLabel.Font = Enum.Font.Gotham
auraDropdownLabel.TextSize = 14
auraDropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
auraDropdownLabel.Parent = auraDropdownFrame

local auraDropdownButton = Instance.new("TextButton")
auraDropdownButton.Size = UDim2.new(0.3, -5, 1, 0)
auraDropdownButton.Position = UDim2.new(0.7, 5, 0, 0)
auraDropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
auraDropdownButton.Text = selectedAura
auraDropdownButton.TextColor3 = Color3.fromRGB(220, 220, 220)
auraDropdownButton.Font = Enum.Font.Gotham
auraDropdownButton.TextSize = 14
auraDropdownButton.Parent = auraDropdownFrame

local auraDropdownCorner = Instance.new("UICorner")
auraDropdownCorner.CornerRadius = UDim.new(0, 4)
auraDropdownCorner.Parent = auraDropdownButton

-- Список аур
local auraOptions = {
    "Astral Electro", "Azure Tundra", "Blue Aura", "Dark Electro", "Dark Lightning",
    "Dark Storm", "Electro", "Enchanted Mirage", "Entropic Blast", "Eternal Megastrike",
    "Grand Supernova", "Green Aura", "Inferno", "Lightning", "Muscle King",
    "Power Lightning", "Purple Aura", "Purple Nova", "Red Aura", "Supernova",
    "Ultra Inferno", "Ultra Mirage", "Unstable Mirage", "Yellow Aura"
}

-- Фрейм для списка аур (появляется при нажатии)
local auraOptionsFrame = Instance.new("ScrollingFrame")
auraOptionsFrame.Size = UDim2.new(0.3, -5, 0, 150)
auraOptionsFrame.Position = UDim2.new(0.7, 5, 0, 35)
auraOptionsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
auraOptionsFrame.Visible = false
auraOptionsFrame.Parent = petsTab

local auraOptionsLayout = Instance.new("UIListLayout")
auraOptionsLayout.Padding = UDim.new(0, 5)
auraOptionsLayout.Parent = auraOptionsFrame

-- Заполняем список аур
for _, auraName in ipairs(auraOptions) do
    local auraOption = Instance.new("TextButton")
    auraOption.Size = UDim2.new(1, -10, 0, 30)
    auraOption.Position = UDim2.new(0, 5, 0, 0)
    auraOption.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    auraOption.Text = auraName
    auraOption.TextColor3 = Color3.fromRGB(220, 220, 220)
    auraOption.Font = Enum.Font.Gotham
    auraOption.TextSize = 14
    auraOption.Parent = auraOptionsFrame
    
    auraOption.MouseButton1Click:Connect(function()
        selectedAura = auraName
        auraDropdownButton.Text = auraName
        auraOptionsFrame.Visible = false
    end)
end

-- Обработчик открытия/закрытия списка
auraDropdownButton.MouseButton1Click:Connect(function()
    auraOptionsFrame.Visible = not auraOptionsFrame.Visible
end)

-- Переключатель для автоматической покупки аур
createToggle(petsTab, "Купить", false, function(state)
    _G.AutoHatchAura = state
    
    if state then
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

-- Создаем вкладку "Другое"
local miscTab = createTab("Другое")

-- Создаем папку "Авто рулетка и подарки"
local miscFolder = Instance.new("Frame")
miscFolder.Name = "MiscFolder"
miscFolder.Size = UDim2.new(1, -10, 0, 30)
miscFolder.Position = UDim2.new(0, 5, 0, 0)
miscFolder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
miscFolder.Parent = miscTab

local miscCorner = Instance.new("UICorner")
miscCorner.CornerRadius = UDim.new(0, 4)
miscCorner.Parent = miscFolder

local miscTitle = Instance.new("TextButton")
miscTitle.Size = UDim2.new(1, 0, 1, 0)
miscTitle.Position = UDim2.new(0, 0, 0, 0)
miscTitle.BackgroundTransparency = 1
miscTitle.Text = "Авто рулетка и подарки ▼"
miscTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
miscTitle.Font = Enum.Font.GothamBold
miscTitle.TextSize = 14
miscTitle.Parent = miscFolder

local miscContent = Instance.new("Frame")
miscContent.Name = "Content"
miscContent.Size = UDim2.new(1, 0, 0, 0)
miscContent.Position = UDim2.new(0, 0, 0, 35)
miscContent.BackgroundTransparency = 1
miscContent.ClipsDescendants = true
miscContent.Parent = miscFolder

local miscLayout = Instance.new("UIListLayout")
miscLayout.Padding = UDim.new(0, 5)
miscLayout.Parent = miscContent

-- Функция для открытия/закрытия аккордеона
local miscExpanded = false
miscTitle.MouseButton1Click:Connect(function()
    miscExpanded = not miscExpanded
    if miscExpanded then
        miscTitle.Text = "Авто рулетка и подарки ▲"
        miscContent.Size = UDim2.new(1, 0, 0, 70) -- Высота для двух элементов
    else
        miscTitle.Text = "Авто рулетка и подарки ▼"
        miscContent.Size = UDim2.new(1, 0, 0, 0)
    end
end)

-- Переключатель для авто прокрутки колеса удачи
createToggle(miscContent, "Авто прокрутка колеса удачи", false, function(bool)
    _G.AutoSpinWheel = bool
    
    if bool then
        task.spawn(function()
            while _G.AutoSpinWheel do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
                task.wait(1)
            end
        end)
    end
end)

-- Переключатель для авто сбора подарков
createToggle(miscContent, "Авто сбор подарков", false, function(bool)
    _G.AutoClaimGifts = bool
    
    if bool then
        task.spawn(function()
            while _G.AutoClaimGifts do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
                task.wait(1)
            end
        end)
    end
end)

-- Создаем вкладку "Убийства"
local killerTab = createTab("Убийства")

-- Инициализация переменных
_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

-- Функция для проверки персонажа
local function checkCharacter()
    local player = game.Players.LocalPlayer
    if not player then return nil end
    
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        local startTime = tick()
        repeat
            task.wait(0.1)
            if tick() - startTime > 5 then return nil end
        until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    end
    
    return player.Character
end

-- Функция для экипировки инструмента
local function gettool()
    pcall(function()
        if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            return
        end
        
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "Punch" then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end
        end
        
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
    end)
end

-- Функция для убийства игрока
local function killPlayer(target)
    local character = checkCharacter()
    if not character then return end
    
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    if not character:FindFirstChild("LeftHand") then
        return
    end
    
    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
        task.wait(0.01)
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
        gettool()
    end)
end

-- Функция для поиска игрока по имени
local function findClosestPlayer(input)
    if not input or input == "" then return nil end
    
    input = input:lower()
    local bestMatch = nil
    local bestScore = 0
    
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local username = player.Name:lower()
            local displayName = player.DisplayName:lower()
            
            local usernameMatch = username:find(input, 1, true) ~= nil
            local displayMatch = displayName:find(input, 1, true) ~= nil
            
            local usernameScore = 0
            local displayScore = 0
            
            if usernameMatch then
                usernameScore = (#input / #username) * 100
                if username:sub(1, #input) == input then
                    usernameScore = usernameScore + 50
                end
            end
            
            if displayMatch then
                displayScore = (#input / #displayName) * 100
                if displayName:sub(1, #input) == input then
                    displayScore = displayScore + 50
                end
            end
            
            local score = math.max(usernameScore, displayScore)
            
            if score > bestScore then
                bestScore = score
                bestMatch = player
            end
        end
    end
    
    if bestScore > 20 then
        return bestMatch
    end
    
    return nil
end

-- Создаем элементы интерфейса
local whitelistedPlayersLabel = Instance.new("TextLabel")
whitelistedPlayersLabel.Size = UDim2.new(1, -10, 0, 30)
whitelistedPlayersLabel.Position = UDim2.new(0, 5, 0, 0)
whitelistedPlayersLabel.BackgroundTransparency = 1
whitelistedPlayersLabel.Text = "Белый список: Нету"
whitelistedPlayersLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
whitelistedPlayersLabel.Font = Enum.Font.Gotham
whitelistedPlayersLabel.TextSize = 14
whitelistedPlayersLabel.TextXAlignment = Enum.TextXAlignment.Left
whitelistedPlayersLabel.Parent = killerTab

local targetPlayerLabel = Instance.new("TextLabel")
targetPlayerLabel.Size = UDim2.new(1, -10, 0, 30)
targetPlayerLabel.Position = UDim2.new(0, 5, 0, 35)
targetPlayerLabel.BackgroundTransparency = 1
targetPlayerLabel.Text = "Атаковать игрока: Нету"
targetPlayerLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
targetPlayerLabel.Font = Enum.Font.Gotham
targetPlayerLabel.TextSize = 14
targetPlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
targetPlayerLabel.Parent = killerTab

-- Функции для обновления UI
local function updateWhitelistedPlayersLabel()
    if #_G.whitelistedPlayers == 0 then
        whitelistedPlayersLabel.Text = "Белый список: Нету"
    else
        local displayText = "Белый список: "
        for i, playerInfo in ipairs(_G.whitelistedPlayers) do
            if i > 1 then displayText = displayText .. ", " end
            displayText = displayText .. playerInfo
        end
        whitelistedPlayersLabel.Text = displayText
    end
end

local function updateTargetPlayerLabel()
    if _G.targetPlayer == "" then
        targetPlayerLabel.Text = "Кого убивать: Нету"
    else
        targetPlayerLabel.Text = "Кого убивать: " .. _G.targetPlayer
    end
end

-- Переключатель для авто-добавления друзей в белый список
createToggle(killerTab, "Автоматом друзей в белый список", false, function(bool)
    _G.autoWhitelistFriends = bool
    
    if bool then
        pcall(function()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                    local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
                    if not table.find(_G.whitelistedPlayers, playerInfo) then
                        table.insert(_G.whitelistedPlayers, playerInfo)
                    end
                end
            end
            updateWhitelistedPlayersLabel()
        end)
    end
end)

-- Обработчик добавления игроков
game.Players.PlayerAdded:Connect(function(player)
    if _G.autoWhitelistFriends then
        pcall(function()
            if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
                local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
                if not table.find(_G.whitelistedPlayers, playerInfo) then
                    table.insert(_G.whitelistedPlayers, playerInfo)
                    updateWhitelistedPlayersLabel()
                end
            end
        end)
    end
end)

-- Текстовое поле для добавления в белый список
local addWhitelistFrame = Instance.new("Frame")
addWhitelistFrame.Size = UDim2.new(1, -10, 0, 30)
addWhitelistFrame.BackgroundTransparency = 1
addWhitelistFrame.Parent = killerTab

local addWhitelistBox = Instance.new("TextBox")
addWhitelistBox.Size = UDim2.new(0.7, 0, 1, 0)
addWhitelistBox.Position = UDim2.new(0, 0, 0, 0)
addWhitelistBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addWhitelistBox.TextColor3 = Color3.fromRGB(220, 220, 220)
addWhitelistBox.Font = Enum.Font.Gotham
addWhitelistBox.TextSize = 14
addWhitelistBox.PlaceholderText = "Добавить в белый список (ник)"
addWhitelistBox.Parent = addWhitelistFrame

local addWhitelistButton = Instance.new("TextButton")
addWhitelistButton.Size = UDim2.new(0.3, -5, 1, 0)
addWhitelistButton.Position = UDim2.new(0.7, 5, 0, 0)
addWhitelistButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addWhitelistButton.Text = "Добавить"
addWhitelistButton.TextColor3 = Color3.fromRGB(220, 220, 220)
addWhitelistButton.Font = Enum.Font.Gotham
addWhitelistButton.TextSize = 14
addWhitelistButton.Parent = addWhitelistFrame

addWhitelistButton.MouseButton1Click:Connect(function()
    local text = addWhitelistBox.Text
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            local playerInfo = player.Name .. " (" .. player.DisplayName .. ")"
            
            local alreadyWhitelisted = false
            for _, info in ipairs(_G.whitelistedPlayers) do
                if info:find(player.Name, 1, true) then
                    alreadyWhitelisted = true
                    break
                end
            end
            
            if not alreadyWhitelisted then
                table.insert(_G.whitelistedPlayers, playerInfo)
                updateWhitelistedPlayersLabel()
            end
        end
    end
end)

-- Текстовое поле для удаления из белого списка
local removeWhitelistFrame = Instance.new("Frame")
removeWhitelistFrame.Size = UDim2.new(1, -10, 0, 30)
removeWhitelistFrame.BackgroundTransparency = 1
removeWhitelistFrame.Parent = killerTab

local removeWhitelistBox = Instance.new("TextBox")
removeWhitelistBox.Size = UDim2.new(0.7, 0, 1, 0)
removeWhitelistBox.Position = UDim2.new(0, 0, 0, 0)
removeWhitelistBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
removeWhitelistBox.TextColor3 = Color3.fromRGB(220, 220, 220)
removeWhitelistBox.Font = Enum.Font.Gotham
removeWhitelistBox.TextSize = 14
removeWhitelistBox.PlaceholderText = "Удалить с белого списка (ник)"
removeWhitelistBox.Parent = removeWhitelistFrame

local removeWhitelistButton = Instance.new("TextButton")
removeWhitelistButton.Size = UDim2.new(0.3, -5, 1, 0)
removeWhitelistButton.Position = UDim2.new(0.7, 5, 0, 0)
removeWhitelistButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
removeWhitelistButton.Text = "Удалить"
removeWhitelistButton.TextColor3 = Color3.fromRGB(220, 220, 220)
removeWhitelistButton.Font = Enum.Font.Gotham
removeWhitelistButton.TextSize = 14
removeWhitelistButton.Parent = removeWhitelistFrame

removeWhitelistButton.MouseButton1Click:Connect(function()
    local text = removeWhitelistBox.Text
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

-- Кнопка для очистки белого списка
local clearWhitelistButton = createButton(killerTab, "Очистить белый список", function()
    _G.whitelistedPlayers = {}
    updateWhitelistedPlayersLabel()
end)

-- Переключатель для убийства всех игроков
createToggle(killerTab, "Убивать всех (кроме белого списка)", false, function(bool)
    _G.autoKillAll = bool
    
    if bool then
        task.spawn(function()
            while _G.autoKillAll do
                pcall(function()
                    local players = game:GetService("Players"):GetPlayers()
                    
                    for _, player in ipairs(players) do
                        if player == game.Players.LocalPlayer or not _G.autoKillAll then
                            continue
                        end
                        
                        -- Проверка на белый список
                        local isWhitelisted = false
                        for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                            if whitelistedInfo:find(player.Name, 1, true) then
                                isWhitelisted = true
                                break
                            end
                        end
                        
                        -- Убийство если не в белом списке
                        if not isWhitelisted and player.Character and 
                           player.Character:FindFirstChild("HumanoidRootPart") and
                           player.Character:FindFirstChild("Humanoid") and
                           player.Character.Humanoid.Health > 0 then
                            
                            pcall(function()
                                killPlayer(player)
                            end)
                            
                            task.wait(0.05)
                        end
                    end
                end)
                
                task.wait(0.2)
            end
        end)
    end
end)

-- Текстовое поле для выбора цели
local setTargetFrame = Instance.new("Frame")
setTargetFrame.Size = UDim2.new(1, -10, 0, 30)
setTargetFrame.BackgroundTransparency = 1
setTargetFrame.Parent = killerTab

local setTargetBox = Instance.new("TextBox")
setTargetBox.Size = UDim2.new(0.7, 0, 1, 0)
setTargetBox.Position = UDim2.new(0, 0, 0, 0)
setTargetBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
setTargetBox.TextColor3 = Color3.fromRGB(220, 220, 220)
setTargetBox.Font = Enum.Font.Gotham
setTargetBox.TextSize = 14
setTargetBox.PlaceholderText = "Убивать кого: (ник)"
setTargetBox.Parent = setTargetFrame

local setTargetButton = Instance.new("TextButton")
setTargetButton.Size = UDim2.new(0.3, -5, 1, 0)
setTargetButton.Position = UDim2.new(0.7, 5, 0, 0)
setTargetButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
setTargetButton.Text = "Установить"
setTargetButton.TextColor3 = Color3.fromRGB(220, 220, 220)
setTargetButton.Font = Enum.Font.Gotham
setTargetButton.TextSize = 14
setTargetButton.Parent = setTargetFrame

setTargetButton.MouseButton1Click:Connect(function()
    local text = setTargetBox.Text
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end
    end
end)

-- Кнопка для очистки цели
local clearTargetButton = createButton(killerTab, "Очистить убийство", function()
    _G.targetPlayer = ""
    updateTargetPlayerLabel()
end)

-- Переключатель для убийства выбранной цели
createToggle(killerTab, "Убийство выбранного", false, function(bool)
    _G.autoKillTarget = bool
    
    if bool and _G.targetPlayer ~= "" then
        task.spawn(function()
            while _G.autoKillTarget and _G.targetPlayer ~= "" do
                pcall(function()
                    local targetName = _G.targetPlayer:match("^([^%(]+)")
                    if targetName then
                        targetName = targetName:gsub("%s+$", "")
                        local targetPlayer = game.Players:FindFirstChild(targetName)
                        if targetPlayer and targetPlayer.Character and 
                           targetPlayer.Character:FindFirstChild("HumanoidRootPart") and
                           targetPlayer.Character:FindFirstChild("Humanoid") and
                           targetPlayer.Character.Humanoid.Health > 0 then
                            
                            killPlayer(targetPlayer)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
end)

-- Кнопка для ручного убийства всех
createButton(killerTab, "Очистить всё (кроме белого списка)", function()
    pcall(function()
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local isWhitelisted = false
                for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                    if whitelistedInfo:find(player.Name, 1, true) then
                        isWhitelisted = true
                        break
                    end
                end
                
                if not isWhitelisted and player.Character and 
                   player.Character:FindFirstChild("HumanoidRootPart") then
                    killPlayer(player)
                    task.wait(0.05)
                end
            end
        end
    end)
end)

-- Кнопка для убийства выбранной цели
createButton(killerTab, "Удалить куклу для киллов", function()
    if _G.targetPlayer ~= "" then
        pcall(function()
            local targetName = _G.targetPlayer:match("^([^%(]+)")
            if targetName then
                targetName = targetName:gsub("%s+$", "")
                local targetPlayer = game.Players:FindFirstChild(targetName)
                if targetPlayer then
                    killPlayer(targetPlayer)
                end
            end
        end)
    end
end)

-- Инициализация UI
updateWhitelistedPlayersLabel()
updateTargetPlayerLabel()

-- Создаем вкладку "Телепорт"
local teleportTab = createTab("Телепорт")

-- Функция для телепортации
local function teleportTo(position, title, text)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = position
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 2
    })
end

-- Кнопки телепортации
createButton(teleportTab, "Спавн", function()
    teleportTo(CFrame.new(2, 8, 115), "Телепорт", "Прямиком на спавн")
end)

createButton(teleportTab, "Секретная арена", function()
    teleportTo(CFrame.new(1947, 2, 6191), "Тел

