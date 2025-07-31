local replicatedStorage = game:GetService("ReplicatedStorage")
local rEvents = replicatedStorage:WaitForChild("rEvents")

local orbEvent = rEvents:WaitForChild("orbEvent")
local rebirthEvent = rEvents:WaitForChild("rebirthEvent")

-- Function to handle firing orb collection events
local function collectOrb(orbType)
    local args = {
        [1] = "collectOrb",
        [2] = orbType, -- Orb type ("Red Orb" or "Gem")
        [3] = "City"
    }

    while true do
        orbEvent:FireServer(unpack(args))
        wait(0) -- Adjust delay as needed 
    end
end

-- Function to handle rebirthing
local function autoRebirth()
    local args = {
        [1] = "rebirthRequest"
    }

    while true do
        rebirthEvent:FireServer(unpack(args))
        wait(1) -- Adjust delay to suit the rebirth mechanics in your game
    end
end

-- Start multiple loops for orb collection
for i = 1, 50 do -- Adjust number of concurrent executions 
    coroutine.wrap(function() collectOrb("Red Orb") end)()
    coroutine.wrap(function() collectOrb("Gem") end)()
end

-- Start auto-rebirth loop
coroutine.wrap(autoRebirth)()
