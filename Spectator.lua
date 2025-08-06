local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VanegoodHub"
ScreenGui.Parent = game:GetService("CoreGui")

-- Основное окно (перемещаемое)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 80)
MainFrame.Position = UDim2.new(0.5, -90, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Верхняя панель
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 8)
TopBarCorner.Parent = TopBar

-- Заголовок "Vanegood hub"
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "vanegood hub"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Крестик для закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0.5, -10)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = TopBar

-- Кнопка минимизации
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
MinimizeButton.Position = UDim2.new(1, -50, 0.5, -10)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TopBar

-- Контентная область
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -35)
ContentFrame.Position = UDim2.new(0, 10, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Кнопка наблюдателя
local SpectateButton = Instance.new("TextButton")
SpectateButton.Size = UDim2.new(1, 0, 0, 25)
SpectateButton.Position = UDim2.new(0, 0, 0, 5)
SpectateButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
SpectateButton.Text = "Spectate Player ▼"
SpectateButton.TextColor3 = Color3.fromRGB(220, 220, 220)
SpectateButton.Font = Enum.Font.Gotham
SpectateButton.TextSize = 12
SpectateButton.Parent = ContentFrame

local SpectateButtonCorner = Instance.new("UICorner")
SpectateButtonCorner.CornerRadius = UDim.new(0, 4)
SpectateButtonCorner.Parent = SpectateButton

-- Выпадающее меню игроков для наблюдателя
local SpectateFrame = Instance.new("Frame")
SpectateFrame.Size = UDim2.new(1, 0, 0, 0)
SpectateFrame.Position = UDim2.new(0, 0, 0, 30)
SpectateFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SpectateFrame.ClipsDescendants = true
SpectateFrame.Visible = false
SpectateFrame.Parent = ContentFrame

local SpectateList = Instance.new("ScrollingFrame")
SpectateList.Size = UDim2.new(1, 0, 1, 0)
SpectateList.Position = UDim2.new(0, 0, 0, 0)
SpectateList.BackgroundTransparency = 1
SpectateList.CanvasSize = UDim2.new(0, 0, 0, 0)
SpectateList.ScrollBarThickness = 3
SpectateList.Parent = SpectateFrame

local SpectateListLayout = Instance.new("UIListLayout")
SpectateListLayout.Padding = UDim.new(0, 5)
SpectateListLayout.Parent = SpectateList

SpectateListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    SpectateList.CanvasSize = UDim2.new(0, 0, 0, SpectateListLayout.AbsoluteContentSize.Y)
end)

-- Функция для наблюдения за игроком
local currentSubject = nil
local function spectatePlayer(player)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        currentSubject = player
        game.Workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
        return true
    end
    return false
end

-- Функция для прекращения наблюдения
local function stopSpectating()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        currentSubject = nil
        game.Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
    end
end

-- Создание кнопки игрока для наблюдателя
local function createSpectateButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 25)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = SpectateList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    local spectateButton = Instance.new("TextButton")
    spectateButton.Size = UDim2.new(0.4, -5, 0.8, 0)
    spectateButton.Position = UDim2.new(0.6, 5, 0.1, 0)
    spectateButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
    spectateButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    spectateButton.Font = Enum.Font.Gotham
    spectateButton.TextSize = 10
    spectateButton.Text = "Spectate"
    spectateButton.Parent = button
    
    local spectateCorner = Instance.new("UICorner")
    spectateCorner.CornerRadius = UDim.new(0, 4)
    spectateCorner.Parent = spectateButton
    
    spectateButton.MouseButton1Click:Connect(function()
        if currentSubject == player then
            stopSpectating()
            spectateButton.Text = "Spectate"
            spectateButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
        else
            if spectatePlayer(player) then
                spectateButton.Text = "Stop"
                spectateButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
                
                -- Сбрасываем другие кнопки
                for _, child in ipairs(SpectateList:GetChildren()) do
                    if child:IsA("TextButton") and child ~= button then
                        local otherSpectateBtn = child:FindFirstChildWhichIsA("TextButton")
                        if otherSpectateBtn then
                            otherSpectateBtn.Text = "Spectate"
                            otherSpectateBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
                        end
                    end
                end
            end
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        if currentSubject ~= player then
            if spectatePlayer(player) then
                spectateButton.Text = "Stop"
                spectateButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
                
                -- Сбрасываем другие кнопки
                for _, child in ipairs(SpectateList:GetChildren()) do
                    if child:IsA("TextButton") and child ~= button then
                        local otherSpectateBtn = child:FindFirstChildWhichIsA("TextButton")
                        if otherSpectateBtn then
                            otherSpectateBtn.Text = "Spectate"
                            otherSpectateBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
                        end
                    end
                end
            end
        end
    end)
    
    return button
end

-- Обработчик кнопки наблюдателя
local isSpectateListVisible = false
SpectateButton.MouseButton1Click:Connect(function()
    isSpectateListVisible = not isSpectateListVisible
    
    if isSpectateListVisible then
        SpectateButton.Text = "Spectate Player ▲"
        SpectateFrame.Visible = true
        
        -- Рассчитываем высоту в зависимости от количества игроков
        local playerCount = #Players:GetPlayers() - 1
        if playerCount > 0 then
            local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
            SpectateFrame.Size = UDim2.new(1, 0, 0, height)
            MainFrame.Size = UDim2.new(0, 180, 0, 80 + height)
        end
    else
        SpectateButton.Text = "Spectate Player ▼"
        SpectateFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
    end
end)

-- Добавляем существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createSpectateButton(player)
    end
end

-- Обработчик новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createSpectateButton(player)
        
        -- Обновляем размеры, если меню открыто
        if isSpectateListVisible then
            local playerCount = #Players:GetPlayers() - 1
            local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
            SpectateFrame.Size = UDim2.new(1, 0, 0, height)
            MainFrame.Size = UDim2.new(0, 180, 0, 80 + height)
        end
    end
end)

-- Обработчик ушедших игроков
Players.PlayerRemoving:Connect(function(player)
    for _, child in ipairs(SpectateList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            if currentSubject == player then
                stopSpectating()
            end
            child:Destroy()
            
            -- Обновляем размеры, если меню открыто
            if isSpectateListVisible then
                local playerCount = #Players:GetPlayers() - 2 -- -2 потому что LocalPlayer и уходящий игрок
                local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
                SpectateFrame.Size = UDim2.new(1, 0, 0, height)
                MainFrame.Size = UDim2.new(0, 180, 0, 80 + height)
            end
            break
        end
    end
end)

-- Функция минимизации
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    
    if minimized then
        MainFrame.Size = UDim2.new(0, 180, 0, 25)
        ContentFrame.Visible = false
        SpectateFrame.Visible = false
        isSpectateListVisible = false
        SpectateButton.Text = "Spectate Player ▼"
        MinimizeButton.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
        ContentFrame.Visible = true
        MinimizeButton.Text = "-"
    end
end

-- Функция создания окна подтверждения
local function createConfirmationDialog()
    local MessageFrame = Instance.new("Frame")
    MessageFrame.Size = UDim2.new(0, 220, 0, 100)
    MessageFrame.Position = UDim2.new(0.5, -110, 0.5, -60)
    MessageFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    MessageFrame.BackgroundTransparency = 0.2
    MessageFrame.Parent = ScreenGui
    
    local MessageCorner = Instance.new("UICorner")
    MessageCorner.CornerRadius = UDim.new(0, 8)
    MessageCorner.Parent = MessageFrame
    
    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(1, -20, 0, 50)
    MessageLabel.Position = UDim2.new(0, 10, 0, 10)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = "Вы уверены, что хотите закрыть меню?"
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextSize = 14
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = MessageFrame
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, -20, 0, 30)
    ButtonContainer.Position = UDim2.new(0, 10, 1, -40)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = MessageFrame
    
    local YesButton = Instance.new("TextButton")
    YesButton.Size = UDim2.new(0.45, 0, 1, 0)
    YesButton.Position = UDim2.new(0, 0, 0, 0)
    YesButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    YesButton.Text = "Да"
    YesButton.TextColor3 = Color3.new(1, 1, 1)
    YesButton.Font = Enum.Font.GothamMedium
    YesButton.TextSize = 14
    YesButton.Parent = ButtonContainer
    
    local NoButton = Instance.new("TextButton")
    NoButton.Size = UDim2.new(0.45, 0, 1, 0)
    NoButton.Position = UDim2.new(0.55, 0, 0, 0)
    NoButton.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    NoButton.Text = "Нет"
    NoButton.TextColor3 = Color3.new(1, 1, 1)
    NoButton.Font = Enum.Font.GothamMedium
    NoButton.TextSize = 14
    NoButton.Parent = ButtonContainer
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Parent = YesButton
    ButtonCorner:Clone().Parent = NoButton
    
    YesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    NoButton.MouseButton1Click:Connect(function()
        MessageFrame:Destroy()
    end)
end

-- Обработчик кнопки минимизации
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Обработчик кнопки закрытия
CloseButton.MouseButton1Click:Connect(createConfirmationDialog)
