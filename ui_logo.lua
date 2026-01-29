-- Friendly UI Script v2 | Delta Compatible

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- 🟦 LOGO
local logo = Instance.new("Frame", gui)
logo.Size = UDim2.fromOffset(90,90)
logo.Position = UDim2.fromScale(0.1,0.5)
logo.BackgroundColor3 = Color3.fromRGB(20,20,25)
logo.BorderSizePixel = 0
logo.Active = true
Instance.new("UICorner", logo).CornerRadius = UDim.new(0,18)

local img = Instance.new("ImageLabel", logo)
img.Size = UDim2.fromScale(1,1)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://117905731202243"

-- 📦 MENU (CENTRO)
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.fromOffset(420,260)
menu.Position = UDim2.fromScale(0.5,0.5)
menu.AnchorPoint = Vector2.new(0.5,0.5)
menu.BackgroundColor3 = Color3.fromRGB(30,30,35)
menu.BorderSizePixel = 0
menu.Visible = false
menu.Active = true
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,16)

-- 📂 SIDEBAR
local sidebar = Instance.new("Frame", menu)
sidebar.Size = UDim2.fromOffset(100,260)
sidebar.BackgroundColor3 = Color3.fromRGB(25,25,30)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0,16)

-- 📄 CONTENT
local content = Instance.new("Frame", menu)
content.Position = UDim2.fromOffset(110,10)
content.Size = UDim2.fromOffset(300,240)
content.BackgroundTransparency = 1

-- 🧠 FUNÇÃO AUX
local function clear()
	for _,v in pairs(content:GetChildren()) do
		if v:IsA("GuiObject") then v:Destroy() end
	end
end

-- 👤 INVISÍVEL PLAYERS
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

-- 📄 PRINCIPAL
local function principalTab()
	clear()
	local btn = Instance.new("TextButton", content)
	btn.Size = UDim2.fromOffset(280,40)
	btn.Position = UDim2.fromOffset(10,20)
	btn.Text = "👤 Invisível Players"
	btn.BackgroundColor3 = Color3.fromRGB(50,50,60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)

	btn.MouseButton1Click:Connect(function()
		invisible = not invisible
		setInvisible(invisible)
		btn.Text = invisible and "👁️ Invisível (ON)" or "👤 Invisível Players"
	end)
end

-- 🎨 CUSTOMIZAÇÃO
local function customTab()
	clear()

	local colors = {
		{"Verde", Color3.fromRGB(60,120,80)},
		{"Vermelho", Color3.fromRGB(120,60,60)},
		{"Azul", Color3.fromRGB(60,90,140)},
		{"Branco", Color3.fromRGB(240,240,240)}
	}

	for i,c in ipairs(colors) do
		local b = Instance.new("TextButton", content)
		b.Size = UDim2.fromOffset(130,35)
		b.Position = UDim2.fromOffset(10 + ((i-1)%2)*145, 20 + math.floor((i-1)/2)*45)
		b.Text = c[1]
		b.BackgroundColor3 = c[2]
		b.TextColor3 = Color3.new(0,0,0)
		b.BorderSizePixel = 0
		Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

		b.MouseButton1Click:Connect(function()
			menu.BackgroundColor3 = c[2]
		end)
	end

	-- TEXTURA
	local neon = Instance.new("TextButton", content)
	neon.Size = UDim2.fromOffset(280,35)
	neon.Position = UDim2.fromOffset(10,140)
	neon.Text = "✨ Neon"
	neon.BackgroundColor3 = Color3.fromRGB(70,70,80)
	neon.TextColor3 = Color3.new(1,1,1)
	neon.BorderSizePixel = 0
	Instance.new("UICorner", neon).CornerRadius = UDim.new(0,8)

	neon.MouseButton1Click:Connect(function()
		menu.BackgroundTransparency = 0
	end)

	local trans = neon:Clone()
	trans.Position = UDim2.fromOffset(10,185)
	trans.Text = "🌫 Transparência"
	trans.Parent = content

	trans.MouseButton1Click:Connect(function()
		menu.BackgroundTransparency = 0.3
	end)
end

-- 📂 BOTÕES SIDEBAR
local function sideBtn(txt, y, func)
	local b = Instance.new("TextButton", sidebar)
	b.Size = UDim2.fromOffset(90,40)
	b.Position = UDim2.fromOffset(5,y)
	b.Text = txt
	b.BackgroundColor3 = Color3.fromRGB(40,40,50)
	b.TextColor3 = Color3.new(1,1,1)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
	b.MouseButton1Click:Connect(func)
end

sideBtn("Principal", 20, principalTab)
sideBtn("Customização", 70, customTab)

-- 🟦 ABRIR / FECHAR
local open = false
local dragLogo, dragMenu

logo.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		open = not open
		menu.Visible = open
		if open then principalTab() end
	end
end)

-- 🧲 DRAG LOGO
logo.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragLogo = true
		local start = i.Position
		local pos = logo.Position
		UIS.InputChanged:Once(function(m)
			if dragLogo then
				logo.Position = pos + UDim2.fromOffset(m.Position.X-start.X, m.Position.Y-start.Y)
			end
		end)
	end
end)

UIS.InputEnded:Connect(function() dragLogo = false end)

-- 🧲 DRAG MENU
menu.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragMenu = true
		local start = i.Position
		local pos = menu.Position
		UIS.InputChanged:Once(function(m)
			if dragMenu then
				menu.Position = pos + UDim2.fromOffset(m.Position.X-start.X, m.Position.Y-start.Y)
			end
		end)
	end
end)

UIS.InputEnded:Connect(function() dragMenu = false end)

print("✅ Friendly UI v2 carregado")
