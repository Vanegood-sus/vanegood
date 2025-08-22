-- Vanegood Hub 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

-- Удаляем старый хаб если есть
if CoreGui:FindFirstChild("VanegoodHub") then
    CoreGui.VanegoodHub:Destroy()
end
if CoreGui:FindFirstChild("TinyDraggableImage") then
    CoreGui.TinyDraggableImage:Destroy()
end

-- Создаем основной ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Создаем кнопку с изображением (draggable)
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
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
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

-- Панель вкладок
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 30)
TabBar.Position = UDim2.new(0, 0, 0, 30)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabBar.Parent = MainFrame

-- Вкладки (3 штуки)
local ScriptsTab = Instance.new("TextButton")
ScriptsTab.Size = UDim2.new(0.33, 0, 1, 0)
ScriptsTab.Position = UDim2.new(0, 0, 0, 0)
ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ScriptsTab.Text = "СКРИПТЫ"
ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
ScriptsTab.Font = Enum.Font.GothamBold
ScriptsTab.TextSize = 12
ScriptsTab.Parent = TabBar

local GamesTab = Instance.new("TextButton")
GamesTab.Size = UDim2.new(0.33, 0, 1, 0)
GamesTab.Position = UDim2.new(0.33, 0, 0, 0)
GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
GamesTab.Text = "ИГРЫ"
GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
GamesTab.Font = Enum.Font.GothamBold
GamesTab.TextSize = 12
GamesTab.Parent = TabBar

local TrollTab = Instance.new("TextButton")
TrollTab.Size = UDim2.new(0.34, 0, 1, 0)
TrollTab.Position = UDim2.new(0.66, 0, 0, 0)
TrollTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TrollTab.Text = "ТРОЛЛИНГ"
TrollTab.TextColor3 = Color3.fromRGB(180, 180, 180)
TrollTab.Font = Enum.Font.GothamBold
TrollTab.TextSize = 12
TrollTab.Parent = TabBar

-- Индикатор вкладки (оранжевый)
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

-- Скроллинг фреймы для вкладок
local ScriptsFrame = Instance.new("ScrollingFrame")
ScriptsFrame.Size = UDim2.new(1, 0, 1, 0)
ScriptsFrame.Position = UDim2.new(0, 0, 0, 0)
ScriptsFrame.BackgroundTransparency = 1
ScriptsFrame.ScrollBarThickness = 3
ScriptsFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)  -- оранжевый
ScriptsFrame.Visible = true
ScriptsFrame.CanvasSize = UDim2.new(0,0,2,0)
ScriptsFrame.Parent = ContentFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 10)
ListLayout.Parent = ScriptsFrame

local function updateCanvasSize()
    ScriptsFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
end
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

-- Function for dances
local danceTrack = nil
local lastDanceId = nil

-- R15 check function
local function r15(player)
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        return humanoid and humanoid.RigType == Enum.HumanoidRigType.R15
    end
    return false
end

local function createDanceToggle(container)
    -- Dance container
    local DanceContainer = Instance.new("Frame")
    DanceContainer.Name = "DanceContainer"
    DanceContainer.Size = UDim2.new(1, 0, 0, 60)  -- Increase height for dropdown
    DanceContainer.Position = UDim2.new(0, 10, 0, 660)
    DanceContainer.BackgroundTransparency = 1
    DanceContainer.Parent = container

    local DanceLabel = Instance.new("TextLabel")
    DanceLabel.Size = UDim2.new(0, 200, 0, 30)
    DanceLabel.Position = UDim2.new(0, 0, 0, 0)
    DanceLabel.BackgroundTransparency = 1
    DanceLabel.Text = "Dances"
    DanceLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    DanceLabel.Font = Enum.Font.Gotham
    DanceLabel.TextSize = 14
    DanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    DanceLabel.Parent = DanceContainer

    -- Dropdown with dances
    local DanceDropdown = Instance.new("Frame")
    DanceDropdown.Name = "DanceDropdown"
    DanceDropdown.Size = UDim2.new(0.7, 0, 0, 30)
    DanceDropdown.Position = UDim2.new(0, 0, 0, 30)
    DanceDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    DanceDropdown.Parent = DanceContainer

    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 4)
    DropdownCorner.Parent = DanceDropdown

    local DropdownText = Instance.new("TextLabel")
    DropdownText.Size = UDim2.new(0.8, 0, 1, 0)
    DropdownText.Position = UDim2.new(0, 10, 0, 0)
    DropdownText.BackgroundTransparency = 1
    DropdownText.Text = "Select a dance..."
    DropdownText.TextColor3 = Color3.fromRGB(180, 180, 180)
    DropdownText.Font = Enum.Font.Gotham
    DropdownText.TextSize = 12
    DropdownText.TextXAlignment = Enum.TextXAlignment.Left
    DropdownText.Parent = DanceDropdown

    local DropdownArrow = Instance.new("TextLabel")
    DropdownArrow.Size = UDim2.new(0, 20, 1, 0)
    DropdownArrow.Position = UDim2.new(1, -25, 0, 0)
    DropdownArrow.BackgroundTransparency = 1
    DropdownArrow.Text = "▼"
    DropdownArrow.TextColor3 = Color3.fromRGB(180, 180, 180)
    DropdownArrow.Font = Enum.Font.Gotham
    DropdownArrow.TextSize = 12
    DropdownArrow.Parent = DanceDropdown

    -- Dance list with names
    local danceList = {
        -- R6 dances
        {id = "27789359", name = "Electro Dance"},
        {id = "30196114", name = "Hip-Hop"},
        {id = "248263260", name = "Wave"},
        {id = "45834924", name = "Gangnam Style"},
        {id = "33796059", name = "Robot"},
        {id = "28488254", name = "Skeleton Dance"},
        {id = "52155728", name = "Popping"},
        {id = "5915775283", name = "Flick"},
        {id = "5915719367", name = "Dab"},
        {id = "5915730333", name = "High Kick"},
        
        -- R15 dances
        {id = "3333432454", name = "R15 Hip-Hop"},
        {id = "4555808220", name = "R15 Electro"},
        {id = "4049037604", name = "R15 Wave"},
        {id = "4555782893", name = "R15 Popping"},
        {id = "10214311282", name = "R15 Gangnam"},
        {id = "10714010337", name = "R15 Robot"},
        {id = "10713981723", name = "R15 Dance 1"},
        {id = "10714372526", name = "R15 Dance 2"},
        {id = "10714076981", name = "R15 Dance 3"},
        {id = "10714392151", name = "R15 Dance 4"},
        {id = "11444443576", name = "R15 Dance 5"},
        {id = "12675393304", name = "R15 Dance 6"},
        {id = "12675409517", name = "R15 Dance 7"},
        {id = "12675424061", name = "R15 Dance 8"},
        {id = "12675443341", name = "R15 Dance 9"},
        {id = "12675460038", name = "R15 Dance 10"}
    }

    -- Dance toggle switch
    local DanceToggleFrame = Instance.new("Frame")
    DanceToggleFrame.Name = "ToggleFrame"
    DanceToggleFrame.Size = UDim2.new(0, 50, 0, 25)
    DanceToggleFrame.Position = UDim2.new(1, -60, 0, 5)
    DanceToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    DanceToggleFrame.Parent = DanceContainer

    local DanceToggleCorner = Instance.new("UICorner")
    DanceToggleCorner.CornerRadius = UDim.new(1, 0)
    DanceToggleCorner.Parent = DanceToggleFrame

    local DanceToggleButton = Instance.new("TextButton")
    DanceToggleButton.Name = "ToggleButton"
    DanceToggleButton.Size = UDim2.new(0, 21, 0, 21)
    DanceToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    DanceToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    DanceToggleButton.Text = ""
    DanceToggleButton.Parent = DanceToggleFrame

    local DanceButtonCorner = Instance.new("UICorner")
    DanceButtonCorner.CornerRadius = UDim.new(1, 0)
    DanceButtonCorner.Parent = DanceToggleButton

    -- Toggle state
    local danceEnabled = false
    local selectedDance = nil

    -- Dropdown open/close function
    local dropdownOpen = false
    local dropdownFrame = nil

    local function toggleDropdown()
        dropdownOpen = not dropdownOpen
        
        if dropdownOpen then
            -- Create dropdown list
            dropdownFrame = Instance.new("ScrollingFrame")
            dropdownFrame.Size = UDim2.new(0.7, 0, 0, 150)
            dropdownFrame.Position = UDim2.new(0, 0, 0, 60)
            dropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.ScrollBarThickness = 3
            dropdownFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 165, 50)
            dropdownFrame.CanvasSize = UDim2.new(0, 0, 0, #danceList * 30)
            dropdownFrame.Parent = DanceContainer
            
            local listLayout = Instance.new("UIListLayout")
            listLayout.Parent = dropdownFrame
            
            for i, dance in ipairs(danceList) do
                local danceButton = Instance.new("TextButton")
                danceButton.Size = UDim2.new(1, 0, 0, 30)
                danceButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                danceButton.Text = dance.name
                danceButton.TextColor3 = Color3.fromRGB(220, 220, 220)
                danceButton.Font = Enum.Font.Gotham
                danceButton.TextSize = 12
                danceButton.Parent = dropdownFrame
                
                danceButton.MouseButton1Click:Connect(function()
                    selectedDance = dance.id
                    DropdownText.Text = dance.name
                    DropdownText.TextColor3 = Color3.fromRGB(255, 165, 50)
                    dropdownFrame:Destroy()
                    dropdownOpen = false
                    
                    -- If dances enabled, switch to selected
                    if danceEnabled then
                        startDance()
                    end
                end)
            end
            
            DropdownArrow.Text = "▲"
        else
            if dropdownFrame then
                dropdownFrame:Destroy()
                dropdownFrame = nil
            end
            DropdownArrow.Text = "▼"
        end
    end

    DanceDropdown.MouseButton1Click:Connect(toggleDropdown)

    -- Function to get random dance
    local function getRandomDance()
        if selectedDance then
            return selectedDance
        end
        
        local availableDances = {}
        for _, dance in ipairs(danceList) do
            if dance.id ~= lastDanceId then
                table.insert(availableDances, dance.id)
            end
        end
        
        if #availableDances == 0 then
            for _, dance in ipairs(danceList) do
                table.insert(availableDances, dance.id)
            end
        end
        
        local randomIndex = math.random(1, #availableDances)
        lastDanceId = availableDances[randomIndex]
        return lastDanceId
    end

    -- Function to start dance
    local function startDance()
        if danceTrack then
            pcall(function() danceTrack:Stop() end)
            pcall(function() danceTrack:Destroy() end)
        end

        local speaker = Players.LocalPlayer
        if speaker and speaker.Character then
            local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://" .. getRandomDance()
                danceTrack = humanoid:LoadAnimation(animation)
                danceTrack.Looped = true
                danceTrack:Play()
            end
        end
    end

    -- Function to stop dance
    local function stopDance()
        if danceTrack then
            danceTrack:Stop()
            danceTrack:Destroy()
            danceTrack = nil
        end
    end

    -- Toggle switch handler
    DanceToggleButton.MouseButton1Click:Connect(function()
        danceEnabled = not danceEnabled
        
        if danceEnabled then
            TweenService:Create(DanceToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -23, 0.5, -10)
            }):Play()
            TweenService:Create(DanceToggleFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 165, 50)
            }):Play()
            startDance()
        else
            TweenService:Create(DanceToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -10)
            }):Play()
            TweenService:Create(DanceToggleFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            }):Play()
            stopDance()
        end
    end)

    -- Auto disable on character removal
    Players.LocalPlayer.CharacterRemoving:Connect(function()
        if danceEnabled then
            danceEnabled = false
            TweenService:Create(DanceToggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -10)
            }):Play()
            TweenService:Create(DanceToggleFrame, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            }):Play()
            stopDance()
        end
    end)

    return DanceContainer
end

-- Adding to menu (in scripts section)
local danceToggle = createDanceToggle(ScriptsFrame)


-- Создаем фреймы для вкладок Игры и Троллинг
local GamesFrame = Instance.new("ScrollingFrame")
GamesFrame.Size = UDim2.new(1, 0, 1, 0)
GamesFrame.Position = UDim2.new(0, 0, 0, 0)
GamesFrame.BackgroundTransparency = 1
GamesFrame.ScrollBarThickness = 3
GamesFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
GamesFrame.Visible = false
GamesFrame.Parent = ContentFrame

local TrollFrame = Instance.new("ScrollingFrame")
TrollFrame.Size = UDim2.new(1, 0, 1, 0)
TrollFrame.Position = UDim2.new(0, 0, 0, 0)
TrollFrame.BackgroundTransparency = 1
TrollFrame.ScrollBarThickness = 3
TrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
TrollFrame.Visible = false
TrollFrame.Parent = ContentFrame

-- Функция переключения вкладок
local function switchTab(tab)
    ScriptsTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    GamesTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    TrollTab.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    
    ScriptsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    GamesTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    TrollTab.TextColor3 = Color3.fromRGB(180, 180, 180)
    
    ScriptsFrame.Visible = false
    GamesFrame.Visible = false
    TrollFrame.Visible = false
    
    if tab == "scripts" then
        ScriptsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        ScriptsTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0, 0, 1, -2)}):Play()
        ScriptsFrame.Visible = true
    elseif tab == "games" then
        GamesTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        GamesTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.33, 0, 1, -2)}):Play()
        GamesFrame.Visible = true
    else
        TrollTab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        TrollTab.TextColor3 = Color3.fromRGB(220, 220, 220)
        TweenService:Create(ActiveTabIndicator, TweenInfo.new(0.2), {Position = UDim2.new(0.66, 0, 1, -2)}):Play()
        TrollFrame.Visible = true
    end
end

ScriptsTab.MouseButton1Click:Connect(function() switchTab("scripts") end)
GamesTab.MouseButton1Click:Connect(function() switchTab("games") end)
TrollTab.MouseButton1Click:Connect(function() switchTab("troll") end)

-- Минимизация окна
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
        MinimizeButton.Text = "—"
    end
end)

-- Закрытие с подтверждениями
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
    YesButton.BackgroundColor3 = Color3.fromRGB(255, 165, 50) -- Оранжевая
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

-- Логика показа/скрытия основного окна по нажатию на иконку
local hubVisible = true
imageFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        hubVisible = not hubVisible
        ScreenGui.Enabled = hubVisible
        
        if hubVisible then
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
        else
            TweenService:Create(image, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
        end
    end
end)

-- Инициализация вкладки "СКРИПТЫ"
switchTab("scripts")
