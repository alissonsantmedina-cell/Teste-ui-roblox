-- UI Logo Test | Delta Compatible
-- Apenas testes visuais (SEM exploit)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LogoTestUI"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Frame da Logo
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(120, 120)
frame.Position = UDim2.fromScale(0.1, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 0
frame.Parent = gui
frame.Active = true

-- Cantos arredondados
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = frame

-- Imagem da Logo
local image = Instance.new("ImageLabel")
image.Size = UDim2.fromScale(1, 1)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://117905731202243"
image.Parent = frame

-- 🔥 Animação ao clicar
local function clickAnimation()
	local tweenInfo = TweenInfo.new(
		0.15,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)

	local shrink = TweenService:Create(
		frame,
		tweenInfo,
		{Size = UDim2.fromOffset(100, 100)}
	)

	local expand = TweenService:Create(
		frame,
		tweenInfo,
		{Size = UDim2.fromOffset(120, 120)}
	)

	shrink:Play()
	shrink.Completed:Wait()
	expand:Play()
end

-- 🖱️ Drag System (Delta Friendly)
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		clickAnimation()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

print("✅ UI Logo carregada com sucesso!")
