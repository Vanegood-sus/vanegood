-- vanegood from muscle legends --
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local startTime = os.time()
local startRebirths = player.leaderstats.Rebirths.Value
local displayName = player.DisplayName

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
        print("Анти-Афк")
    end)
    
    print("Включено Анти-Афк")
end

-- Initialize Anti-AFK system
setupAntiAFK()

-- Create Main Window
local window = library:AddWindow("Другие моменты", {
    main_color = Color3.fromRGB(19, 112, 103),
    min_size = Vector2.new(800, 900),
    can_resize = true,
})

-- Main Tab
local mainTab = window:AddTab("Меню")
local farmPlusTab = window:AddTab("Фарм")
mainTab:Show() -- Show this tab by default

mainTab:AddLabel("Добро Пожаловать!")


-- Add Anti-AFK toggle
local antiAFKEnabled = true
mainTab:AddSwitch("Анти-Афк", function(bool)
    antiAFKEnabled = bool
    
    if bool then
        setupAntiAFK()
    else
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
            print("Anti-AFK system disabled")
        end
    end
end, true) -- Default to enabled

-- Auto Brawls Folder
local autoBrawlsFolder = mainTab:AddFolder("Авто бой")

-- Variables
local Players = game:GetService("Players")
local whitelist = {} -- Add any whitelisted player IDs here

-- Auto Win Brawl Toggle
local autoWinBrawlSwitch = autoBrawlsFolder:AddSwitch("Авто выйгрыш", function(bool)
    getgenv().autoWinBrawl = bool
    
    -- Equip Punch Tool function - will be called repeatedly
    local function equipPunch()
        if not getgenv().autoWinBrawl then return end
        
        local character = game.Players.LocalPlayer.Character
        if not character then return false end
        
        -- Check if already equipped
        if character:FindFirstChild("Punch") then return true end
        
        -- Try to equip from backpack
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
    
    -- Safe player check function
    local function isValidTarget(player)
        if not player or not player.Parent then return false end
        if player == Players.LocalPlayer then return false end
        if whitelist[player.UserId] then return false end
        
        local character = player.Character
        if not character or not character.Parent then return false end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return false end
        
        -- Multiple health checks to be absolutely certain
        if not humanoid.Health or humanoid.Health <= 0 then return false end
        if humanoid:GetState() == Enum.HumanoidStateType.Dead then return false end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart or not rootPart.Parent then return false end
        
        return true
    end
    
    -- Safe local player check function
    local function isLocalPlayerReady()
        local player = game.Players.LocalPlayer
        if not player then return false end
        
        local character = player.Character
        if not character or not character.Parent then return false end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return false end
        
        local leftHand = character:FindFirstChild("LeftHand")
        local rightHand = character:FindFirstChild("RightHand")
        
        return (leftHand ~= nil or rightHand ~= nil)
    end
    
    -- Safe firetouchinterest function
    local function safeTouchInterest(targetPart, localPart)
        if not targetPart or not targetPart.Parent then return false end
        if not localPart or not localPart.Parent then return false end
        
        local success, err = pcall(function()
            firetouchinterest(targetPart, localPart, 0)
            task.wait(0.01)
            firetouchinterest(targetPart, localPart, 1)
        end)
        
        return success
    end
    
    -- Join Brawl Loop
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if not getgenv().autoWinBrawl then break end
            
            if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)
    
    -- Equipment loop - keeps trying to equip the punch
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.5) do
            if not getgenv().autoWinBrawl then break end
            equipPunch()
        end
    end)
    
    -- Auto Punch Loop - keeps punching
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.1) do
            if not getgenv().autoWinBrawl then break end
            
            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                local player = game.Players.LocalPlayer
                pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
            end
        end
    end)
    
    -- Main Kill Loop - extremely resilient
    task.spawn(function()
        while getgenv().autoWinBrawl and task.wait(0.05) do
            if not getgenv().autoWinBrawl then break end
            
            -- Only proceed if local player is ready and brawl is in progress
            if isLocalPlayerReady() and game.ReplicatedStorage.brawlInProgress.Value then
                local character = game.Players.LocalPlayer.Character
                local leftHand = character:FindFirstChild("LeftHand")
                local rightHand = character:FindFirstChild("RightHand")
                
                -- Process each player individually with error handling
                for _, player in pairs(Players:GetPlayers()) do
                    -- Skip if toggle was turned off mid-loop
                    if not getgenv().autoWinBrawl then break end
                    
                    -- Use pcall for the entire player processing to prevent any errors from breaking the loop
                    pcall(function()
                        if isValidTarget(player) then
                            local targetRoot = player.Character.HumanoidRootPart
                            
                            -- Try left hand
                            if leftHand then
                                safeTouchInterest(targetRoot, leftHand)
                            end
                            
                            -- Try right hand
                            if rightHand then
                                safeTouchInterest(targetRoot, rightHand)
                            end
                        end
                    end)
                    
                    -- Small delay between players to prevent overwhelming
                    task.wait(0.01)
                end
            end
        end
    end)
    
    -- Recovery system - if the main loop somehow breaks, this will restart it
    task.spawn(function()
        local lastPlayerCount = 0
        local stuckCounter = 0
        
        while getgenv().autoWinBrawl and task.wait(1) do
            if not getgenv().autoWinBrawl then break end
            
            -- Check if we're processing players
            local currentPlayerCount = #Players:GetPlayers()
            
            -- If player count changed but we're not seeing any activity, restart the kill loop
            if currentPlayerCount ~= lastPlayerCount then
                stuckCounter = 0
                lastPlayerCount = currentPlayerCount
            else
                stuckCounter = stuckCounter + 1
                
                -- If we seem stuck for too long, force re-equip the tool
                if stuckCounter > 5 then
                    stuckCounter = 0
                    
                    -- Force re-equip
                    pcall(function()
                        local character = game.Players.LocalPlayer.Character
                        if character and character:FindFirstChild("Punch") then
                            character.Punch.Parent = game.Players.LocalPlayer.Backpack
                            task.wait(0.1)
                            equipPunch()
                        else
                            equipPunch()
                        end
                    end)
                end
            end
        end
    end)
end)

-- Auto Join Brawl Only - FIXED to join only once and properly turn off
autoBrawlsFolder:AddSwitch("Автоматом вступать в бой", function(bool)
    getgenv().autoJoinBrawl = bool
    
    task.spawn(function()
        while getgenv().autoJoinBrawl and task.wait(0.5) do
            if not getgenv().autoJoinBrawl then break end
            
            if game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible then
                game.ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                -- Set the label to not visible to prevent multiple joins
                game.Players.LocalPlayer.PlayerGui.gameGui.brawlJoinLabel.Visible = false
            end
        end
    end)
end)


-- NEW: Farm Gyms Folder
local farmGymsFolder = mainTab:AddFolder("Entrenar Gimnasios")

-- Workout positions data
local workoutPositions = {
    ["Жим лежа"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легенды"] = CFrame.new(4111.91748, 1020.46674, -3799.97217),
        ["Портал Короля"] = CFrame.new(-8590.06152, 46.0167427, -6043.34717)
    },
    ["Жим с присяда"] = {
        ["Портал Ад"] = CFrame.new(-7176.19141, 45.394104, -1106.31421),
        ["Портал Легендя"] = CFrame.new(4304.99023, 987.829956, -4124.2334),
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

-- Workout types
local workoutTypes = {
    "Жим лежа",
    "Жим с присяда",
    "Становая тяга",
    "Поднимать камень"
}

-- Gym locations (only the three requested)
local gymLocations = {
    "Ад",
    "Легенд",
    "Король"
}

-- Spanish translations for workout types
local workoutTranslations = {
    ["Bench Press"] = "Жим лежа",
    ["Squat"] = "Жим с присяда",
    ["Deadlift"] = "Становая тяга",
    ["Pull Up"] = "Поднимать камень"
}

-- Store references to toggle objects
local gymToggles = {}

-- Create dropdowns and toggles for each workout type
for _, workoutType in ipairs(workoutTypes) do
    -- Create dropdown for gym selection
    local dropdownName = workoutType .. "GymDropdown"
    local spanishWorkoutName = workoutTranslations[workoutType]
    
    -- Create the dropdown with the correct format
    local dropdown = farmGymsFolder:AddDropdown(spanishWorkoutName .. " - Gimnasio", function(selected)
        _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] = selected
    end)
    
    -- Add gym locations to the dropdown
    for _, gymName in ipairs(gymLocations) do
        dropdown:Add(gymName)
    end
    
    -- Create toggle for workout
    local toggleName = workoutType .. "GymToggle"
    local toggle = farmGymsFolder:AddSwitch(spanishWorkoutName, function(bool)
        getgenv().workingGym = bool
        getgenv().currentWorkoutType = workoutType
        
        if bool then
            local selectedGym = _G["selected" .. string.gsub(workoutType, " ", "") .. "Gym"] or gymLocations[1]
            
            -- Make sure we have a valid position
            if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGym] then
                -- Stop any other workout that might be running
                for otherType, otherToggle in pairs(gymToggles) do
                    if otherType ~= workoutType and otherToggle then
                        otherToggle:Set(false)
                    end
                end
                
                -- Start the workout
                teleportAndStart(workoutType, workoutPositions[workoutType][selectedGym])
            else
                -- Notify user if position is not found
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Error",
                    Text = "Position not found for " .. workoutType .. " in " .. selectedGym,
                    Duration = 5
                })
            end
        end
    end)
    
    -- Store reference to toggle
    gymToggles[workoutType] = toggle
end

-- OP Things/Farms Folder
local opThingsFolder = mainTab:AddFolder("OP Things/Farms")

-- Anti Knockback Toggle
opThingsFolder:AddSwitch("Анти отбрасывание", function(Value)
    if Value then
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.P = 1250
        bodyVelocity.Parent = rootPart
    else
        local playerName = game.Players.LocalPlayer.Name
        local rootPart = game.Workspace:FindFirstChild(playerName):FindFirstChild("HumanoidRootPart")
        local existingVelocity = rootPart:FindFirstChild("BodyVelocity")
        if existingVelocity and existingVelocity.MaxForce == Vector3.new(100000, 0, 100000) then
            existingVelocity:Destroy()
        end
    end
end)

local autoRockFolder = farmPlusTab:AddFolder("Auto Rock")

-- Define the gettool function first
function gettool()
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == "Punch" and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
    game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
end

-- Add all rock farming toggles to the Auto Rock folder
autoRockFolder:AddSwitch("Маленький камень - 0", function(Value)
    selectrock = "Tiny Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 0 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 0 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Средний камень - 100", function(Value)
    selectrock = "Starter Island Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 100 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 100 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Золотой камень - 5000", function(Value)
    selectrock = "Legend Beach Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Ледяной камень - 150000", function(Value)
    selectrock = "Frost Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 150000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 150000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Мифический камень - 400000", function(Value)
    selectrock = "Mythical Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 400000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 400000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Адский камень - 750000", function(Value)
    selectrock = "Eternal Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 750000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 750000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Легендарный камень - 1000000", function(Value)
    selectrock = "Legend Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 1000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 1000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Королевский камень - 5000000", function(Value)
    selectrock = "Muscle King Gym Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 5000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 5000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

autoRockFolder:AddSwitch("Камень в Джунглях 10000000", function(Value)
    selectrock = "Ancient Jungle Rock"
    getgenv().autoFarm = Value
    
    task.spawn(function()
        while getgenv().autoFarm do
            task.wait()
            if not getgenv().autoFarm then break end
            
            if game:GetService("Players").LocalPlayer.Durability.Value >= 10000000 then
                for i, v in pairs(game:GetService("Workspace").machinesFolder:GetDescendants()) do
                    if v.Name == "neededDurability" and v.Value == 10000000 and game.Players.LocalPlayer.Character:FindFirstChild("LeftHand") and game.Players.LocalPlayer.Character:FindFirstChild("RightHand") then
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

local rebirthsFolder = farmPlusTab:AddFolder("Перерождения")

-- Target rebirth input - direct text input
rebirthsFolder:AddTextBox("Сколько нужно?", function(text)
    local newValue = tonumber(text)
    if newValue and newValue > 0 then
        targetRebirthValue = newValue
        updateStats() -- Call the stats update function
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Понял",
            Text = "Остановлю когда будет (targetRebirthValue) .. " перерождений",
            Duration = 0
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Всё",
            Text = "Остановил как и обещал",
            Duration = 0
        })
    end
end)

-- Create toggle switches
local infiniteSwitch -- Forward declaration

local targetSwitch = rebirthsFolder:AddSwitch("Начать перерождется по твоему количеству", function(bool)
    _G.targetRebirthActive = bool
    
    if bool then
        -- Turn off infinite rebirth if it's on
        if _G.infiniteRebirthActive and infiniteSwitch then
            infiniteSwitch:Set(false)
            _G.infiniteRebirthActive = false
        end
        
        -- Start target rebirth loop
        spawn(function()
            while _G.targetRebirthActive and wait(0.1) do
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                
                if currentRebirths >= targetRebirthValue then
                    targetSwitch:Set(false)
                    _G.targetRebirthActive = false
                    
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Ооо",
                        Text = "Пошло дело пошло",
                        Duration = 5
                    })
                    
                    break
                end
                
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "Renacimiento automático hasta alcanzar el objetivo")

infiniteSwitch = rebirthsFolder:AddSwitch("Перерождатся бесконечно", function(bool)
    _G.infiniteRebirthActive = bool
    
    if bool then
        -- Turn off target rebirth if it's on
        if _G.targetRebirthActive and targetSwitch then
            targetSwitch:Set(false)
            _G.targetRebirthActive = false
        end
        
        -- Start infinite rebirth loop
        spawn(function()
            while _G.infiniteRebirthActive and wait(0.1) do
                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end
        end)
    end
end, "Renacimiento continuo sin parar")

local sizeSwitch = rebirthsFolder:AddSwitch("Всегда рост 1", function(bool)
    _G.autoSizeActive = bool
    
    if bool then
        spawn(function()
            while _G.autoSizeActive and wait() do
                game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
            end
        end)
    end
end, "Establece el tamaño del personaje a 1 continuamente")

local teleportSwitch = rebirthsFolder:AddSwitch("Телепортироватся в короля", function(bool)
    _G.teleportActive = bool
    
    if bool then
        spawn(function()
            while _G.teleportActive and wait() do
                if game.Players.LocalPlayer.Character then
                    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                end
            end
        end)
    end
end, "Teletransporte continuo al Rey Músculo")

local autoEquipToolsFolder = farmPlusTab:AddFolder("Автоматически качатся")

-- Free AutoLift Gamepass Button
autoEquipToolsFolder:AddButton("Автолифт", function()
    local gamepassFolder = game:GetService("ReplicatedStorage").gamepassIds
    local player = game:GetService("Players").LocalPlayer
    for _, gamepass in pairs(gamepassFolder:GetChildren()) do
        local value = Instance.new("IntValue")
        value.Name = gamepass.Name
        value.Value = gamepass.Value
        value.Parent = player.ownedGamepasses
    end
end, "Desbloquea el gamepass de AutoLift gratis")

-- Auto Weight Toggle
autoEquipToolsFolder:AddSwitch("Авто гантеля", function(Value)
    _G.AutoWeight = Value
    
    if Value then
        local weightTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
        if weightTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(weightTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Weight")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoWeight do
            if not _G.AutoWeight then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Levanta pesas automáticamente")

-- Auto Pushups Toggle
autoEquipToolsFolder:AddSwitch("Авто отжимания", function(Value)
    _G.AutoPushups = Value
    
    if Value then
        local pushupsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Pushups")
        if pushupsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(pushupsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Pushups")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoPushups do
            if not _G.AutoPushups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Haz flexiones automáticamente")

-- Auto Handstands Toggle
autoEquipToolsFolder:AddSwitch("Авто отжимания стоя на руках", function(Value)
    _G.AutoHandstands = Value
    
    if Value then
        local handstandsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Handstands")
        if handstandsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(handstandsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Handstands")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoHandstands do
            if not _G.AutoHandstands then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Haz paradas de manos automáticamente")

-- Auto Situps Toggle
autoEquipToolsFolder:AddSwitch("Авто пресс", function(Value)
    _G.AutoSitups = Value
    
    if Value then
        local situpsTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Situps")
        if situpsTool then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(situpsTool)
        end
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Situps")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    
    task.spawn(function()
        while _G.AutoSitups do
            if not _G.AutoSitups then break end
            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            task.wait(0.1)
        end
    end)
end, "Haz abdominales automáticamente")

-- Auto Punch Toggle
autoEquipToolsFolder:AddSwitch("Авто удары", function(Value)
    _G.fastHitActive = Value
    
    if Value then
        -- Function to equip and modify punch
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                local punch = player.Backpack:FindFirstChild("Punch")
                if punch then
                    punch.Parent = player.Character
                    if punch:FindFirstChild("attackTime") then
                        punch.attackTime.Value = 0
                    end
                end
                task.wait(0.1)
            end
        end)
        
        -- Function for rapid punching
        task.spawn(function()
            while _G.fastHitActive do
                if not _G.fastHitActive then break end
                
                local player = game.Players.LocalPlayer
                player.muscleEvent:FireServer("punch", "rightHand")
                player.muscleEvent:FireServer("punch", "leftHand")
                
                local character = player.Character
                if character then
                    local punchTool = character:FindFirstChild("Punch")
                    if punchTool then
                        punchTool:Activate()
                    end
                end
                task.wait(0)
            end
        end)
    else
        local character = game.Players.LocalPlayer.Character
        local equipped = character:FindFirstChild("Punch")
        if equipped then
            equipped.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end, "Golpea automáticamente")

-- Fast Tools Toggle
autoEquipToolsFolder:AddSwitch("Быстрые предметы", function(Value)
    _G.FastTools = Value
    
    local defaultSpeeds = {
        {
            "Punch",
            "attackTime",
            Value and 0 or 0.35
        },
        {
            "Ground Slam",
            "attackTime",
            Value and 0 or 6
        },
        {
            "Stomp",
            "attackTime",
            Value and 0 or 7
        },
        {
            "Handstands",
            "repTime",
            Value and 0 or 1
        },
        {
            "Pushups",
            "repTime",
            Value and 0 or 1
        },
        {
            "Weight",
            "repTime",
            Value and 0 or 1
        },
        {
            "Situps",
            "repTime",
            Value and 0 or 1
        }
    }
    
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")
    
    for _, toolInfo in ipairs(defaultSpeeds) do
        local tool = backpack:FindFirstChild(toolInfo[1])
        if tool and tool:FindFirstChild(toolInfo[2]) then
            tool[toolInfo[2]].Value = toolInfo[3]
        end
        
        local equippedTool = player.Character and player.Character:FindFirstChild(toolInfo[1])
        if equippedTool and equippedTool:FindFirstChild(toolInfo[2]) then
            equippedTool[toolInfo[2]].Value = toolInfo[3]
        end
    end
end, "Acelera todas las herramientas")

-- Inicializar variables de seguimiento
local sessionStartTime = os.time()
local sessionStartStrength = 0
local sessionStartDurability = 0
local sessionStartKills = 0
local sessionStartRebirths = 0
local sessionStartBrawls = 0
local hasStartedTracking = false

-- Crear una carpeta en farmPlusTab para estadísticas
local statsFolder = farmPlusTab:AddFolder("Stats")

-- Crear etiquetas para las estadísticas solicitadas
statsFolder:AddLabel("Сила")
local strengthStatsLabel = statsFolder:AddLabel("Статы...")
local strengthGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Долговечность")
local durabilityStatsLabel = statsFolder:AddLabel("Статы...")
local durabilityGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Перерождения")
local rebirthsStatsLabel = statsFolder:AddLabel("Статы...")
local rebirthsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Убийства")
local killsStatsLabel = statsFolder:AddLabel("Статы...")
local killsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Поединки")
local brawlsStatsLabel = statsFolder:AddLabel("Статы...")
local brawlsGainLabel = statsFolder:AddLabel("Достиг: 0")

statsFolder:AddLabel("Время")
local sessionTimeLabel = statsFolder:AddLabel("Время: 00:00:00")

-- Función para formatear números
local function formatNumber(number)
    if number >= 1e15 then return string.format("%.2fQ", number/1e15)
    elseif number >= 1e12 then return string.format("%.2fT", number/1e12)
    elseif number >= 1e9 then return string.format("%.2fB", number/1e9)
    elseif number >= 1e6 then return string.format("%.2fM", number/1e6)
    elseif number >= 1e3 then return string.format("%.2fK", number/1e3)
    end
    return tostring(math.floor(number))
end

local function formatNumberWithCommas(number)
    local formatted = tostring(math.floor(number))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
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

-- Inicializar seguimiento
local function startTracking()
    if not hasStartedTracking then
        local player = game.Players.LocalPlayer
        sessionStartStrength = player.leaderstats.Strength.Value
        sessionStartDurability = player.Durability.Value
        sessionStartKills = player.leaderstats.Kills.Value
        sessionStartRebirths = player.leaderstats.Rebirths.Value
        sessionStartBrawls = player.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end
end

-- Función para actualizar estadísticas
local function updateStats()
    local player = game.Players.LocalPlayer
    
    -- Iniciar seguimiento si aún no ha comenzado
    if not hasStartedTracking then
        startTracking()
    end
    
    -- Calcular valores actuales y ganancias
    local currentStrength = player.leaderstats.Strength.Value
    local currentDurability = player.Durability.Value
    local currentKills = player.leaderstats.Kills.Value
    local currentRebirths = player.leaderstats.Rebirths.Value
    local currentBrawls = player.leaderstats.Brawls.Value
    
    local strengthGain = currentStrength - sessionStartStrength
    local durabilityGain = currentDurability - sessionStartDurability
    local killsGain = currentKills - sessionStartKills
    local rebirthsGain = currentRebirths - sessionStartRebirths
    local brawlsGain = currentBrawls - sessionStartBrawls
    
    -- Actualizar valores de estadísticas actuales
    strengthStatsLabel.Text = string.format("Actual: %s", formatNumber(currentStrength))
    durabilityStatsLabel.Text = string.format("Actual: %s", formatNumber(currentDurability))
    rebirthsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentRebirths))
    killsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentKills))
    brawlsStatsLabel.Text = string.format("Actual: %s", formatNumber(currentBrawls))
    
    -- Actualizar valores de ganancias
    strengthGainLabel.Text = string.format("Gained: %s", formatNumber(strengthGain))
    durabilityGainLabel.Text = string.format("Gained: %s", formatNumber(durabilityGain))
    rebirthsGainLabel.Text = string.format("Gained: %s", formatNumber(rebirthsGain))
    killsGainLabel.Text = string.format("Gained: %s", formatNumber(killsGain))
    brawlsGainLabel.Text = string.format("Gained: %s", formatNumber(brawlsGain))
    
    -- Actualizar tiempo de sesión
    local elapsedTime = os.time() - sessionStartTime
    local timeString = formatTime(elapsedTime)
    sessionTimeLabel.Text = string.format("Time: %s", timeString)
end

-- Actualizar estadísticas inicialmente
updateStats()

-- Actualizar estadísticas cada 2 segundos
spawn(function()
    while wait(2) do
        updateStats()
    end
end)

-- Agregar botones para funcionalidades adicionales
statsFolder:AddButton("Очистить статистику", function()
    local player = game.Players.LocalPlayer
    sessionStartStrength = player.leaderstats.Strength.Value
    sessionStartDurability = player.Durability.Value
    sessionStartKills = player.leaderstats.Kills.Value
    sessionStartRebirths = player.leaderstats.Rebirths.Value
    sessionStartBrawls = player.leaderstats.Brawls.Value
    sessionStartTime = os.time()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Готово",
        Text = "Ты очистил",
        Duration = 0
    })
end)

statsFolder:AddButton("Скопировать", function()
    local player = game.Players.LocalPlayer
    local statsText = "Muscle Legends:\n\n"
    
    statsText = statsText .. "Сила: " .. formatNumberWithCommas(player.leaderstats.Strength.Value) .. "\n"
    statsText = statsText .. "Долговечность: " .. formatNumberWithCommas(player.Durability.Value) .. "\n"
    statsText = statsText .. "Перерождения: " .. formatNumberWithCommas(player.leaderstats.Rebirths.Value) .. "\n"
    statsText = statsText .. "Убийства: " .. formatNumberWithCommas(player.leaderstats.Kills.Value) .. "\n"
    statsText = statsText .. "Поединки: " .. formatNumberWithCommas(player.leaderstats.Brawls.Value) .. "\n\n"
    
    -- Agregar estadísticas de sesión si el seguimiento ha comenzado
    if hasStartedTracking then
        local elapsedTime = os.time() - sessionStartTime
        local strengthGain = player.leaderstats.Strength.Value - sessionStartStrength
        local durabilityGain = player.Durability.Value - sessionStartDurability
        local killsGain = player.leaderstats.Kills.Value - sessionStartKills
        local rebirthsGain = player.leaderstats.Rebirths.Value - sessionStartRebirths
        local brawlsGain = player.leaderstats.Brawls.Value - sessionStartBrawls
        
        statsText = statsText .. "--- Estadísticas de Sesión ---\n"
        statsText = statsText .. "Time Of Session: " .. formatTime(elapsedTime) .. "\n"
        statsText = statsText .. "Strength Gained: " .. formatNumberWithCommas(strengthGain) .. "\n"
        statsText = statsText .. "Durability Gained: " .. formatNumberWithCommas(durabilityGain) .. "\n"
        statsText = statsText .. "Rebirths Gained: " .. formatNumberWithCommas(rebirthsGain) .. "\n"
        statsText = statsText .. "Kills Gained: " .. formatNumberWithCommas(killsGain) .. "\n"
        statsText = statsText .. "Brawls Gained: " .. formatNumberWithCommas(brawlsGain) .. "\n"
    end
    
    setclipboard(statsText)
end)

local pets = window:AddTab("Петы")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Pet section
pets:AddLabel("Петы")

-- Create pet dropdown with the correct format
local selectedPet = "Neon Guardian" -- Default selection
local petDropdown = pets:AddDropdown("Выбери пета", function(text)
    selectedPet = text
    print("Mascota seleccionada: " .. text)
end)

-- Add pet options
petDropdown:Add("Neon Guardian")
petDropdown:Add("Blue Birdie")
petDropdown:Add("Blue Bunny")
petDropdown:Add("Blue Firecaster")
petDropdown:Add("Blue Pheonix")
petDropdown:Add("Crimson Falcon")
petDropdown:Add("Cybernetic Showdown Dragon")
petDropdown:Add("Dark Golem")
petDropdown:Add("Dark Legends Manticore")
petDropdown:Add("Dark Vampy")
petDropdown:Add("Darkstar Hunter")
petDropdown:Add("Eternal Strike Leviathan")
petDropdown:Add("Frostwave Legends Penguin")
petDropdown:Add("Gold Warrior")
petDropdown:Add("Golden Pheonix")
petDropdown:Add("Golden Viking")
petDropdown:Add("Green Butterfly")
petDropdown:Add("Green Firecaster")
petDropdown:Add("Infernal Dragon")
petDropdown:Add("Lightning Strike Phantom")
petDropdown:Add("Magic Butterfly")
petDropdown:Add("Muscle Sensei")
petDropdown:Add("Orange Hedgehog")
petDropdown:Add("Orange Pegasus")
petDropdown:Add("Phantom Genesis Dragon")
petDropdown:Add("Purple Dragon")
petDropdown:Add("Purple Falcon")
petDropdown:Add("Red Dragon")
petDropdown:Add("Red Firecaster")
petDropdown:Add("Red Kitty")
petDropdown:Add("Silver Dog")
petDropdown:Add("Ultimate Supernova Pegasus")
petDropdown:Add("Ultra Birdie")
petDropdown:Add("White Pegasus")
petDropdown:Add("White Pheonix")
petDropdown:Add("Yellow Butterfly")

-- Auto open pet toggle
pets:AddSwitch("Купить", function(bool)
    _G.AutoHatchPet = bool
    
    if bool then
        spawn(function()
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

-- Aura section
pets:AddLabel("Ауры")

-- Create aura dropdown with the correct format
local selectedAura = "Blue Aura" -- Default selection
local auraDropdown = pets:AddDropdown("Выбери ауру", function(text)
    selectedAura = text
    print("Aura seleccionada: " .. text)
end)

-- Add aura options
auraDropdown:Add("Astral Electro")
auraDropdown:Add("Azure Tundra")
auraDropdown:Add("Blue Aura")
auraDropdown:Add("Dark Electro")
auraDropdown:Add("Dark Lightning")
auraDropdown:Add("Dark Storm")
auraDropdown:Add("Electro")
auraDropdown:Add("Enchanted Mirage")
auraDropdown:Add("Entropic Blast")
auraDropdown:Add("Eternal Megastrike")
auraDropdown:Add("Grand Supernova")
auraDropdown:Add("Green Aura")
auraDropdown:Add("Inferno")
auraDropdown:Add("Lightning")
auraDropdown:Add("Muscle King")
auraDropdown:Add("Power Lightning")
auraDropdown:Add("Purple Aura")
auraDropdown:Add("Purple Nova")
auraDropdown:Add("Red Aura")
auraDropdown:Add("Supernova")
auraDropdown:Add("Ultra Inferno")
auraDropdown:Add("Ultra Mirage")
auraDropdown:Add("Unstable Mirage")
auraDropdown:Add("Yellow Aura")

-- Auto open aura toggle
pets:AddSwitch("Купить", function(bool)
    _G.AutoHatchAura = bool
    
    if bool then
        spawn(function()
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

-- Create the Misc tab
local miscTab = window:AddTab("")

-- Create the first folder
local misc1Folder = miscTab:AddFolder("Остальное")

-- Add ad removal button to Misc 1
misc1Folder:AddButton("Очистить порталы", function()
    -- Remove existing ad portals
    for _, portal in pairs(game:GetDescendants()) do
        if portal.Name == "RobloxForwardPortals" then
            portal:Destroy()
        end
    end
    
    -- Set up connection to remove future ad portals
    if _G.AdRemovalConnection then
        _G.AdRemovalConnection:Disconnect()
    end
    
    _G.AdRemovalConnection = game.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "RobloxForwardPortals" then
            descendant:Destroy()
        end
    end)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Та!",
        Text = "Бум!",
        Duration = 0
    })
end)

-- Walk on Water feature
local parts = {}
local partSize = 2048
local totalDistance = 50000
local startPosition = Vector3.new(-2, -9.5, -2)
local numberOfParts = math.ceil(totalDistance / partSize)

local function createParts()
    for x = 0, numberOfParts - 1 do
        for z = 0, numberOfParts - 1 do
            local newPartSide = Instance.new("Part")
            newPartSide.Size = Vector3.new(partSize, 1, partSize)
            newPartSide.Position = startPosition + Vector3.new(x * partSize, 0, z * partSize)
            newPartSide.Anchored = true
            newPartSide.Transparency = 1
            newPartSide.CanCollide = true
            newPartSide.Name = "Part_Side_" .. x .. "_" .. z
            newPartSide.Parent = workspace
            table.insert(parts, newPartSide)
            
            local newPartLeftRight = Instance.new("Part")
            newPartLeftRight.Size = Vector3.new(partSize, 1, partSize)
            newPartLeftRight.Position = startPosition + Vector3.new(-x * partSize, 0, z * partSize)
            newPartLeftRight.Anchored = true
            newPartLeftRight.Transparency = 1
            newPartLeftRight.CanCollide = true
            newPartLeftRight.Name = "Part_LeftRight_" .. x .. "_" .. z
            newPartLeftRight.Parent = workspace
            table.insert(parts, newPartLeftRight)
            
            local newPartUpLeft = Instance.new("Part")
            newPartUpLeft.Size = Vector3.new(partSize, 1, partSize)
            newPartUpLeft.Position = startPosition + Vector3.new(-x * partSize, 0, -z * partSize)
            newPartUpLeft.Anchored = true
            newPartUpLeft.Transparency = 1
            newPartUpLeft.CanCollide = true
            newPartUpLeft.Name = "Part_UpLeft_" .. x .. "_" .. z
            newPartUpLeft.Parent = workspace
            table.insert(parts, newPartUpLeft)
            
            local newPartUpRight = Instance.new("Part")
            newPartUpRight.Size = Vector3.new(partSize, 1, partSize)
            newPartUpRight.Position = startPosition + Vector3.new(x * partSize, 0, -z * partSize)
            newPartUpRight.Anchored = true
            newPartUpRight.Transparency = 1
            newPartUpRight.CanCollide = true
            newPartUpRight.Name = "Part_UpRight_" .. x .. "_" .. z
            newPartUpRight.Parent = workspace
            table.insert(parts, newPartUpRight)
        end
    end
end

local function makePartsWalkthrough()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = false
        end
    end
end

local function makePartsSolid()
    for _, part in ipairs(parts) do
        if part and part.Parent then
            part.CanCollide = true
        end
    end
end

-- Add Walk on Water toggle
misc1Folder:AddSwitch("Бег по воде", function(bool)
    if bool then
        createParts()
    else
        makePartsWalkthrough()
    end
end)

-- Add Auto Spin Wheel toggle
misc1Folder:AddSwitch("Авто прокрутка колеса удачи", function(bool)
    _G.AutoSpinWheel = bool
    
    if bool then
        spawn(function()
            while _G.AutoSpinWheel and wait(1) do
                game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances["Fortune Wheel"])
            end
        end)
    end
end)

-- Add Auto Claim Gifts toggle
misc1Folder:AddSwitch("Авто сбор подарков", function(bool)
    _G.AutoClaimGifts = bool
    
    if bool then
        spawn(function()
            while _G.AutoClaimGifts and wait(1) do
                for i = 1, 8 do
                    game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                end
            end
        end)
    end
end)


-- Variable to store the position lock connection
local positionLockConnection = nil

-- Function to lock player position
local function lockPlayerPosition(position)
    if positionLockConnection then
        positionLockConnection:Disconnect()
    end
    
    positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = position
        end
    end)
end

-- Function to unlock player position
local function unlockPlayerPosition()
    if positionLockConnection then
        positionLockConnection:Disconnect()
        positionLockConnection = nil
    end
end

-- Add position lock toggle
rebirthFarmFolder:AddSwitch("Стоять на одном месте", function(bool)
    if bool then
        -- Get current position and lock it
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentPosition = player.Character.HumanoidRootPart.CFrame
            lockPlayerPosition(currentPosition)
        end
    else
        -- Unlock position
        unlockPlayerPosition()
    end
end)

local frameToggle = rebirthFarmFolder:AddSwitch("Скрывть рамки", function(bool)
    local rSto = game:GetService("ReplicatedStorage")
    for _, obj in pairs(rSto:GetChildren()) do
        if obj.Name:match("Frame$") then
            obj.Visible = not bool
        end
    end
end)

local speedGrind = rebirthFarmFolder:AddSwitch("Быстрая сила", function(bool)
    local isGrinding = bool
    
    if not bool then
        unequipAllPets()
        return
    end
    
    equipUniquePet("Swift Samurai")
    
    for i = 1, 14 do
        task.spawn(function()
            while isGrinding do
                player.muscleEvent:FireServer("rep")
                task.wait()
            end
        end)
    end
end)


local killerTab = window:AddTab("Убийства")


_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

-- Improved character checking function with timeout
local function checkCharacter()
    local player = game.Players.LocalPlayer
    
    if not player then
        return nil
    end
    
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        -- Wait for character to load, but with a timeout
        local startTime = tick()
        repeat
            task.wait(0.1)
            -- If waiting too long (5 seconds), give up
            if tick() - startTime > 5 then
                return nil
            end
        until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    end
    
    return player.Character
end

-- Improved tool equipping function with error handling
local function gettool()
    pcall(function()
        -- Check if we have a character and humanoid
        if not game.Players.LocalPlayer.Character or 
           not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            return
        end
        
        -- Try to equip the punch tool
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.Name == "Punch" then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                break
            end
        end
        
        -- Fire the punch events
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
    end)
end

-- Improved kill player function with better error handling
local function killPlayer(target)
    -- Make sure we have our own character
    local character = checkCharacter()
    if not character then return end
    
    -- Make sure target has a character
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    -- Make sure we have the necessary parts
    if not character:FindFirstChild("LeftHand") then
        return
    end
    
    -- Try to kill the player
    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 0)
        task.wait(0.01) -- Small wait to ensure the touch registers
        firetouchinterest(target.Character.HumanoidRootPart, character.LeftHand, 1)
        gettool()
    end)
end

-- Player finding function with improved matching
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

local whitelistedPlayersLabel = killerTab:AddLabel("Белый список: Нету")
local targetPlayerLabel = killerTab:AddLabel("Атаковать игрока: Нету")

-- Update UI functions
local function updateWhitelistedPlayersLabel()
    if #_G.whitelistedPlayers == 0 then
        whitelistedPlayersLabel.Text = "Белый список: Нету"
    else
        local displayText = "Players on the White List: "
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

-- Auto-whitelist friends feature
local autoWhitelistFriendsSwitch = killerTab:AddSwitch("Автоматом друзей в белый список", function(bool)
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

-- Handle new players joining
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

-- Whitelist management UI
killerTab:AddTextBox("Добавить в белый список (ник)", function(text)
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

killerTab:AddTextBox("Удалить с белого списка (ник)", function(text)
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

killerTab:AddButton("Очистить белый список", function()
    _G.whitelistedPlayers = {}
    updateWhitelistedPlayersLabel()
end)

-- Improved auto-kill all feature with better error handling and reliability
local autoKillAllSwitch = killerTab:AddSwitch("Убивать всех (кроме тех,кто в белом списке)", function(bool)
    _G.autoKillAll = bool
    
    if bool then
        spawn(function()
            while _G.autoKillAll do
                pcall(function()
                    local players = game:GetService("Players"):GetPlayers()
                    
                    for _, player in ipairs(players) do
                        if player == game.Players.LocalPlayer or not _G.autoKillAll then
                            continue
                        end
                        
                        -- Check if player is whitelisted
                        local isWhitelisted = false
                        for _, whitelistedInfo in ipairs(_G.whitelistedPlayers) do
                            if whitelistedInfo:find(player.Name, 1, true) then
                                isWhitelisted = true
                                break
                            end
                        end
                        
                        -- Only kill if not whitelisted and has a character
                        if not isWhitelisted and player.Character and 
                           player.Character:FindFirstChild("HumanoidRootPart") and
                           player.Character:FindFirstChild("Humanoid") and
                           player.Character.Humanoid.Health > 0 then
                            
                            -- Try to kill the player with error handling
                            pcall(function()
                                killPlayer(player)
                            end)
                            
                            -- Small wait between kills to prevent overload
                            task.wait(0.05)
                        end
                    end
                end)
                
                -- Wait a bit before the next cycle, but not too long
                task.wait(0.2)
            end
        end)
    end
end)

-- Target player management
killerTab:AddTextBox("Убивать кого: (ник)", function(text)
    if text and text ~= "" then
        local player = findClosestPlayer(text)
        if player then
            _G.targetPlayer = player.Name .. " (" .. player.DisplayName .. ")"
            updateTargetPlayerLabel()
        end
    end
end)

killerTab:AddButton("Очистить убийство", function()
    _G.targetPlayer = ""
    updateTargetPlayerLabel()
end)

-- Improved auto-kill target feature
local autoKillTargetSwitch = killerTab:AddSwitch("Убийство выбранного", function(bool)
    _G.autoKillTarget = bool
    
    if bool and _G.targetPlayer ~= "" then
        spawn(function()
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

-- Manual kill buttons
killerTab:AddButton("Очистить всё (кроме белого списка)", function()
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

killerTab:AddButton("Удалить куклу для киллов", function()
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

-- Initialize UI
updateWhitelistedPlayersLabel()
updateTargetPlayerLabel()



local teleportTab = window:AddTab("Телепорт")

teleportTab:AddButton("Спавн", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2, 8, 115)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Прямиком на спавн",
        Duration = 0
    })
end)

teleportTab:AddButton("Секретная арена", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(1947, 2, 6191)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "У-хх СЕКРЕТ!",
        Duration = 0
    })
end)

teleportTab:AddButton("Маленький остров 0-1к", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-34, 7, 1903)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это для тебя малыш",
        Duration = 0
    })
end)

teleportTab:AddButton("Ледяной зал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(- 2600.00244, 3.67686558, - 403.884369, 0.0873617008, 1.0482899e-09, 0.99617666, 3.07204253e-08, 1, - 3.7464023e-09, - 0.99617666, 3.09302628e-08, 0.0873617008)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тут холодновато",
        Duration = 0
    })
end)

teleportTab:AddButton("Мифический портал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(2255, 7, 1071)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Вот это Да,Мистика!",
        Duration = 0
    })
end)

teleportTab:AddButton("Адский портал", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-6768, 7, -1287)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Жарковье,прям под сатану",
        Duration = 0
    })
end)

teleportTab:AddButton("Легендарный остров", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4604, 991, -3887)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тихо!Он только для легенд",
        Duration = 0
    })
end)

teleportTab:AddButton("Портал мускульного короля", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8646, 17, -5738)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Ты на стояке у Роналдо,двойная сила!",
        Duration = 0
    })
end)

teleportTab:AddButton("Джунгли", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-8659, 6, 2384)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Алё,надо побрить,тут уже обезьянки бегают",
        Duration = 0
    })
end)

teleportTab:AddButton("Бой в лаве", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(4471, 119, -8836)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это бой в лаве",
        Duration = 0
    })
end)

teleportTab:AddButton("Бой в пустыне", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(960, 17, -7398)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Это бой в песчанике",
        Duration = 0
    })
end)

teleportTab:AddButton("Бой на ринге", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoidRootPart.CFrame = CFrame.new(-1849, 20, -6335)
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Телепорт",
        Text = "Тебе завидует Майк Тайсон",
        Duration = 0
    })
end)

local noteTab = window:AddTab("Создатели")

-- Add a decorative header with centered text
noteTab:AddLabel("Private Script")

-- Add spacers for better layout
noteTab:AddLabel("")
-- Instead of one large text block, let's add each paragraph separately
-- This gives better control over formatting
noteTab:AddLabel("Созданно vanegood,")