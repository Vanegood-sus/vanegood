--[[
    vanegood Hub - Clean & Beautiful
    Created by vanegood
    GitHub: https://github.com/Vanegood-sus/vanegood.git
    
    Simple black/grey hub with dark red accents
    Features: Show/hide toggle, sidebar navigation, Muscle Legends integration
]]--

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Variables
local VanegoodHub = {}
local GUI = {}
local CurrentTab = "Main"
local HubVisible = true

-- Colors
local Colors = {
    Black = Color3.fromRGB(0, 0, 0),
    DarkGray = Color3.fromRGB(40, 40, 40),
    Gray = Color3.fromRGB(60, 60, 60),
    White = Color3.fromRGB(255, 255, 255),
    DarkRed = Color3.fromRGB(139, 0, 0)
}

-- Helper Functions
local function CreateTween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), properties)
    return tween
end

local function AddCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
    return corner
end

local function AddStroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.Parent = object
    return stroke
end

-- Main Hub Creation
function VanegoodHub:Create()
    -- Create ScreenGui
    GUI.Main = Instance.new("ScreenGui")
    GUI.Main.Name = "VanegoodHub"
    GUI.Main.ResetOnSpawn = false
    GUI.Main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Show/Hide Toggle Button (left side)
    GUI.ToggleButton = Instance.new("TextButton")
    GUI.ToggleButton.Name = "ToggleButton"
    GUI.ToggleButton.Size = UDim2.new(0, 40, 0, 40)
    GUI.ToggleButton.Position = UDim2.new(0, 20, 0.5, -20)
    GUI.ToggleButton.BackgroundColor3 = Colors.DarkRed
    GUI.ToggleButton.BorderSizePixel = 0
    GUI.ToggleButton.Text = "V"
    GUI.ToggleButton.TextColor3 = Colors.White
    GUI.ToggleButton.TextSize = 18
    GUI.ToggleButton.Font = Enum.Font.GothamBold
    GUI.ToggleButton.Parent = GUI.Main
    
    AddCorner(GUI.ToggleButton, 6)
    
    -- Main Frame
    GUI.Frame = Instance.new("Frame")
    GUI.Frame.Name = "MainFrame"
    GUI.Frame.Size = UDim2.new(0, 450, 0, 300)
    GUI.Frame.Position = UDim2.new(0.5, -225, 0.5, -150)
    GUI.Frame.BackgroundColor3 = Colors.Black
    GUI.Frame.BorderSizePixel = 0
    GUI.Frame.Parent = GUI.Main
    
    AddCorner(GUI.Frame, 8)
    AddStroke(GUI.Frame, Colors.DarkRed, 2)
    
    -- Title Bar
    GUI.TitleBar = Instance.new("Frame")
    GUI.TitleBar.Name = "TitleBar"
    GUI.TitleBar.Size = UDim2.new(1, 0, 0, 30)
    GUI.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    GUI.TitleBar.BackgroundColor3 = Colors.DarkRed
    GUI.TitleBar.BorderSizePixel = 0
    GUI.TitleBar.Parent = GUI.Frame
    
    AddCorner(GUI.TitleBar, 8)
    
    -- Title Text
    GUI.Title = Instance.new("TextLabel")
    GUI.Title.Name = "Title"
    GUI.Title.Size = UDim2.new(1, -30, 1, 0)
    GUI.Title.Position = UDim2.new(0, 5, 0, 0)
    GUI.Title.BackgroundTransparency = 1
    GUI.Title.Text = "vanegood"
    GUI.Title.TextColor3 = Colors.White
    GUI.Title.TextSize = 16
    GUI.Title.Font = Enum.Font.GothamBold
    GUI.Title.TextXAlignment = Enum.TextXAlignment.Left
    GUI.Title.Parent = GUI.TitleBar
    
    -- Close Button
    GUI.CloseButton = Instance.new("TextButton")
    GUI.CloseButton.Name = "CloseButton"
    GUI.CloseButton.Size = UDim2.new(0, 25, 0, 25)
    GUI.CloseButton.Position = UDim2.new(1, -30, 0, 2.5)
    GUI.CloseButton.BackgroundColor3 = Colors.DarkRed
    GUI.CloseButton.BorderSizePixel = 0
    GUI.CloseButton.Text = "✕"
    GUI.CloseButton.TextColor3 = Colors.White
    GUI.CloseButton.TextSize = 14
    GUI.CloseButton.Font = Enum.Font.GothamBold
    GUI.CloseButton.Parent = GUI.TitleBar
    
    AddCorner(GUI.CloseButton, 4)
    
    -- Sidebar
    GUI.Sidebar = Instance.new("Frame")
    GUI.Sidebar.Name = "Sidebar"
    GUI.Sidebar.Size = UDim2.new(0, 80, 1, -30)
    GUI.Sidebar.Position = UDim2.new(0, 0, 0, 30)
    GUI.Sidebar.BackgroundColor3 = Colors.DarkGray
    GUI.Sidebar.BorderSizePixel = 0
    GUI.Sidebar.Parent = GUI.Frame
    
    -- Content Area
    GUI.Content = Instance.new("Frame")
    GUI.Content.Name = "Content"
    GUI.Content.Size = UDim2.new(1, -80, 1, -30)
    GUI.Content.Position = UDim2.new(0, 80, 0, 30)
    GUI.Content.BackgroundColor3 = Colors.DarkGray
    GUI.Content.BorderSizePixel = 0
    GUI.Content.Parent = GUI.Frame
    
    self:CreateSidebar()
    self:CreateContent()
    self:MakeDraggable()
    self:SetupEvents()
    
    return GUI.Main
end

-- Create Sidebar
function VanegoodHub:CreateSidebar()
    -- Main Tab Button
    GUI.MainTabButton = Instance.new("TextButton")
    GUI.MainTabButton.Name = "MainTabButton"
    GUI.MainTabButton.Size = UDim2.new(1, -10, 0, 32)
    GUI.MainTabButton.Position = UDim2.new(0, 5, 0, 8)
    GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed -- Start selected
    GUI.MainTabButton.BorderSizePixel = 0
    GUI.MainTabButton.Text = "main"
    GUI.MainTabButton.TextColor3 = Colors.White
    GUI.MainTabButton.TextSize = 13
    GUI.MainTabButton.Font = Enum.Font.GothamBold
    GUI.MainTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.MainTabButton, 4)
    
    -- Games Tab Button
    GUI.GamesTabButton = Instance.new("TextButton")
    GUI.GamesTabButton.Name = "GamesTabButton"
    GUI.GamesTabButton.Size = UDim2.new(1, -10, 0, 32)
    GUI.GamesTabButton.Position = UDim2.new(0, 5, 0, 45)
    GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    GUI.GamesTabButton.BorderSizePixel = 0
    GUI.GamesTabButton.Text = "games"
    GUI.GamesTabButton.TextColor3 = Colors.White
    GUI.GamesTabButton.TextSize = 13
    GUI.GamesTabButton.Font = Enum.Font.GothamBold
    GUI.GamesTabButton.Parent = GUI.Sidebar
    
    AddCorner(GUI.GamesTabButton, 4)
    
    -- Tab Events
    GUI.MainTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Main")
    end)
    
    GUI.GamesTabButton.MouseButton1Click:Connect(function()
        self:SwitchTab("Games")
    end)
end

-- Create Content
function VanegoodHub:CreateContent()
    -- Main Page
    GUI.MainPage = Instance.new("Frame")
    GUI.MainPage.Name = "MainPage"
    GUI.MainPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.MainPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.MainPage.BackgroundTransparency = 1
    GUI.MainPage.Visible = true
    GUI.MainPage.Parent = GUI.Content
    
    -- vanegood title (dark red)
    GUI.VanegoodTitle = Instance.new("TextLabel")
    GUI.VanegoodTitle.Name = "VanegoodTitle"
    GUI.VanegoodTitle.Size = UDim2.new(1, 0, 0, 50)
    GUI.VanegoodTitle.Position = UDim2.new(0, 0, 0, 10)
    GUI.VanegoodTitle.BackgroundTransparency = 1
    GUI.VanegoodTitle.Text = "vanegood"
    GUI.VanegoodTitle.TextColor3 = Colors.DarkRed
    GUI.VanegoodTitle.TextSize = 24
    GUI.VanegoodTitle.Font = Enum.Font.GothamBold
    GUI.VanegoodTitle.TextXAlignment = Enum.TextXAlignment.Center
    GUI.VanegoodTitle.Parent = GUI.MainPage
    
    -- Fly button (only this one for now)
    GUI.FlyButton = Instance.new("TextButton")
    GUI.FlyButton.Name = "FlyButton"
    GUI.FlyButton.Size = UDim2.new(0, 200, 0, 40)
    GUI.FlyButton.Position = UDim2.new(0, 20, 0, 80)
    GUI.FlyButton.BackgroundColor3 = Colors.DarkGray
    GUI.FlyButton.BorderSizePixel = 0
    GUI.FlyButton.Text = "fly"
    GUI.FlyButton.TextColor3 = Colors.White
    GUI.FlyButton.TextSize = 16
    GUI.FlyButton.Font = Enum.Font.Gotham
    GUI.FlyButton.Parent = GUI.MainPage
    
    AddCorner(GUI.FlyButton, 6)
    AddStroke(GUI.FlyButton, Colors.DarkRed, 2)
    
    -- Hover effect
    GUI.FlyButton.MouseEnter:Connect(function()
        CreateTween(GUI.FlyButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
    end)
    
    GUI.FlyButton.MouseLeave:Connect(function()
        CreateTween(GUI.FlyButton, {BackgroundColor3 = Colors.DarkGray}, 0.2):Play()
    end)
    
    -- Fly button event (not implemented yet)
    GUI.FlyButton.MouseButton1Click:Connect(function()
        print("fly button clicked (not implemented yet)")
    end)
    
    -- Games Page
    GUI.GamesPage = Instance.new("Frame")
    GUI.GamesPage.Name = "GamesPage"
    GUI.GamesPage.Size = UDim2.new(1, -20, 1, -20)
    GUI.GamesPage.Position = UDim2.new(0, 10, 0, 10)
    GUI.GamesPage.BackgroundTransparency = 1
    GUI.GamesPage.Visible = false
    GUI.GamesPage.Parent = GUI.Content
    
    -- Muscle Legends Game Box
    GUI.MuscleLegendsBox = Instance.new("TextButton")
    GUI.MuscleLegendsBox.Name = "MuscleLegendsBox"
    GUI.MuscleLegendsBox.Size = UDim2.new(0, 300, 0, 60)
    GUI.MuscleLegendsBox.Position = UDim2.new(0, 20, 0, 20)
    GUI.MuscleLegendsBox.BackgroundColor3 = Colors.DarkGray
    GUI.MuscleLegendsBox.BorderSizePixel = 0
    GUI.MuscleLegendsBox.Text = "Muscle Legends"
    GUI.MuscleLegendsBox.TextColor3 = Colors.White
    GUI.MuscleLegendsBox.TextSize = 18
    GUI.MuscleLegendsBox.Font = Enum.Font.GothamBold
    GUI.MuscleLegendsBox.TextXAlignment = Enum.TextXAlignment.Center
    GUI.MuscleLegendsBox.Parent = GUI.GamesPage
    
    AddCorner(GUI.MuscleLegendsBox, 6)
    AddStroke(GUI.MuscleLegendsBox, Colors.DarkRed, 2)
    
    -- Hover effect
    GUI.MuscleLegendsBox.MouseEnter:Connect(function()
        CreateTween(GUI.MuscleLegendsBox, {
            BackgroundColor3 = Colors.Gray,
            TextColor3 = Colors.DarkRed
        }, 0.2):Play()
    end)
    
    GUI.MuscleLegendsBox.MouseLeave:Connect(function()
        CreateTween(GUI.MuscleLegendsBox, {
            BackgroundColor3 = Colors.DarkGray,
            TextColor3 = Colors.White
        }, 0.2):Play()
    end)
    
    -- Muscle Legends click event - FIXED
    GUI.MuscleLegendsBox.MouseButton1Click:Connect(function()
        print("Loading Muscle Legends script by vanegood...")
        
        -- Visual feedback
        CreateTween(GUI.MuscleLegendsBox, {BackgroundColor3 = Colors.DarkRed}, 0.1):Play()
        task.wait(0.1)
        CreateTween(GUI.MuscleLegendsBox, {BackgroundColor3 = Colors.DarkGray}, 0.1):Play()
        
        -- Load script properly
        task.spawn(function()
            local success, result = pcall(function()
                local HttpService = game:GetService("HttpService")
                local scriptContent = game:HttpGet("https://raw.githubusercontent.com/Vanegood-sus/vanegood/main/muscle_legends_script.lua", true)
                
                if scriptContent and #scriptContent > 50 then
                    local loadedScript = loadstring(scriptContent)
                    if loadedScript then
                        loadedScript()
                        print("✓ Muscle Legends script loaded successfully!")
                        
                        -- Success notification
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "vanegood",
                            Text = "Muscle Legends script loaded!",
                            Duration = 3
                        })
                        return true
                    else
                        error("Failed to compile script")
                    end
                else
                    error("Script content is empty or too short")
                end
            end)
            
            if not success then
                warn("❌ Error loading Muscle Legends:", result)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "vanegood",
                    Text = "Failed to load Muscle Legends. Check output.",
                    Duration = 5
                })
            end
        end)
    end)
end

-- Switch Tab Function
function VanegoodHub:SwitchTab(tabName)
    CurrentTab = tabName
    
    if tabName == "Main" then
        GUI.MainPage.Visible = true
        GUI.GamesPage.Visible = false
        GUI.MainTabButton.BackgroundColor3 = Colors.DarkRed
        GUI.GamesTabButton.BackgroundColor3 = Colors.Gray
    elseif tabName == "Games" then
        GUI.MainPage.Visible = false
        GUI.GamesPage.Visible = true
        GUI.MainTabButton.BackgroundColor3 = Colors.Gray
        GUI.GamesTabButton.BackgroundColor3 = Colors.DarkRed
    end
end

-- Make Draggable
function VanegoodHub:MakeDraggable()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    GUI.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = GUI.Frame.Position
        end
    end)
    
    GUI.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            GUI.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Setup Events
function VanegoodHub:SetupEvents()
    -- Close Button
    GUI.CloseButton.MouseButton1Click:Connect(function()
        CreateTween(GUI.Frame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
        CreateTween(GUI.ToggleButton, {Size = UDim2.new(0, 0, 0, 0)}, 0.3):Play()
        task.wait(0.3)
        GUI.Main:Destroy()
    end)
    
    -- Toggle Button (Show/Hide Hub)
    GUI.ToggleButton.MouseButton1Click:Connect(function()
        if HubVisible then
            -- Hide hub
            CreateTween(GUI.Frame, {Position = UDim2.new(0, -450, 0.5, -150)}, 0.3):Play()
            HubVisible = false
        else
            -- Show hub
            CreateTween(GUI.Frame, {Position = UDim2.new(0.5, -225, 0.5, -150)}, 0.3):Play()
            HubVisible = true
        end
    end)
    
    -- Hover effects for buttons
    GUI.CloseButton.MouseEnter:Connect(function()
        CreateTween(GUI.CloseButton, {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}, 0.2):Play()
    end)
    
    GUI.CloseButton.MouseLeave:Connect(function()
        CreateTween(GUI.CloseButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
    end)
    
    GUI.ToggleButton.MouseEnter:Connect(function()
        CreateTween(GUI.ToggleButton, {BackgroundColor3 = Colors.Gray}, 0.2):Play()
    end)
    
    GUI.ToggleButton.MouseLeave:Connect(function()
        CreateTween(GUI.ToggleButton, {BackgroundColor3 = Colors.DarkRed}, 0.2):Play()
    end)
end

-- Initialize Hub
local hub = VanegoodHub:Create()

print("✓ vanegood Hub loaded successfully!")
print("✓ Created by vanegood - GitHub: https://github.com/Vanegood-sus/vanegood.git")
print("✓ Clean design with proper show/hide functionality")
