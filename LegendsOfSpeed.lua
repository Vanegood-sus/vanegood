-- Vanegood Hub 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(220, 220, 220)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinimizeButton.Text = "—"
MinimizeButton.TextColor3 = Color3.fromRGB(220, 220, 220)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Панель вкладок
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.Parent = MainFrame

-- Вкладки (3 штуки)
local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(0.33, 0, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainTab.Text = "МЕНЮ"
MainTab.TextColor3 = Color3.fromRGB(220, 220, 220)
MainTab.Font = Enum.Font.GothamBold
MainTab.TextSize = 12
MainTab.Parent = TabBar

local PetsTab = Instance.new("TextButton")
PetsTab.Size = UDim2.new(0.33, 0, 1, 0)
PetsTab.Position = UDim2.new(0.33, 0, 0, 0)
PetsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
PetsTab.Text = "ПИТОМЦЫ"
PetsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
PetsTab.Font = Enum.Font.GothamBold
PetsTab.TextSize = 12
PetsTab.Parent = TabBar

local MiscTab = Instance.new("TextButton")
MiscTab.Size = UDim2.new(0.34, 0, 1, 0)
MiscTab.Position = UDim2.new(0.66, 0, 0, 0)
MiscTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MiscTab.Text = "ДОПОЛНИТЕЛЬНО"
MiscTab.TextColor3 = Color3.fromRGB(180, 180, 180)
MiscTab.Font = Enum.Font.GothamBold
MiscTab.TextSize = 12
MiscTab.Parent = TabBar

-- Индикатор вкладки
local ActiveTabIndicator = Instance.new("Frame")
ActiveTabIndicator.Size = UDim2.new(0.33, 0, 0, 2)
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
local MainFrameContent = Instance.new("ScrollingFrame")
MainFrameContent.Size = UDim2.new(1, 0, 1, 0)
MainFrameContent.Position = UDim2.new(0, 0, 0, 0)
MainFrameContent.BackgroundTransparency = 1
MainFrameContent.ScrollBarThickness = 3
MainFrameContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
MainFrameContent.Visible = true
MainFrameContent.Parent = ContentFrame

local PetsFrameContent = Instance.new("ScrollingFrame")
PetsFrameContent.Size = UDim2.new(1, 0, 1, 0)
PetsFrameContent.Position = UDim2.new(0, 0, 0, 0)
PetsFrameContent.BackgroundTransparency = 1
PetsFrameContent.ScrollBarThickness = 3
PetsFrameContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
PetsFrameContent.Visible = false
PetsFrameContent.Parent = ContentFrame

local MiscFrameContent = Instance.new("ScrollingFrame")
MiscFrameContent.Size = UDim2.new(1, 0, 1, 0)
MiscFrameContent.Position = UDim2.new(0, 0, 0, 0)
MiscFrameContent.BackgroundTransparency = 1
MiscFrameContent.ScrollBarThickness = 3
MiscFrameContent.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
MiscFrameContent.Visible = false
MiscFrameContent.Parent = ContentFrame

-- Функция переключения вкладок
local function switchTab(tab)
    MainTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    PetsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MiscTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    MainTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    PetsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    MiscTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    
    MainFrameContent.Visible = false
    PetsFrameContent.Visible = false
    MiscFrameContent.Visible = false
    
    if tab == "main" then
        MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        MainTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 0, 1, -2)}):Play()
        MainFrameContent.Visible = true
    elseif tab == "pets" then
        PetsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        PetsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.33, 0, 1, -2)}):Play()
        PetsFrameContent.Visible = true
    else
        MiscTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        MiscTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.66, 0, 1, -2)}):Play()
        MiscFrameContent.Visible = true
    end
end

-- Обработчики вкладок
MainTab.MouseButton1Click:Connect(function() switchTab("main") end)
PetsTab.MouseButton1Click:Connect(function() switchTab("pets") end)
MiscTab.MouseButton1Click:Connect(function() switchTab("misc") end)

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
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
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

-- Создаем элементы для вкладки Автофарм
local AutoFarmContainer = Instance.new("Frame")
AutoFarmContainer.Size = UDim2.new(1, 0, 0, 250)
AutoFarmContainer.BackgroundTransparency = 1
AutoFarmContainer.Parent = MainFrameContent

local AutoFarmTitle = Instance.new("TextLabel")
AutoFarmTitle.Size = UDim2.new(1, 0, 0, 30)
AutoFarmTitle.Text = ""
AutoFarmTitle.TextColor3 = Color3.fromRGB(255, 165, 50)
AutoFarmTitle.Font = Enum.Font.GothamBold
AutoFarmTitle.TextSize = 16
AutoFarmTitle.BackgroundTransparency = 1
AutoFarmTitle.TextXAlignment = Enum.TextXAlignment.Left
AutoFarmTitle.Parent = AutoFarmContainer

-- Авто шаги
local AutoStepsToggle = Instance.new("Frame")
AutoStepsToggle.Size = UDim2.new(1, 0, 0, 25)
AutoStepsToggle.BackgroundTransparency = 1
AutoStepsToggle.Parent = AutoFarmContainer

local AutoStepsLabel = Instance.new("TextLabel")
AutoStepsLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoStepsLabel.Text = "Авто шаги OP"
AutoStepsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoStepsLabel.Font = Enum.Font.Gotham
AutoStepsLabel.TextSize = 14
AutoStepsLabel.BackgroundTransparency = 1
AutoStepsLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoStepsLabel.Parent = AutoStepsToggle

local AutoStepsToggleFrame = Instance.new("Frame")
AutoStepsToggleFrame.Name = "ToggleFrame"
AutoStepsToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoStepsToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AutoStepsToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoStepsToggleFrame.Parent = AutoStepsToggle

local AutoStepsToggleCorner = Instance.new("UICorner")
AutoStepsToggleCorner.CornerRadius = UDim.new(1, 0)
AutoStepsToggleCorner.Parent = AutoStepsToggleFrame

local AutoStepsToggleButton = Instance.new("TextButton")
AutoStepsToggleButton.Name = "ToggleButton"
AutoStepsToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoStepsToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoStepsToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoStepsToggleButton.Text = ""
AutoStepsToggleButton.Parent = AutoStepsToggleFrame

local AutoStepsButtonCorner = Instance.new("UICorner")
AutoStepsButtonCorner.CornerRadius = UDim.new(1, 0)
AutoStepsButtonCorner.Parent = AutoStepsToggleButton

-- Авто сбор кристаллов
local AutoGemsToggle = Instance.new("Frame")
AutoGemsToggle.Size = UDim2.new(1, 0, 0, 25)
AutoGemsToggle.Position = UDim2.new(0, 0, 0, 30)
AutoGemsToggle.BackgroundTransparency = 1
AutoGemsToggle.Parent = AutoFarmContainer

local AutoGemsLabel = Instance.new("TextLabel")
AutoGemsLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoGemsLabel.Text = "Авто сбор кристаллов (вызывает задержки)"
AutoGemsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoGemsLabel.Font = Enum.Font.Gotham
AutoGemsLabel.TextSize = 14
AutoGemsLabel.BackgroundTransparency = 1
AutoGemsLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoGemsLabel.Parent = AutoGemsToggle

local AutoGemsToggleFrame = Instance.new("Frame")
AutoGemsToggleFrame.Name = "ToggleFrame"
AutoGemsToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoGemsToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AutoGemsToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoGemsToggleFrame.Parent = AutoGemsToggle

local AutoGemsToggleCorner = Instance.new("UICorner")
AutoGemsToggleCorner.CornerRadius = UDim.new(1, 0)
AutoGemsToggleCorner.Parent = AutoGemsToggleFrame

local AutoGemsToggleButton = Instance.new("TextButton")
AutoGemsToggleButton.Name = "ToggleButton"
AutoGemsToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoGemsToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoGemsToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoGemsToggleButton.Text = ""
AutoGemsToggleButton.Parent = AutoGemsToggleFrame

local AutoGemsButtonCorner = Instance.new("UICorner")
AutoGemsButtonCorner.CornerRadius = UDim.new(1, 0)
AutoGemsButtonCorner.Parent = AutoGemsToggleButton

-- Авто перерождение
local AutoRebirthToggle = Instance.new("Frame")
AutoRebirthToggle.Size = UDim2.new(1, 0, 0, 25)
AutoRebirthToggle.Position = UDim2.new(0, 0, 0, 60)
AutoRebirthToggle.BackgroundTransparency = 1
AutoRebirthToggle.Parent = AutoFarmContainer

local AutoRebirthLabel = Instance.new("TextLabel")
AutoRebirthLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoRebirthLabel.Text = "Авто перерождение"
AutoRebirthLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoRebirthLabel.Font = Enum.Font.Gotham
AutoRebirthLabel.TextSize = 14
AutoRebirthLabel.BackgroundTransparency = 1
AutoRebirthLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoRebirthLabel.Parent = AutoRebirthToggle

local AutoRebirthToggleFrame = Instance.new("Frame")
AutoRebirthToggleFrame.Name = "ToggleFrame"
AutoRebirthToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoRebirthToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AutoRebirthToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoRebirthToggleFrame.Parent = AutoRebirthToggle

local AutoRebirthToggleCorner = Instance.new("UICorner")
AutoRebirthToggleCorner.CornerRadius = UDim.new(1, 0)
AutoRebirthToggleCorner.Parent = AutoRebirthToggleFrame

local AutoRebirthToggleButton = Instance.new("TextButton")
AutoRebirthToggleButton.Name = "ToggleButton"
AutoRebirthToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoRebirthToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoRebirthToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoRebirthToggleButton.Text = ""
AutoRebirthToggleButton.Parent = AutoRebirthToggleFrame

local AutoRebirthButtonCorner = Instance.new("UICorner")
AutoRebirthButtonCorner.CornerRadius = UDim.new(1, 0)
AutoRebirthButtonCorner.Parent = AutoRebirthToggleButton

-- Жесткий фарм орбов
local HardOrbFarmToggle = Instance.new("Frame")
HardOrbFarmToggle.Size = UDim2.new(1, 0, 0, 25)
HardOrbFarmToggle.Position = UDim2.new(0, 0, 0, 90)
HardOrbFarmToggle.BackgroundTransparency = 1
HardOrbFarmToggle.Parent = AutoFarmContainer

local HardOrbFarmLabel = Instance.new("TextLabel")
HardOrbFarmLabel.Size = UDim2.new(0.7, 0, 1, 0)
HardOrbFarmLabel.Text = "Жесткий фарм орбов (вызывает задержку)"
HardOrbFarmLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
HardOrbFarmLabel.Font = Enum.Font.Gotham
HardOrbFarmLabel.TextSize = 14
HardOrbFarmLabel.BackgroundTransparency = 1
HardOrbFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
HardOrbFarmLabel.Parent = HardOrbFarmToggle

local HardOrbFarmToggleFrame = Instance.new("Frame")
HardOrbFarmToggleFrame.Name = "ToggleFrame"
HardOrbFarmToggleFrame.Size = UDim2.new(0, 50, 0, 25)
HardOrbFarmToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
HardOrbFarmToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HardOrbFarmToggleFrame.Parent = HardOrbFarmToggle

local HardOrbFarmToggleCorner = Instance.new("UICorner")
HardOrbFarmToggleCorner.CornerRadius = UDim.new(1, 0)
HardOrbFarmToggleCorner.Parent = HardOrbFarmToggleFrame

local HardOrbFarmToggleButton = Instance.new("TextButton")
HardOrbFarmToggleButton.Name = "ToggleButton"
HardOrbFarmToggleButton.Size = UDim2.new(0, 21, 0, 21)
HardOrbFarmToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
HardOrbFarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
HardOrbFarmToggleButton.Text = ""
HardOrbFarmToggleButton.Parent = HardOrbFarmToggleFrame

local HardOrbFarmButtonCorner = Instance.new("UICorner")
HardOrbFarmButtonCorner.CornerRadius = UDim.new(1, 0)
HardOrbFarmButtonCorner.Parent = HardOrbFarmToggleButton

-- Кнопка сбора сундуков
local CollectChestsButton = Instance.new("TextButton")
CollectChestsButton.Size = UDim2.new(1, 0, 0, 30)
CollectChestsButton.Position = UDim2.new(0, 0, 0, 200)
CollectChestsButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
CollectChestsButton.Text = "Собрать сундуки"
CollectChestsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectChestsButton.Font = Enum.Font.GothamBold
CollectChestsButton.TextSize = 14
CollectChestsButton.Parent = AutoFarmContainer

local CollectChestsCorner = Instance.new("UICorner")
CollectChestsCorner.CornerRadius = UDim.new(0, 6)
CollectChestsCorner.Parent = CollectChestsButton

-- Логика автофарма
local AutoStepsEnabled = false
local AutoGemsEnabled = false
local AutoRebirthEnabled = false
local HardOrbFarmEnabled = false
local orbThreads = {}

local function collectOrb(orbType)
    local args = {
        [1] = "collectOrb",
        [2] = orbType,
        [3] = "City"
    }

    while HardOrbFarmEnabled and task.wait() do
        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
    end
end

local function startOrbFarm()
    -- Останавливаем предыдущие потоки
    for _, thread in ipairs(orbThreads) do
        coroutine.close(thread)
    end
    orbThreads = {}

    if HardOrbFarmEnabled then
        -- Запускаем новые потоки
        for i = 1, 50 do -- Увеличиваем количество потоков для жесткого фарма
            table.insert(orbThreads, coroutine.create(function() collectOrb("Red Orb") end))
            table.insert(orbThreads, coroutine.create(function() collectOrb("Gem") end))
        end

        -- Запускаем все потоки
        for _, thread in ipairs(orbThreads) do
            coroutine.resume(thread)
        end
    end
end

local function ToggleAutoSteps()
    AutoStepsEnabled = not AutoStepsEnabled
    if AutoStepsEnabled then
        TweenService:Create(AutoStepsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoStepsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while AutoStepsEnabled and wait() do
                pcall(function()
                    for i = 1,20 do
                        local args = {[1] = "collectOrb", [2] = "Red Orb", [3] = "City"}
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                        local args = {[1] = "collectOrb", [2] = "Blue Orb", [3] = "City"}
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    end
                end)
            end
        end)
    else
        TweenService:Create(AutoStepsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoStepsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local function ToggleAutoGems()
    AutoGemsEnabled = not AutoGemsEnabled
    if AutoGemsEnabled then
        TweenService:Create(AutoGemsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoGemsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while AutoGemsEnabled and task.wait() do
                pcall(function()
                    for i = 1,10 do
                        local args = {[1] = "collectOrb", [2] = "Gem", [3] = "City"}
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                        local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Desert"}
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                        local args = {[1] = "collectOrb", [2] = "Gem", [3] = "Magma City"}
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer(unpack(args))
                    end
                end)
            end
        end)
    else
        TweenService:Create(AutoGemsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(AutoGemsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local function ToggleAutoRebirth()
    AutoRebirthEnabled = not AutoRebirthEnabled
    if AutoRebirthEnabled then
        TweenService:Create(AutoRebirthToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoRebirthToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while AutoRebirthEnabled and wait() do
                pcall(function()
                    local args = {[1] = "rebirthRequest"}
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
                    local args = {[1] = "rebirthRequest"}
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer(unpack(args))
                end)
            end
        end)
    else
        TweenService:Create(AutoRebirthToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(AutoRebirthToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local function ToggleHardOrbFarm()
    HardOrbFarmEnabled = not HardOrbFarmEnabled
    if HardOrbFarmEnabled then
        TweenService:Create(HardOrbFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(HardOrbFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        startOrbFarm()
    else
        TweenService:Create(HardOrbFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(HardOrbFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local HoopsFarmToggle = Instance.new("Frame")
HoopsFarmToggle.Size = UDim2.new(1, 0, 0, 25)
HoopsFarmToggle.Position = UDim2.new(0, 0, 0, 120) -- Сдвигаем вниз
HoopsFarmToggle.BackgroundTransparency = 1
HoopsFarmToggle.Parent = AutoFarmContainer

local HoopsFarmLabel = Instance.new("TextLabel")
HoopsFarmLabel.Size = UDim2.new(0.7, 0, 1, 0)
HoopsFarmLabel.Text = "Фарм колец (обычный)"
HoopsFarmLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
HoopsFarmLabel.Font = Enum.Font.Gotham
HoopsFarmLabel.TextSize = 14
HoopsFarmLabel.BackgroundTransparency = 1
HoopsFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
HoopsFarmLabel.Parent = HoopsFarmToggle

local HoopsFarmToggleFrame = Instance.new("Frame")
HoopsFarmToggleFrame.Name = "ToggleFrame"
HoopsFarmToggleFrame.Size = UDim2.new(0, 50, 0, 25)
HoopsFarmToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
HoopsFarmToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
HoopsFarmToggleFrame.Parent = HoopsFarmToggle

local HoopsFarmToggleCorner = Instance.new("UICorner")
HoopsFarmToggleCorner.CornerRadius = UDim.new(1, 0)
HoopsFarmToggleCorner.Parent = HoopsFarmToggleFrame

local HoopsFarmToggleButton = Instance.new("TextButton")
HoopsFarmToggleButton.Name = "ToggleButton"
HoopsFarmToggleButton.Size = UDim2.new(0, 21, 0, 21)
HoopsFarmToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
HoopsFarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
HoopsFarmToggleButton.Text = ""
HoopsFarmToggleButton.Parent = HoopsFarmToggleFrame

local HoopsFarmButtonCorner = Instance.new("UICorner")
HoopsFarmButtonCorner.CornerRadius = UDim.new(1, 0)
HoopsFarmButtonCorner.Parent = HoopsFarmToggleButton

-- Логика Hoops Farm
local HoopsFarmEnabled = false

local function ToggleHoopsFarm()
    HoopsFarmEnabled = not HoopsFarmEnabled
    if HoopsFarmEnabled then
        TweenService:Create(HoopsFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(HoopsFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while HoopsFarmEnabled and task.wait() do
                pcall(function()
                    for _, hoop in pairs(game:GetService("Workspace").Hoops:GetChildren()) do
                        hoop.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end)
            end
        end)
    else
        TweenService:Create(HoopsFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(HoopsFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

AutoStepsToggleButton.MouseButton1Click:Connect(ToggleAutoSteps)
AutoGemsToggleButton.MouseButton1Click:Connect(ToggleAutoGems)
AutoRebirthToggleButton.MouseButton1Click:Connect(ToggleAutoRebirth)
HardOrbFarmToggleButton.MouseButton1Click:Connect(ToggleHardOrbFarm)
HoopsFarmToggleButton.MouseButton1Click:Connect(ToggleHoopsFarm)

CollectChestsButton.MouseButton1Click:Connect(function()
    local args = {[1] = "groupRewards"}
    game:GetService("ReplicatedStorage").rEvents.groupRemote:InvokeServer(unpack(args))

    local args = {[1] = "Enchanted Chest"}
    game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(unpack(args))
    wait()
    local args = {[1] = workspace.rewardChests.rewardChest}
    game:GetService("ReplicatedStorage").rEvents.collectCourseChestRemote:InvokeServer(unpack(args))
end)

-- Создаем элементы для вкладки Питомцы
-- Создаем элементы для вкладки Питомцы
local PetsContainer = Instance.new("Frame")
PetsContainer.Size = UDim2.new(1, 0, 0, 200)
PetsContainer.BackgroundTransparency = 1
PetsContainer.Parent = PetsFrameContent

local PetsTitle = Instance.new("TextLabel")
PetsTitle.Size = UDim2.new(1, 0, 0, 30)
PetsTitle.Text = "АВТОПОКУПКА ПИТОМЦЕВ"
PetsTitle.TextColor3 = Color3.fromRGB(255, 165, 50)
PetsTitle.Font = Enum.Font.GothamBold
PetsTitle.TextSize = 16
PetsTitle.BackgroundTransparency = 1
PetsTitle.TextXAlignment = Enum.TextXAlignment.Left
PetsTitle.Parent = PetsContainer

-- Список питомцев
local petsList = {
    "Golden Viking", 
    "Speedy Sensei", 
    "Swift Samurai", 
    "Soul Fusion Dog",
    "Hupersonic Pegasus", 
    "Dark Birdie", 
    "Eternal Nebula Dragon", 
    "Shadows Edge Kitty",
    "Utimate Overdrive Bunny"
}

local selectedPet = petsList[1]
local TweenService = game:GetService("TweenService")

-- Создаем выпадающее меню
local DropdownFrame = Instance.new("Frame")
DropdownFrame.Name = "PetDropdown"
DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
DropdownFrame.Position = UDim2.new(0, 0, 0, 40)
DropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
DropdownFrame.Parent = PetsContainer

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = DropdownFrame

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(1, 0, 1, 0)
DropdownButton.BackgroundTransparency = 1
DropdownButton.Text = selectedPet
DropdownButton.TextColor3 = Color3.fromRGB(220, 220, 220)
DropdownButton.Font = Enum.Font.Gotham
DropdownButton.TextSize = 14
DropdownButton.Parent = DropdownFrame

local DropdownIcon = Instance.new("ImageLabel")
DropdownIcon.Name = "Icon"
DropdownIcon.Size = UDim2.new(0, 20, 0, 20)
DropdownIcon.Position = UDim2.new(1, -25, 0.5, -10)
DropdownIcon.BackgroundTransparency = 1
DropdownIcon.Image = "rbxassetid://3926305904"
DropdownIcon.ImageRectOffset = Vector2.new(364, 364)
DropdownIcon.ImageRectSize = Vector2.new(36, 36)
DropdownIcon.Parent = DropdownButton

local DropdownList = Instance.new("ScrollingFrame")
DropdownList.Name = "DropdownList"
DropdownList.Size = UDim2.new(1, 0, 0, 150) -- Фиксированная высота для списка
DropdownList.Position = UDim2.new(0, 0, 1, 5) -- Позиция под кнопкой
DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
DropdownList.ScrollBarThickness = 5
DropdownList.Visible = false
DropdownList.BorderSizePixel = 0
DropdownList.CanvasSize = UDim2.new(0, 0, 0, #petsList * 32)
DropdownList.Parent = DropdownFrame

local DropdownListLayout = Instance.new("UIListLayout")
DropdownListLayout.Padding = UDim.new(0, 2)
DropdownListLayout.Parent = DropdownList

local DropdownListCorner = Instance.new("UICorner")
DropdownListCorner.CornerRadius = UDim.new(0, 6)
DropdownListCorner.Parent = DropdownList

-- Создаем элементы списка
for _, petName in ipairs(petsList) do
    local OptionButton = Instance.new("TextButton")
    OptionButton.Name = petName
    OptionButton.Size = UDim2.new(1, -10, 0, 30)
    OptionButton.Position = UDim2.new(0, 5, 0, 0)
    OptionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    OptionButton.Text = petName
    OptionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    OptionButton.Font = Enum.Font.Gotham
    OptionButton.TextSize = 14
    OptionButton.Parent = DropdownList
    
    local OptionCorner = Instance.new("UICorner")
    OptionCorner.CornerRadius = UDim.new(0, 4)
    OptionCorner.Parent = OptionButton
    
    OptionButton.MouseButton1Click:Connect(function()
        selectedPet = petName
        DropdownButton.Text = petName
        DropdownList.Visible = false
        TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
    end)
end

-- Функционал открытия/закрытия выпадающего списка
local isDropdownOpen = false

DropdownButton.MouseButton1Click:Connect(function()
    isDropdownOpen = not isDropdownOpen
    DropdownList.Visible = isDropdownOpen
    
    if isDropdownOpen then
        TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {Rotation = 180}):Play()
    else
        TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
    end
end)

-- Закрытие выпадающего списка при клике вне его
local UserInputService = game:GetService("UserInputService")

local function isPointInFrame(frame, point)
    local framePos = frame.AbsolutePosition
    local frameSize = frame.AbsoluteSize
    return point.X >= framePos.X and point.X <= framePos.X + frameSize.X and
           point.Y >= framePos.Y and point.Y <= framePos.Y + frameSize.Y
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    
    local mousePos = input.Position
    local isOverDropdown = isPointInFrame(DropdownFrame, mousePos)
    local isOverList = DropdownList.Visible and isPointInFrame(DropdownList, mousePos)
    
    if not isOverDropdown and not isOverList then
        isDropdownOpen = false
        DropdownList.Visible = false
        TweenService:Create(DropdownIcon, TweenInfo.new(0.2), {Rotation = 0}):Play()
    end
end)

-- Тумблер автопокупки
local PetFarmToggle = Instance.new("Frame")
PetFarmToggle.Size = UDim2.new(1, 0, 0, 25)
PetFarmToggle.Position = UDim2.new(0, 0, 0, 100)
PetFarmToggle.BackgroundTransparency = 1
PetFarmToggle.Parent = PetsContainer

local PetFarmLabel = Instance.new("TextLabel")
PetFarmLabel.Size = UDim2.new(0.7, 0, 1, 0)
PetFarmLabel.Text = "Автопокупка"
PetFarmLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
PetFarmLabel.Font = Enum.Font.Gotham
PetFarmLabel.TextSize = 14
PetFarmLabel.BackgroundTransparency = 1
PetFarmLabel.TextXAlignment = Enum.TextXAlignment.Left
PetFarmLabel.Parent = PetFarmToggle

local PetFarmToggleFrame = Instance.new("Frame")
PetFarmToggleFrame.Name = "ToggleFrame"
PetFarmToggleFrame.Size = UDim2.new(0, 50, 0, 25)
PetFarmToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
PetFarmToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
PetFarmToggleFrame.Parent = PetFarmToggle

local PetFarmToggleCorner = Instance.new("UICorner")
PetFarmToggleCorner.CornerRadius = UDim.new(1, 0)
PetFarmToggleCorner.Parent = PetFarmToggleFrame

local PetFarmToggleButton = Instance.new("TextButton")
PetFarmToggleButton.Name = "ToggleButton"
PetFarmToggleButton.Size = UDim2.new(0, 21, 0, 21)
PetFarmToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
PetFarmToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
PetFarmToggleButton.Text = ""
PetFarmToggleButton.Parent = PetFarmToggleFrame

local PetFarmButtonCorner = Instance.new("UICorner")
PetFarmButtonCorner.CornerRadius = UDim.new(1, 0)
PetFarmButtonCorner.Parent = PetFarmToggleButton

-- Логика автопокупки питомцев
local PetFarmEnabled = false

local function TogglePetFarm()
    PetFarmEnabled = not PetFarmEnabled
    if PetFarmEnabled then
        TweenService:Create(PetFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(PetFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while PetFarmEnabled and task.wait(0.5) do
                pcall(function()
                    local cPetShopFolder = ReplicatedStorage:WaitForChild("cPetShopFolder")
                    local cPetShopRemote = ReplicatedStorage:WaitForChild("cPetShopRemote")
                    
                    local petToOpen = cPetShopFolder:FindFirstChild(selectedPet)
                    if petToOpen then
                        cPetShopRemote:InvokeServer(petToOpen)
                    end
                end)
            end
        end)
    else
        TweenService:Create(PetFarmToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(PetFarmToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

PetFarmToggleButton.MouseButton1Click:Connect(TogglePetFarm)

-- Создаем элементы для вкладки Дополнительно
local MiscContainer = Instance.new("Frame")
MiscContainer.Size = UDim2.new(1, 0, 0, 150)
MiscContainer.BackgroundTransparency = 1
MiscContainer.Parent = MiscFrameContent

local MiscTitle = Instance.new("TextLabel")
MiscTitle.Size = UDim2.new(1, 0, 0, 30)
MiscTitle.Text = ""
MiscTitle.TextColor3 = Color3.fromRGB(255, 165, 50)
MiscTitle.Font = Enum.Font.GothamBold
MiscTitle.TextSize = 16
MiscTitle.BackgroundTransparency = 1
MiscTitle.TextXAlignment = Enum.TextXAlignment.Left
MiscTitle.Parent = MiscContainer

-- Авто колесо удачи
local AutoWheelToggle = Instance.new("Frame")
AutoWheelToggle.Size = UDim2.new(1, 0, 0, 25)
AutoWheelToggle.BackgroundTransparency = 1
AutoWheelToggle.Parent = MiscContainer

local AutoWheelLabel = Instance.new("TextLabel")
AutoWheelLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoWheelLabel.Text = "Авто колесо удачи"
AutoWheelLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoWheelLabel.Font = Enum.Font.Gotham
AutoWheelLabel.TextSize = 14
AutoWheelLabel.BackgroundTransparency = 1
AutoWheelLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoWheelLabel.Parent = AutoWheelToggle

local AutoWheelToggleFrame = Instance.new("Frame")
AutoWheelToggleFrame.Name = "ToggleFrame"
AutoWheelToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoWheelToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AutoWheelToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoWheelToggleFrame.Parent = AutoWheelToggle

local AutoWheelToggleCorner = Instance.new("UICorner")
AutoWheelToggleCorner.CornerRadius = UDim.new(1, 0)
AutoWheelToggleCorner.Parent = AutoWheelToggleFrame

local AutoWheelToggleButton = Instance.new("TextButton")
AutoWheelToggleButton.Name = "ToggleButton"
AutoWheelToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoWheelToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoWheelToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoWheelToggleButton.Text = ""
AutoWheelToggleButton.Parent = AutoWheelToggleFrame

local AutoWheelButtonCorner = Instance.new("UICorner")
AutoWheelButtonCorner.CornerRadius = UDim.new(1, 0)
AutoWheelButtonCorner.Parent = AutoWheelToggleButton

-- Авто сбор подарков
local AutoGiftsToggle = Instance.new("Frame")
AutoGiftsToggle.Size = UDim2.new(1, 0, 0, 25)
AutoGiftsToggle.Position = UDim2.new(0, 0, 0, 30)
AutoGiftsToggle.BackgroundTransparency = 1
AutoGiftsToggle.Parent = MiscContainer

local AutoGiftsLabel = Instance.new("TextLabel")
AutoGiftsLabel.Size = UDim2.new(0.7, 0, 1, 0)
AutoGiftsLabel.Text = "Авто сбор подарков"
AutoGiftsLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
AutoGiftsLabel.Font = Enum.Font.Gotham
AutoGiftsLabel.TextSize = 14
AutoGiftsLabel.BackgroundTransparency = 1
AutoGiftsLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoGiftsLabel.Parent = AutoGiftsToggle

local AutoGiftsToggleFrame = Instance.new("Frame")
AutoGiftsToggleFrame.Name = "ToggleFrame"
AutoGiftsToggleFrame.Size = UDim2.new(0, 50, 0, 25)
AutoGiftsToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
AutoGiftsToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoGiftsToggleFrame.Parent = AutoGiftsToggle

local AutoGiftsToggleCorner = Instance.new("UICorner")
AutoGiftsToggleCorner.CornerRadius = UDim.new(1, 0)
AutoGiftsToggleCorner.Parent = AutoGiftsToggleFrame

local AutoGiftsToggleButton = Instance.new("TextButton")
AutoGiftsToggleButton.Name = "ToggleButton"
AutoGiftsToggleButton.Size = UDim2.new(0, 21, 0, 21)
AutoGiftsToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
AutoGiftsToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
AutoGiftsToggleButton.Text = ""
AutoGiftsToggleButton.Parent = AutoGiftsToggleFrame

local AutoGiftsButtonCorner = Instance.new("UICorner")
AutoGiftsButtonCorner.CornerRadius = UDim.new(1, 0)
AutoGiftsButtonCorner.Parent = AutoGiftsToggleButton

-- Кнопка активации кодов
local RedeemCodesButton = Instance.new("TextButton")
RedeemCodesButton.Size = UDim2.new(1, 0, 0, 30)
RedeemCodesButton.Position = UDim2.new(0, 0, 0, 70)
RedeemCodesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50)
RedeemCodesButton.Text = "Активировать все коды"
RedeemCodesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RedeemCodesButton.Font = Enum.Font.GothamBold
RedeemCodesButton.TextSize = 14
RedeemCodesButton.Parent = MiscContainer

local RedeemCodesCorner = Instance.new("UICorner")
RedeemCodesCorner.CornerRadius = UDim.new(0, 6)
RedeemCodesCorner.Parent = RedeemCodesButton

-- Логика дополнительных функций
local AutoWheelEnabled = false
local AutoGiftsEnabled = false

local function ToggleAutoWheel()
    AutoWheelEnabled = not AutoWheelEnabled
    if AutoWheelEnabled then
        TweenService:Create(AutoWheelToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoWheelToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while AutoWheelEnabled and wait(1) do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
            end
        end)
    else
        TweenService:Create(AutoWheelToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(AutoWheelToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local function ToggleAutoGifts()
    AutoGiftsEnabled = not AutoGiftsEnabled
    if AutoGiftsEnabled then
        TweenService:Create(AutoGiftsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 165, 50)}):Play()
        TweenService:Create(AutoGiftsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 90)}):Play()
        
        spawn(function()
            while AutoGiftsEnabled and wait(1) do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
            end
        end)
    else
        TweenService:Create(AutoGiftsToggleButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(220, 220, 220)}):Play()
        TweenService:Create(AutoGiftsToggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)}):Play()
    end
end

local function RedeemAllCodes()
    local codes = {
        "swiftjungle1000", -- 1000 алмазов
        "speedchampion000", -- 5000 алмазов
        "racer300", -- 300 шагов
        "SPRINT250", -- 250 шагов
        "hyper250", -- 250 шагов
        "legends500", -- 500 шагов
        "sparkles300", -- 300 шагов
        "Launch200" -- 200 шагов
    }
    
    local remote = ReplicatedStorage:FindFirstChild("rEvents") and ReplicatedStorage.rEvents:FindFirstChild("redeemCodeRemote")
    
    if remote then
        for _, code in ipairs(codes) do
            remote:InvokeServer("redeemCode", code)
            wait(0.5) -- Небольшая задержка между кодами
        end
    else
        warn("Не удалось найти remote для активации кодов!")
    end
end

AutoWheelToggleButton.MouseButton1Click:Connect(ToggleAutoWheel)
AutoGiftsToggleButton.MouseButton1Click:Connect(ToggleAutoGifts)
RedeemCodesButton.MouseButton1Click:Connect(RedeemAllCodes)

-- Инициализация
switchTab("main")

-- Анти-афк
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
