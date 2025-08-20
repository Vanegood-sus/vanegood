-- Music 
local MusicContainer = Instance.new("Frame")
MusicContainer.Name = "MusicPlayer"
MusicContainer.Size = UDim2.new(1, -20, 0, 40)
MusicContainer.Position = UDim2.new(0, 10, 0, 560)  
MusicContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MusicContainer.BackgroundTransparency = 0.5
MusicContainer.Parent = ScriptsFrame

local MusicCorner = Instance.new("UICorner")
MusicCorner.CornerRadius = UDim.new(0, 6)
MusicCorner.Parent = MusicContainer

local MusicLabel = Instance.new("TextLabel")
MusicLabel.Name = "Label"
MusicLabel.Size = UDim2.new(0, 120, 1, 0)
MusicLabel.Position = UDim2.new(0, 10, 0, 0)
MusicLabel.BackgroundTransparency = 1
MusicLabel.Text = "Music"
MusicLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
MusicLabel.Font = Enum.Font.GothamBold
MusicLabel.TextSize = 14
MusicLabel.TextXAlignment = Enum.TextXAlignment.Left
MusicLabel.Parent = MusicContainer

-- Поле для ввода ID
local MusicIdBox = Instance.new("TextBox")
MusicIdBox.Name = "MusicIdBox"
MusicIdBox.Size = UDim2.new(0, 100, 0, 25)
MusicIdBox.Position = UDim2.new(0, 130, 0.5, -12)
MusicIdBox.PlaceholderText = "Song ID"
MusicIdBox.Text = ""
MusicIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MusicIdBox.TextColor3 = Color3.fromRGB(220, 220, 220)
MusicIdBox.Font = Enum.Font.Gotham
MusicIdBox.TextSize = 12
MusicIdBox.Parent = MusicContainer

local MusicIdBoxCorner = Instance.new("UICorner")
MusicIdBoxCorner.CornerRadius = UDim.new(0, 4)
MusicIdBoxCorner.Parent = MusicIdBox

-- Переключатель 
local MusicToggleFrame = Instance.new("Frame")
MusicToggleFrame.Name = "ToggleFrame"
MusicToggleFrame.Size = UDim2.new(0, 50, 0, 25)
MusicToggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
MusicToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MusicToggleFrame.Parent = MusicContainer

local MusicToggleCorner = Instance.new("UICorner")
MusicToggleCorner.CornerRadius = UDim.new(1, 0)
MusicToggleCorner.Parent = MusicToggleFrame

local MusicToggleButton = Instance.new("TextButton")
MusicToggleButton.Name = "ToggleButton"
MusicToggleButton.Size = UDim2.new(0, 21, 0, 21)
MusicToggleButton.Position = UDim2.new(0, 2, 0.5, -10)
MusicToggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
MusicToggleButton.Text = ""
MusicToggleButton.Parent = MusicToggleFrame

local MusicButtonCorner = Instance.new("UICorner")
MusicButtonCorner.CornerRadius = UDim.new(1, 0)
MusicButtonCorner.Parent = MusicToggleButton

-- Логика Music Player
local musicEnabled = false
local currentSound = nil
local SoundService = game:GetService("SoundService")

local function updateMusicToggle()
    local goal = {
        Position = musicEnabled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 2, 0.5, -10),
        BackgroundColor3 = musicEnabled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(220, 220, 220)
    }
    
    MusicToggleFrame.BackgroundColor3 = musicEnabled and Color3.fromRGB(0, 60, 100) or Color3.fromRGB(50, 50, 60)
    
    local tween = TweenService:Create(MusicToggleButton, TweenInfo.new(0.2), goal)
    tween:Play()
end

local function playMusic(songId)
    if currentSound then
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil
    end
    
    if musicEnabled and songId and tonumber(songId) then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. songId
        sound.Volume = 0.8
        sound.Looped = true
        sound.Parent = SoundService
        sound:Play()
        currentSound = sound
        print("Music playing: " .. songId)
    end
end

local function stopMusic()
    if currentSound then
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil
        print("Music stopped")
    end
end

MusicToggleButton.MouseButton1Click:Connect(function()
    musicEnabled = not musicEnabled
    updateMusicToggle()
    
    if musicEnabled then
        playMusic(MusicIdBox.Text)
    else
        stopMusic()
    end
end)

-- Обновляем музыку при изменении ID
MusicIdBox.FocusLost:Connect(function()
    if musicEnabled then
        playMusic(MusicIdBox.Text)
    end
end)

-- Автоостановка при выходе
game:GetService("Players").LocalPlayer.AncestryChanged:Connect(function()
    if currentSound then
        stopMusic()
    end
end)

updateMusicToggle()  -- Инициализация
