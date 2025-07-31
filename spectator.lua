function start()
local plr = game.Players.LocalPlayer
local players = game.Players
local subject = game.Players.LocalPlayer.Character.Humanoid
local index = 0
local setsubject = false
local cam = game.Workspace.CurrentCamera
for i, v in ipairs(players:GetChildren()) do
if v == plr then
index = i
end
end
local gui = Instance.new("ScreenGui", plr.PlayerGui)
gui.Name = "SpectatorGui"
local frame = Instance.new("Frame", gui)
local upbutton = Instance.new("TextButton", frame)
local downbutton = Instance.new("TextButton", frame)
local playernamelabel = Instance.new("TextLabel", frame)
frame.Draggable = true
frame.Selectable = true
frame.Active = true
frame.Size = UDim2.fromScale(0.4, 0.1)
playernamelabel.TextScaled = true
playernamelabel.Text = plr.Character.Humanoid.DisplayName
playernamelabel.Size = UDim2.fromScale(0.5, 1)
playernamelabel.Position = UDim2.fromScale(0.25, 0)
upbutton.Text = ">"
upbutton.TextScaled = true
upbutton.Size = UDim2.fromScale(0.25, 1)
upbutton.Position = UDim2.fromScale(0.75, 0)
downbutton.Text = "<"
downbutton.TextScaled = true
downbutton.Size = UDim2.fromScale(0.25, 1)
downbutton.Position = UDim2.fromScale(0, 0)
function changeSubject(isup)
setsubject = false
if isup then
index = index + 1
else
index = index - 1
end
if index > #players:GetChildren() then
index = 0
end
if index < 0 then
index = #players:GetChildren()
end
subject = players:GetChildren()[index]
playernamelabel.Text = subject.Character.Humanoid.DisplayName
setsubject = true
while setsubject do
if subject.Character then
if subject.Character:FindFirstChild("Humanoid") then
cam.CameraSubject = subject.Character.Humanoid
end
end
task.wait()
end
end
upbutton.Activated:Connect(function()
changeSubject(true)
end)
downbutton.Activated:Connect(function()
changeSubject(false)
end)
end
while task.wait() do
if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("SpectatorGui") then
task.spawn(start)
end
end
