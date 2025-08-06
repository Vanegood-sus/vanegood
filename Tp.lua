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

-- Кнопка телепортации
local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(1, 0, 0, 25)
TeleportButton.Position = UDim2.new(0, 0, 0, 5)
TeleportButton.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
TeleportButton.Text = "Teleport to Player ▼"
TeleportButton.TextColor3 = Color3.fromRGB(220, 220, 220)
TeleportButton.Font = Enum.Font.Gotham
TeleportButton.TextSize = 12
TeleportButton.Parent = ContentFrame

local TeleportButtonCorner = Instance.new("UICorner")
TeleportButtonCorner.CornerRadius = UDim.new(0, 4)
TeleportButtonCorner.Parent = TeleportButton

-- Выпадающее меню игроков
local PlayersFrame = Instance.new("Frame")
PlayersFrame.Size = UDim2.new(1, 0, 0, 0)
PlayersFrame.Position = UDim2.new(0, 0, 0, 30)
PlayersFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
PlayersFrame.ClipsDescendants = true
PlayersFrame.Visible = false
PlayersFrame.Parent = ContentFrame

local PlayersList = Instance.new("ScrollingFrame")
PlayersList.Size = UDim2.new(1, 0, 1, 0)
PlayersList.Position = UDim2.new(0, 0, 0, 0)
PlayersList.BackgroundTransparency = 1
PlayersList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayersList.ScrollBarThickness = 3
PlayersList.Parent = PlayersFrame

local PlayersListLayout = Instance.new("UIListLayout")
PlayersListLayout.Padding = UDim.new(0, 5)
PlayersListLayout.Parent = PlayersList

PlayersListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayersList.CanvasSize = UDim2.new(0, 0, 0, PlayersListLayout.AbsoluteContentSize.Y)
end)

local function teleportPlayer(targetPlayer)
    if LocalPlayer.Character and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
    end
end

local function createPlayerButton(player)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 25)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Font = Enum.Font.Gotham
    button.TextSize = 12
    button.Text = player.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = PlayersList
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    local loopTpButton = Instance.new("TextButton")
    loopTpButton.Size = UDim2.new(0.4, -5, 0.8, 0)
    loopTpButton.Position = UDim2.new(0.6, 5, 0.1, 0)
    loopTpButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
    loopTpButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    loopTpButton.Font = Enum.Font.Gotham
    loopTpButton.TextSize = 10
    loopTpButton.Text = "Loop TP"
    loopTpButton.Parent = button
    
    local loopTpCorner = Instance.new("UICorner")
    loopTpCorner.CornerRadius = UDim.new(0, 4)
    loopTpCorner.Parent = loopTpButton
    
    local isLoopTpEnabled = false
    local loopTpConnection
    
    loopTpButton.MouseButton1Click:Connect(function()
        if not isLoopTpEnabled then
            loopTpButton.Text = "Stop TP"
            loopTpButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
            loopTpConnection = RunService.RenderStepped:Connect(function()
                if LocalPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    teleportPlayer(player)
                end
            end)
            isLoopTpEnabled = true
        else
            loopTpButton.Text = "Loop TP"
            loopTpButton.BackgroundColor3 = Color3.fromRGB(65, 65, 80)
            loopTpConnection:Disconnect()
            isLoopTpEnabled = false
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        if not isLoopTpEnabled then
            teleportPlayer(player)
        end
    end)
    
    return button
end

-- Обработчик кнопки телепортации
local isPlayersListVisible = false
TeleportButton.MouseButton1Click:Connect(function()
    isPlayersListVisible = not isPlayersListVisible
    
    if isPlayersListVisible then
        TeleportButton.Text = "Teleport to Player ▲"
        PlayersFrame.Visible = true
        
        -- Рассчитываем высоту в зависимости от количества игроков
        local playerCount = #Players:GetPlayers() - 1
        if playerCount > 0 then
            local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
            PlayersFrame.Size = UDim2.new(1, 0, 0, height)
            MainFrame.Size = UDim2.new(0, 180, 0, 80 + height)
        end
    else
        TeleportButton.Text = "Teleport to Player ▼"
        PlayersFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 180, 0, 80)
    end
end)

-- Добавляем существующих игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createPlayerButton(player)
    end
end

-- Обработчик новых игроков
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createPlayerButton(player)
        
        -- Обновляем размеры, если меню открыто
        if isPlayersListVisible then
            local playerCount = #Players:GetPlayers() - 1
            local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
            PlayersFrame.Size = UDim2.new(1, 0, 0, height)
            MainFrame.Size = UDim2.new(0, 180, 0, 80 + height)
        end
    end
end)

-- Обработчик ушедших игроков
Players.PlayerRemoving:Connect(function(player)
    for _, child in ipairs(PlayersList:GetChildren()) do
        if child:IsA("TextButton") and child.Text == player.Name then
            child:Destroy()
            
            -- Обновляем размеры, если меню открыто
            if isPlayersListVisible then
                local playerCount = #Players:GetPlayers() - 2 -- -2 потому что LocalPlayer и уходящий игрок
                local height = math.min(playerCount * 30 + (playerCount - 1) * 5, 150)
                PlayersFrame.Size = UDim2.new(1, 0, 0, height)
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
        PlayersFrame.Visible = false
        isPlayersListVisible = false
        TeleportButton.Text = "Teleport to Player ▼"
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
