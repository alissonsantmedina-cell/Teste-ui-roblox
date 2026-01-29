-- Friendly UI Script | Delta Compatible

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- 🔵 LOGO FRAME
local logo = Instance.new("Frame", gui)
logo.Size = UDim2.fromOffset(100,100)
logo.Position = UDim2.fromScale(0.1,0.5)
logo.BackgroundColor3 = Color3.fromRGB(20,20,25)
logo.BorderSizePixel = 0
logo.Active = true

Instance.new("UICorner", logo).CornerRadius = UDim.new(0,18)

local img = Instance.new("ImageLabel", logo)
img.Size = UDim2.fromScale(1,1)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://117905731202243"

-- 📦 MENU
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.fromOffset(220,120)
menu.Position = UDim2.fromOffset(
	logo.Position.X.Offset + 110,
	logo.Position.Y.Offset
)
menu.BackgroundColor3 = Color3.fromRGB(25,25,30)
menu.BorderSizePixel = 0
menu.Visible = false

Instance.new("UICorner", menu).CornerRadius = UDim.new(0,14)

-- 📝 BOTÃO
local btn = Instance.new("TextButton", menu)
btn.Size = UDim2.fromOffset(200,40)
btn.Position = UDim2.fromOffset(10,20)
btn.Text = "👤 Invisível Players"
btn.BackgroundColor3 = Color3.fromRGB(40,40,50)
btn.TextColor3 = Color3.new(1,1,1)
btn.BorderSizePixel = 0

Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

-- 🧠 FUNÇÃO: INVISÍVEL PRA VOCÊ
local invisible = false

local function setInvisible(state)
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			for _,v in pairs(plr.Character:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Decal") then
					v.LocalTransparencyModifier = state and 1 or 0
				end
			end
		end
	end
end

btn.MouseButton1Click:Connect(function()
	invisible = not invisible
	setInvisible(invisible)
	btn.Text = invisible and "👁️ Players Invisíveis (ON)" or "👤 Invisível Players"
end)

-- 🔁 ABRIR / FECHAR MENU
local opened = false
logo.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		opened = not opened
		menu.Visible = opened
	end
end)

-- 🖱️ DRAG LIVRE
local dragging, startPos, dragStart

logo.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = logo.Position
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
		logo.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		menu.Position = UDim2.fromOffset(
			logo.Position.X.Offset + 110,
			logo.Position.Y.Offset
		)
	end
end)

print("✅ Friendly UI carregado")
