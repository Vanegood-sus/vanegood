-- Muscle Legends GUI Ported to Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local startTime = os.time()
local startRebirths = player.leaderstats and player.leaderstats:FindFirstChild("Rebirths") and player.leaderstats.Rebirths.Value or 0
local displayName = player.DisplayName

-- Anti-AFK System
local VirtualUser = game:GetService("VirtualUser")
local antiAFKConnection

local function setupAntiAFK()
    if antiAFKConnection then
        antiAFKConnection:Disconnect()
    end
    antiAFKConnection = player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("Анти-Афк")
    end)
    print("Включено Анти-Афк")
end

setupAntiAFK()

-- Window Creation
local Window = Rayfield:CreateWindow({
   Name = "Muscle Legends",
   LoadingTitle = "vanegood script",
   LoadingSubtitle = "by vanegood",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "MuscleLegendsConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false
})

-- Tabs
local mainTab = Window:CreateTab("Меню", 4483362458)
local farmPlusTab = Window:CreateTab("Фарм", 4483362458)
local petsTab = Window:CreateTab("Петы", 4483362458)
local killerTab = Window:CreateTab("Убийства", 4483362458)
local teleportTab = Window:CreateTab("Телепорт", 4483362458)
local miscTab = Window:CreateTab("Другое", 4483362458)
local noteTab = Window:CreateTab("Создатель", 4483362458)

----------------------------------------------------
-- MAIN TAB (МЕНЮ)
----------------------------------------------------
mainTab:CreateLabel("Добро Пожаловать!")

mainTab:CreateToggle({
   Name = "Анти-Афк",
   CurrentValue = true,
   Flag = "AntiAFKToggle",
   Callback = function(bool)
      if bool then
          setupAntiAFK()
      else
          if antiAFKConnection then
              antiAFKConnection:Disconnect()
              antiAFKConnection = nil
              print("Anti-AFK system disabled")
          end
      end
   end,
})

mainTab:CreateSection("Авто бой")

local whitelist = {}

mainTab:CreateToggle({
   Name = "Авто выйгрыш",
   CurrentValue = false,
   Flag = "AutoWinBrawlToggle",
   Callback = function(bool)
      getgenv().autoWinBrawl = bool
      
      local function equipPunch()
          if not getgenv().autoWinBrawl then return end
          local character = player.Character
          if not character then return false end
          if character:FindFirstChild("Punch") then return true end
          local backpack = player.Backpack
          if not backpack then return false end
          for _, tool in pairs(backpack:GetChildren()) do
              if tool.ClassName == "Tool" and tool.Name == "Punch" then
                  tool.Parent = character
                  return true
              end
          end
          return false
      end
      
      local function isValidTarget(p)
          if not p or not p.Parent then return false end
          if p == player then return false end
          if whitelist[p.UserId] then return false end
          local char = p.Character
          if not char or not char.Parent then return false end
          local hum = char:FindFirstChild("Humanoid")
          if not hum or hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Dead then return false end
          local root = char:FindFirstChild("HumanoidRootPart")
          if not root or not root.Parent then return false end
          return true
      end
      
      local function isLocalPlayerReady()
          local char = player.Character
          if not char or not char.Parent then return false end
          local hum = char:FindFirstChild("Humanoid")
          if not hum or hum.Health <= 0 then return false end
          return (char:FindFirstChild("LeftHand") ~= nil or char:FindFirstChild("RightHand") ~= nil)
      end
      
      local function safeTouchInterest(targetPart, localPart)
          if not targetPart or not targetPart.Parent or not localPart or not localPart.Parent then return false end
          return pcall(function()
              firetouchinterest(targetPart, localPart, 0)
              task.wait(0.01)
              firetouchinterest(targetPart, localPart, 1)
          end)
      end
      
      task.spawn(function()
          while getgenv().autoWinBrawl and task.wait(0.5) do
              if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                  ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                  player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
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
              if isLocalPlayerReady() and ReplicatedStorage.brawlInProgress.Value then
                  pcall(function() player.muscleEvent:FireServer("punch", "rightHand") end)
                  pcall(function() player.muscleEvent:FireServer("punch", "leftHand") end)
              end
          end
      end)
      
      task.spawn(function()
          while getgenv().autoWinBrawl and task.wait(0.05) do
              if isLocalPlayerReady() and ReplicatedStorage.brawlInProgress.Value then
                  local character = player.Character
                  local leftHand = character:FindFirstChild("LeftHand")
                  local rightHand = character:FindFirstChild("RightHand")
                  
                  for _, p in pairs(Players:GetPlayers()) do
                      if not getgenv().autoWinBrawl then break end
                      pcall(function()
                          if isValidTarget(p) then
                              local targetRoot = p.Character.HumanoidRootPart
                              if leftHand then safeTouchInterest(targetRoot, leftHand) end
                              if rightHand then safeTouchInterest(targetRoot, rightHand) end
                          end
                      end)
                      task.wait(0.01)
                  end
              end
          end
      end)
   end,
})

mainTab:CreateToggle({
   Name = "Автоматом вступать в бой",
   CurrentValue = false,
   Flag = "AutoJoinBrawlToggle",
   Callback = function(bool)
      getgenv().autoJoinBrawl = bool
      task.spawn(function()
          while getgenv().autoJoinBrawl and task.wait(0.5) do
              if player.PlayerGui.gameGui.brawlJoinLabel.Visible then
                  ReplicatedStorage.rEvents.brawlEvent:FireServer("joinBrawl")
                  player.PlayerGui.gameGui.brawlJoinLabel.Visible = false
              end
          end
      end)
   end,
})

mainTab:CreateSection("Залы")

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

local function teleportAndStart(workoutType, position)
    if not position then return end
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = position
    
    Rayfield:Notify({Title = "Телепорт", Content = "Teleported to " .. workoutType .. " gym", Duration = 3})
    
    task.spawn(function()
        while getgenv().workingGym do
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
            task.wait(0.1)
        end
    end)
end

for _, workoutType in ipairs(workoutTypes) do
    local selectedGymName = gymLocations[1]
    
    mainTab:CreateDropdown({
       Name = workoutType .. " - Зал",
       Options = gymLocations,
       CurrentOption = {gymLocations[1]},
       MultipleOptions = false,
       Flag = workoutType .. "GymDropdown",
       Callback = function(Option)
          selectedGymName = Option[1] or Option
       end,
    })
    
    mainTab:CreateToggle({
       Name = workoutType,
       CurrentValue = false,
       Flag = workoutType .. "GymToggle",
       Callback = function(bool)
          getgenv().workingGym = bool
          if bool then
              if workoutPositions[workoutType] and workoutPositions[workoutType][selectedGymName] then
                  teleportAndStart(workoutType, workoutPositions[workoutType][selectedGymName])
              else
                  Rayfield:Notify({Title = "Error", Content = "Position not found for " .. workoutType .. " in " .. selectedGymName, Duration = 5})
              end
          end
       end,
    })
end

mainTab:CreateSection("Остальное")

mainTab:CreateToggle({
   Name = "Анти отбрасывание",
   CurrentValue = false,
   Flag = "AntiKnockbackToggle",
   Callback = function(Value)
      local char = player.Character
      if not char then return end
      local rootPart = char:FindFirstChild("HumanoidRootPart")
      if not rootPart then return end
      
      if Value then
          local bodyVelocity = Instance.new("BodyVelocity")
          bodyVelocity.Name = "AntiKBVelocity"
          bodyVelocity.MaxForce = Vector3.new(100000, 0, 100000)
          bodyVelocity.Velocity = Vector3.new(0, 0, 0)
          bodyVelocity.P = 1250
          bodyVelocity.Parent = rootPart
      else
          local existingVelocity = rootPart:FindFirstChild("AntiKBVelocity")
          if existingVelocity then existingVelocity:Destroy() end
      end
   end,
})

local positionLockConnection = nil
mainTab:CreateToggle({
   Name = "Стоять на месте",
   CurrentValue = false,
   Flag = "LockPosToggle",
   Callback = function(bool)
      if bool then
          if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
              local currentPos = player.Character.HumanoidRootPart.CFrame
              if positionLockConnection then positionLockConnection:Disconnect() end
              positionLockConnection = game:GetService("RunService").Heartbeat:Connect(function()
                  if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                      player.Character.HumanoidRootPart.CFrame = currentPos
                  end
              end)
          end
      else
          if positionLockConnection then
              positionLockConnection:Disconnect()
              positionLockConnection = nil
          end
      end
   end,
})

mainTab:CreateToggle({
   Name = "Скрывать рамки",
   CurrentValue = false,
   Flag = "HideFramesToggle",
   Callback = function(bool)
      for _, obj in pairs(ReplicatedStorage:GetChildren()) do
          if obj.Name:match("Frame$") then
              obj.Visible = not bool
          end
      end
   end,
})

mainTab:CreateToggle({
   Name = "Быстрая сила",
   CurrentValue = false,
   Flag = "SpeedGrindToggle",
   Callback = function(bool)
      local isGrinding = bool
      if not bool then return end
      
      for i = 1, 14 do
          task.spawn(function()
              while isGrinding do
                  player.muscleEvent:FireServer("rep")
                  task.wait()
              end
          end)
      end
   end,
})

----------------------------------------------------
-- FARM TAB (ФАРМ)
----------------------------------------------------
farmPlusTab:CreateSection("Бить камень")

local function gettool()
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v.Name == "Punch" and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(v)
        end
    end
    player.muscleEvent:FireServer("punch", "leftHand")
    player.muscleEvent:FireServer("punch", "rightHand")
end

local function setupRockFarm(name, reqDurability)
    farmPlusTab:CreateToggle({
       Name = name .. " - " .. reqDurability,
       CurrentValue = false,
       Flag = "RockFarm_" .. reqDurability,
       Callback = function(Value)
          getgenv().autoFarm = Value
          task.spawn(function()
              while getgenv().autoFarm do
                  task.wait()
                  if not getgenv().autoFarm then break end
                  if player:FindFirstChild("Durability") and player.Durability.Value >= reqDurability then
                      for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                          if v.Name == "neededDurability" and v.Value == reqDurability and player.Character:FindFirstChild("LeftHand") and player.Character:FindFirstChild("RightHand") then
                              firetouchinterest(v.Parent.Rock, player.Character.RightHand, 0)
                              firetouchinterest(v.Parent.Rock, player.Character.RightHand, 1)
                              firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 0)
                              firetouchinterest(v.Parent.Rock, player.Character.LeftHand, 1)
                              gettool()
                          end
                      end
                  end
              end
          end)
       end,
    })
end

setupRockFarm("Маленький камень", 0)
setupRockFarm("Средний камень", 100)
setupRockFarm("Золотой камень", 5000)
setupRockFarm("Ледяной камень", 150000)
setupRockFarm("Мифический камень", 400000)
setupRockFarm("Адский камень", 750000)
setupRockFarm("Легендарный камень", 1000000)
setupRockFarm("Королевский камень", 5000000)
setupRockFarm("Камень в Джунглях", 10000000)

farmPlusTab:CreateSection("Перерождения")

local targetRebirthValue = 0

farmPlusTab:CreateInput({
   Name = "Сколько нужно?",
   PlaceholderText = "Введите число",
   RemoveTextOnFocus = false,
   Callback = function(text)
      local newValue = tonumber(text)
      if newValue and newValue > 0 then
          targetRebirthValue = newValue
          Rayfield:Notify({Title = "Понял", Content = "Остановлю когда будет " .. targetRebirthValue .. " перерождений", Duration = 3})
      else
          Rayfield:Notify({Title = "Всё", Content = "Остановил как и обещал", Duration = 3})
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Начать перерождется по твоему количеству",
   CurrentValue = false,
   Flag = "TargetRebirthToggle",
   Callback = function(bool)
      _G.targetRebirthActive = bool
      if bool then
          task.spawn(function()
              while _G.targetRebirthActive and task.wait(0.1) do
                  local currentRebirths = player.leaderstats.Rebirths.Value
                  if currentRebirths >= targetRebirthValue then
                      _G.targetRebirthActive = false
                      Rayfield:Notify({Title = "Ооо", Content = "Пошло дело пошло", Duration = 5})
                      break
                  end
                  ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
              end
          end)
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Перерождатся бесконечно",
   CurrentValue = false,
   Flag = "InfiniteRebirthToggle",
   Callback = function(bool)
      _G.infiniteRebirthActive = bool
      if bool then
          task.spawn(function()
              while _G.infiniteRebirthActive and task.wait(0.1) do
                  ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
              end
          end)
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Всегда рост 1",
   CurrentValue = false,
   Flag = "AlwaysSizeOneToggle",
   Callback = function(bool)
      _G.autoSizeActive = bool
      if bool then
          task.spawn(function()
              while _G.autoSizeActive and task.wait() do
                  ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 1)
              end
          end)
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Телепортироватся в короля",
   CurrentValue = false,
   Flag = "TeleportKingToggle",
   Callback = function(bool)
      _G.teleportActive = bool
      if bool then
          task.spawn(function()
              while _G.teleportActive and task.wait() do
                  if player.Character then
                      player.Character:MoveTo(Vector3.new(-8646, 17, -5738))
                  end
              end
          end)
      end
   end,
})

farmPlusTab:CreateSection("Автоматически качатся")

farmPlusTab:CreateButton({
   Name = "Автолифт",
   Callback = function()
      local gamepassFolder = ReplicatedStorage:FindFirstChild("gamepassIds")
      if gamepassFolder then
          for _, gamepass in pairs(gamepassFolder:GetChildren()) do
              local value = Instance.new("IntValue")
              value.Name = gamepass.Name
              value.Value = gamepass.Value
              value.Parent = player:FindFirstChild("ownedGamepasses") or player
          end
      end
   end,
})

local function setupAutoToolToggle(name, toolName)
    farmPlusTab:CreateToggle({
       Name = name,
       CurrentValue = false,
       Flag = "Auto" .. toolName .. "Toggle",
       Callback = function(Value)
          _G["Auto" .. toolName] = Value
          if Value then
              local tool = player.Backpack:FindFirstChild(toolName)
              if tool and player.Character and player.Character:FindFirstChild("Humanoid") then
                  player.Character.Humanoid:EquipTool(tool)
              end
          else
              local equipped = player.Character and player.Character:FindFirstChild(toolName)
              if equipped then equipped.Parent = player.Backpack end
          end
          
          task.spawn(function()
              while _G["Auto" .. toolName] do
                  player.muscleEvent:FireServer("rep")
                  task.wait(0.1)
              end
          end)
       end,
    })
end

setupAutoToolToggle("Авто гантеля", "Weight")
setupAutoToolToggle("Авто отжимания", "Pushups")
setupAutoToolToggle("Авто отжимания стоя на руках", "Handstands")
setupAutoToolToggle("Авто пресс", "Situps")

farmPlusTab:CreateToggle({
   Name = "Авто удары",
   CurrentValue = false,
   Flag = "AutoPunchToggle",
   Callback = function(Value)
      _G.fastHitActive = Value
      if Value then
          task.spawn(function()
              while _G.fastHitActive and task.wait(0.1) do
                  local punch = player.Backpack:FindFirstChild("Punch")
                  if punch and player.Character then
                      punch.Parent = player.Character
                      if punch:FindFirstChild("attackTime") then punch.attackTime.Value = 0 end
                  end
              end
          end)
          
          task.spawn(function()
              while _G.fastHitActive and task.wait(0) do
                  player.muscleEvent:FireServer("punch", "rightHand")
                  player.muscleEvent:FireServer("punch", "leftHand")
                  if player.Character and player.Character:FindFirstChild("Punch") then
                      player.Character.Punch:Activate()
                  end
              end
          end)
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Быстрые предметы",
   CurrentValue = false,
   Flag = "FastToolsToggle",
   Callback = function(Value)
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
          local bpTool = player.Backpack:FindFirstChild(toolName)
          if bpTool and bpTool:FindFirstChild(property) then bpTool[property].Value = speed end
          local eqTool = player.Character and player.Character:FindFirstChild(toolName)
          if eqTool and eqTool:FindFirstChild(property) then eqTool[property].Value = speed end
      end
   end,
})

farmPlusTab:CreateToggle({
   Name = "Анти лаг",
   CurrentValue = false,
   Flag = "AntiLagToggle",
   Callback = function(Value)
      _G.AntiLag = Value
      if Value then
          game:GetService("Lighting").GlobalShadows = false
          game:GetService("Lighting").FogEnd = 9e9
          for _, obj in pairs(workspace:GetDescendants()) do
              if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
                  obj.Material = Enum.Material.Plastic
                  obj.Reflectance = 0
              elseif obj:IsA("Decal") or obj:IsA("Texture") then
                  obj:Destroy()
              end
          end
      end
   end,
})

farmPlusTab:CreateSection("Статистика")

local strengthStatsLabel = farmPlusTab:CreateLabel("Сила: Статы...")
local durabilityStatsLabel = farmPlusTab:CreateLabel("Долговечность: Статы...")
local rebirthsStatsLabel = farmPlusTab:CreateLabel("Перерождения: Статы...")
local killsStatsLabel = farmPlusTab:CreateLabel("Убийства: Статы...")
local brawlsStatsLabel = farmPlusTab:CreateLabel("Поединки: Статы...")
local sessionTimeLabel = farmPlusTab:CreateLabel("Время: 00:00:00")

local sessionStartTime = os.time()
local sessionStartStrength, sessionStartDurability, sessionStartKills, sessionStartRebirths, sessionStartBrawls = 0, 0, 0, 0, 0
local hasStartedTracking = false

local function formatNumber(n)
    if n >= 1e15 then return string.format("%.2fQ", n/1e15)
    elseif n >= 1e12 then return string.format("%.2fT", n/1e12)
    elseif n >= 1e9 then return string.format("%.2fB", n/1e9)
    elseif n >= 1e6 then return string.format("%.2fM", n/1e6)
    elseif n >= 1e3 then return string.format("%.2fK", n/1e3) end
    return tostring(math.floor(n))
end

local function formatTime(seconds)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

local function updateStats()
    if not player:FindFirstChild("leaderstats") then return end
    if not hasStartedTracking then
        sessionStartStrength = player.leaderstats.Strength.Value
        sessionStartDurability = player.Durability.Value
        sessionStartKills = player.leaderstats.Kills.Value
        sessionStartRebirths = player.leaderstats.Rebirths.Value
        sessionStartBrawls = player.leaderstats.Brawls.Value
        sessionStartTime = os.time()
        hasStartedTracking = true
    end
    
    local cStr = player.leaderstats.Strength.Value
    local cDur = player.Durability.Value
    local cKil = player.leaderstats.Kills.Value
    local cReb = player.leaderstats.Rebirths.Value
    local cBrw = player.leaderstats.Brawls.Value
    
    strengthStatsLabel:Set("Сила: " .. formatNumber(cStr) .. " (+" .. formatNumber(cStr - sessionStartStrength) .. ")")
    durabilityStatsLabel:Set("Долговечность: " .. formatNumber(cDur) .. " (+" .. formatNumber(cDur - sessionStartDurability) .. ")")
    rebirthsStatsLabel:Set("Перерождения: " .. formatNumber(cReb) .. " (+" .. formatNumber(cReb - sessionStartRebirths) .. ")")
    killsStatsLabel:Set("Убийства: " .. formatNumber(cKil) .. " (+" .. formatNumber(cKil - sessionStartKills) .. ")")
    brawlsStatsLabel:Set("Поединки: " .. formatNumber(cBrw) .. " (+" .. formatNumber(cBrw - sessionStartBrawls) .. ")")
    sessionTimeLabel:Set("Время: " .. formatTime(os.time() - sessionStartTime))
end

task.spawn(function()
    while task.wait(2) do
        updateStats()
    end
end)

farmPlusTab:CreateButton({
   Name = "Очистить статистику",
   Callback = function()
      if player:FindFirstChild("leaderstats") then
          sessionStartStrength = player.leaderstats.Strength.Value
          sessionStartDurability = player.Durability.Value
          sessionStartKills = player.leaderstats.Kills.Value
          sessionStartRebirths = player.leaderstats.Rebirths.Value
          sessionStartBrawls = player.leaderstats.Brawls.Value
          sessionStartTime = os.time()
          Rayfield:Notify({Title = "Готово", Content = "Ты очистил", Duration = 3})
      end
   end,
})

----------------------------------------------------
-- PETS TAB (ПЕТЫ)
----------------------------------------------------
petsTab:CreateSection("Петы")

local selectedPet = "Neon Guardian"
local petList = {
    "Neon Guardian", "Blue Birdie", "Blue Bunny", "Blue Firecaster", "Blue Pheonix",
    "Crimson Falcon", "Cybernetic Showdown Dragon", "Dark Golem", "Dark Legends Manticore",
    "Dark Vampy", "Darkstar Hunter", "Eternal Strike Leviathan", "Frostwave Legends Penguin",
    "Gold Warrior", "Golden Pheonix", "Golden Viking", "Green Butterfly", "Green Firecaster",
    "Infernal Dragon", "Lightning Strike Phantom", "Magic Butterfly", "Muscle Sensei",
    "Orange Hedgehog", "Orange Pegasus", "Phantom Genesis Dragon", "Purple Dragon",
    "Purple Falcon", "Red Dragon", "Red Firecaster", "Red Kitty", "Silver Dog",
    "Ultimate Supernova Pegasus", "Ultra Birdie", "White Pegasus", "White Pheonix", "Yellow Butterfly"
}

petsTab:CreateDropdown({
   Name = "Выбери пета",
   Options = petList,
   CurrentOption = {"Neon Guardian"},
   MultipleOptions = false,
   Flag = "PetDropdown",
   Callback = function(Option)
      selectedPet = Option[1] or Option
   end,
})

petsTab:CreateToggle({
   Name = "Купить пета",
   CurrentValue = false,
   Flag = "BuyPetToggle",
   Callback = function(bool)
      _G.AutoHatchPet = bool
      if bool then
          task.spawn(function()
              while _G.AutoHatchPet and selectedPet ~= "" and task.wait(1) do
                  local petToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedPet)
                  if petToOpen then
                      ReplicatedStorage.cPetShopRemote:InvokeServer(petToOpen)
                  end
              end
          end)
      end
   end,
})

petsTab:CreateSection("Ауры")

local selectedAura = "Blue Aura"
local auraList = {
    "Astral Electro", "Azure Tundra", "Blue Aura", "Dark Electro", "Dark Lightning",
    "Dark Storm", "Electro", "Enchanted Mirage", "Entropic Blast", "Eternal Megastrike",
    "Grand Supernova", "Green Aura", "Inferno", "Lightning", "Muscle King",
    "Power Lightning", "Purple Aura", "Purple Nova", "Red Aura", "Supernova",
    "Ultra Inferno", "Ultra Mirage", "Unstable Mirage", "Yellow Aura"
}

petsTab:CreateDropdown({
   Name = "Выбери ауру",
   Options = auraList,
   CurrentOption = {"Blue Aura"},
   MultipleOptions = false,
   Flag = "AuraDropdown",
   Callback = function(Option)
      selectedAura = Option[1] or Option
   end,
})

petsTab:CreateToggle({
   Name = "Купить ауру",
   CurrentValue = false,
   Flag = "BuyAuraToggle",
   Callback = function(bool)
      _G.AutoHatchAura = bool
      if bool then
          task.spawn(function()
              while _G.AutoHatchAura and selectedAura ~= "" and task.wait(1) do
                  local auraToOpen = ReplicatedStorage.cPetShopFolder:FindFirstChild(selectedAura)
                  if auraToOpen then
                      ReplicatedStorage.cPetShopRemote:InvokeServer(auraToOpen)
                  end
              end
          end)
      end
   end,
})

----------------------------------------------------
-- KILLER TAB (УБИЙСТВА)
----------------------------------------------------
_G.whitelistedPlayers = _G.whitelistedPlayers or {}
_G.targetPlayer = _G.targetPlayer or ""

local whitelistedPlayersLabel = killerTab:CreateLabel("Белый список: Нету")
local targetPlayerLabel = killerTab:CreateLabel("Атаковать игрока: Нету")

local function updateWhitelistedLabel()
    if #_G.whitelistedPlayers == 0 then
        whitelistedPlayersLabel:Set("Белый список: Нету")
    else
        whitelistedPlayersLabel:Set("Белый список: " .. table.concat(_G.whitelistedPlayers, ", "))
    end
end

local function updateTargetLabel()
    if _G.targetPlayer == "" then
        targetPlayerLabel:Set("Кого убивать: Нету")
    else
        targetPlayerLabel:Set("Кого убивать: " .. _G.targetPlayer)
    end
end

local function findClosestPlayer(input)
    if not input or input == "" then return nil end
    input = input:lower()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            if p.Name:lower():find(input, 1, true) or p.DisplayName:lower():find(input, 1, true) then
                return p
            end
        end
    end
    return nil
end

local function killPlayer(target)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    local char = player.Character
    if not char or not char:FindFirstChild("LeftHand") then return end
    
    pcall(function()
        firetouchinterest(target.Character.HumanoidRootPart, char.LeftHand, 0)
        task.wait(0.01)
        firetouchinterest(target.Character.HumanoidRootPart, char.LeftHand, 1)
        gettool()
    end)
end

killerTab:CreateToggle({
   Name = "Автоматом друзей в белый список",
   CurrentValue = false,
   Flag = "AutoWhitelistFriendsToggle",
   Callback = function(bool)
      _G.autoWhitelistFriends = bool
      if bool then
          pcall(function()
              for _, p in pairs(Players:GetPlayers()) do
                  if p:IsFriendsWith(player.UserId) then
                      local pInfo = p.Name .. " (" .. p.DisplayName .. ")"
                      if not table.find(_G.whitelistedPlayers, pInfo) then
                          table.insert(_G.whitelistedPlayers, pInfo)
                      end
                  end
              end
              updateWhitelistedLabel()
          end)
      end
   end,
})

killerTab:CreateInput({
   Name = "Добавить в белый список (ник)",
   PlaceholderText = "Никнейм",
   RemoveTextOnFocus = false,
   Callback = function(text)
      local target = findClosestPlayer(text)
      if target then
          local pInfo = target.Name .. " (" .. target.DisplayName .. ")"
          if not table.find(_G.whitelistedPlayers, pInfo) then
              table.insert(_G.whitelistedPlayers, pInfo)
              updateWhitelistedLabel()
          end
      end
   end,
})

killerTab:CreateInput({
   Name = "Удалить с белого списка (ник)",
   PlaceholderText = "Никнейм",
   RemoveTextOnFocus = false,
   Callback = function(text)
      for i, info in ipairs(_G.whitelistedPlayers) do
          if info:lower():find(text:lower(), 1, true) then
              table.remove(_G.whitelistedPlayers, i)
              updateWhitelistedLabel()
              break
          end
      end
   end,
})

killerTab:CreateButton({
   Name = "Очистить белый список",
   Callback = function()
      _G.whitelistedPlayers = {}
      updateWhitelistedLabel()
   end,
})

killerTab:CreateToggle({
   Name = "Убивать всех (кроме тех,кто в белом списке)",
   CurrentValue = false,
   Flag = "AutoKillAllToggle",
   Callback = function(bool)
      _G.autoKillAll = bool
      if bool then
          task.spawn(function()
              while _G.autoKillAll and task.wait(0.2) do
                  for _, p in ipairs(Players:GetPlayers()) do
                      if p ~= player and _G.autoKillAll then
                          local isWhitelisted = false
                          for _, info in ipairs(_G.whitelistedPlayers) do
                              if info:find(p.Name, 1, true) then isWhitelisted = true break end
                          end
                          if not isWhitelisted and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                              killPlayer(p)
                              task.wait(0.05)
                          end
                      end
                  end
              end
          end)
      end
   end,
})

killerTab:CreateInput({
   Name = "Убивать кого: (ник)",
   PlaceholderText = "Никнейм",
   RemoveTextOnFocus = false,
   Callback = function(text)
      local target = findClosestPlayer(text)
      if target then
          _G.targetPlayer = target.Name .. " (" .. target.DisplayName .. ")"
          updateTargetLabel()
      end
   end,
})

killerTab:CreateButton({
   Name = "Очистить убийство",
   Callback = function()
      _G.targetPlayer = ""
      updateTargetLabel()
   end,
})

killerTab:CreateToggle({
   Name = "Убийство выбранного",
   CurrentValue = false,
   Flag = "AutoKillTargetToggle",
   Callback = function(bool)
      _G.autoKillTarget = bool
      if bool and _G.targetPlayer ~= "" then
          task.spawn(function()
              while _G.autoKillTarget and _G.targetPlayer ~= "" and task.wait(0.1) do
                  local targetName = _G.targetPlayer:match("^([^%(]+)")
                  if targetName then
                      targetName = targetName:gsub("%s+$", "")
                      local targetP = Players:FindFirstChild(targetName)
                      if targetP and targetP.Character and targetP.Character:FindFirstChild("Humanoid") and targetP.Character.Humanoid.Health > 0 then
                          killPlayer(targetP)
                      end
                  end
              end
          end)
      end
   end,
})

----------------------------------------------------
-- TELEPORT TAB (ТЕЛЕПОРТ)
----------------------------------------------------
local function createTeleportButton(name, cf, text)
    teleportTab:CreateButton({
       Name = name,
       Callback = function()
          local char = player.Character or player.CharacterAdded:Wait()
          local root = char:WaitForChild("HumanoidRootPart")
          root.CFrame = cf
          Rayfield:Notify({Title = "Телепорт", Content = text, Duration = 3})
       end,
    })
end

createTeleportButton("Спавн", CFrame.new(2, 8, 115), "Прямиком на спавн")
createTeleportButton("Секретная арена", CFrame.new(1947, 2, 6191), "У-хх СЕКРЕТ!")
createTeleportButton("Маленький остров 0-1к", CFrame.new(-34, 7, 1903), "Это для тебя малыш")
createTeleportButton("Ледяной зал", CFrame.new(-2600, 4, -403), "Тут холодновато")
createTeleportButton("Мифический портал", CFrame.new(2255, 7, 1071), "Вот это Да,Мистика!")
createTeleportButton("Адский портал", CFrame.new(-6768, 7, -1287), "Жарковье,прям под сатану")
createTeleportButton("Легендарный остров", CFrame.new(4604, 991, -3887), "Тихо!Он только для легенд")
createTeleportButton("Портал мускульного короля", CFrame.new(-8646, 17, -5738), "Ты на стояке у Роналдо,двойная сила!")
createTeleportButton("Джунгли", CFrame.new(-8659, 6, 2384), "Алё,надо побрить,тут уже обезьянки бегают")
createTeleportButton("Бой в лаве", CFrame.new(4471, 119, -8836), "Это бой в лаве")
createTeleportButton("Бой в пустыне", CFrame.new(960, 17, -7398), "Это бой в песчанике")
createTeleportButton("Бой на ринге", CFrame.new(-1849, 20, -6335), "Тебе завидует Майк Тайсон")

----------------------------------------------------
-- MISC TAB (ДРУГОЕ)
----------------------------------------------------
miscTab:CreateSection("Авто рулетка и подарки")

miscTab:CreateToggle({
   Name = "Авто прокрутка колеса удачи",
   CurrentValue = false,
   Flag = "AutoSpinWheelToggle",
   Callback = function(bool)
      _G.AutoSpinWheel = bool
      if bool then
          task.spawn(function()
              while _G.AutoSpinWheel and task.wait(1) do
                  ReplicatedStorage.rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", ReplicatedStorage.fortuneWheelChances["Fortune Wheel"])
              end
          end)
      end
   end,
})

miscTab:CreateToggle({
   Name = "Авто сбор подарков",
   CurrentValue = false,
   Flag = "AutoClaimGiftsToggle",
   Callback = function(bool)
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
   end,
})

----------------------------------------------------
-- NOTE TAB (СОЗДАТЕЛЬ)
----------------------------------------------------
noteTab:CreateLabel("Private Script")
noteTab:CreateLabel("Созданно vanegood")
