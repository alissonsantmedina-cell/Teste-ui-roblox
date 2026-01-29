-- UI Logo Simple | Mobile Friendly

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(120,120)
frame.Position = UDim2.fromScale(0.5,0.5)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
frame.BorderSizePixel = 0
frame.Active = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,18)

local img = Instance.new("ImageLabel", frame)
img.Size = UDim2.fromScale(1,1)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://117905731202243"

-- ✨ Clique animação
frame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		TweenService:Create(
			frame,
			TweenInfo.new(0.12),
			{Size = frame.Size * 0.9}
		):Play()
		task.wait(0.12)
		TweenService:Create(
			frame,
			TweenInfo.new(0.12),
			{Size = frame.Size / 0.9}
		):Play()
	end
end)

-- 🖱️ Drag
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = frame.Position
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.Touch then
		local delta = i.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- 🤏 Pinça (Zoom com dois dedos)
local lastDist
UIS.TouchPinch:Connect(function(_, scale)
	local newSize = math.clamp(frame.Size.X.Offset * scale, 80, 220)
	frame.Size = UDim2.fromOffset(newSize, newSize)
end)

print("✅ UI Logo simples carregada")
