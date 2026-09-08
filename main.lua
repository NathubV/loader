--// SODIUM LOADER
--// Roblox Studio LocalScript
--// Put in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("SodiumLoader")
if old then
	old:Destroy()
end

--==================================================
-- CONFIG
--==================================================

local SCRIPT_LINK = "loadstring(game:HttpGet("https://raw.githubusercontent.com/NathubV/Mm2Premium/refs/heads/main/loader"))()"

local GAMES = {
	{
		Name = "Murder Mystery 2",
		Description = "Universal MM2 GUI",
		Color = Color3.fromRGB(255, 55, 65),
		PlaceId = 142823291
	},
	{
		Name = "Adopt Me!",
		Description = "Sodium ADM Script",
		Color = Color3.fromRGB(35, 180, 245),
		PlaceId = 920587237
	},
	{
		Name = "Grow a Garden",
		Description = "GAG Script",
		Color = Color3.fromRGB(45, 230, 110),
		PlaceId = 126884695634066
	},
	{
		Name = "Blade Ball",
		Description = "BladeBall Script",
		Color = Color3.fromRGB(245, 150, 35),
		PlaceId = 13772394625
	}
}

--==================================================
-- COLORS
--==================================================

local BG = Color3.fromRGB(10, 10, 14)
local PANEL = Color3.fromRGB(18, 18, 24)
local BUTTON = Color3.fromRGB(24, 24, 32)
local TEXT = Color3.fromRGB(238, 238, 242)
local SUBTEXT = Color3.fromRGB(145, 145, 155)
local PURPLE = Color3.fromRGB(185, 50, 245)
local GREEN = Color3.fromRGB(45, 230, 110)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "PREMIUM SCRIPT KEYLESS"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(590, 585)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

--==================================================
-- DRAGGABLE HEADER
--==================================================

local dragArea = Instance.new("Frame")
dragArea.Name = "DragArea"
dragArea.BackgroundTransparency = 1
dragArea.Position = UDim2.fromOffset(0, 3)
dragArea.Size = UDim2.new(1, -65, 0, 82)
dragArea.Active = true
dragArea.ZIndex = 5
dragArea.Parent = main

local dragging = false
local dragStart
local startPosition

dragArea.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end

		end)

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)

	end

end)

--==================================================
-- TOP ACCENT
--==================================================

local accent = Instance.new("Frame")
accent.Size = UDim2.new(1, 0, 0, 3)
accent.BackgroundColor3 = PURPLE
accent.BorderSizePixel = 0
accent.ZIndex = 2
accent.Parent = main

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 80, 220)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(230, 20, 150)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 30, 220))
})
gradient.Parent = accent

--==================================================
-- TITLE
--==================================================

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(26, 28)
title.Size = UDim2.new(1, -100, 0, 34)
title.Font = Enum.Font.GothamBold
title.Text = "PREMIUM SCRIPT KEYLESS"
title.TextSize = 27
title.TextColor3 = Color3.fromRGB(225, 55, 205)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 6
title.Parent = main

--==================================================
-- SUBTITLE
--==================================================

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(27, 61)
subtitle.Size = UDim2.new(1, -60, 0, 24)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Select a supported game to continue:"
subtitle.TextSize = 13
subtitle.TextColor3 = SUBTEXT
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.ZIndex = 6
subtitle.Parent = main

--==================================================
-- CLOSE
--==================================================

local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(43, 43)
close.Position = UDim2.new(1, -53, 0, 23)
close.BackgroundColor3 = Color3.fromRGB(24, 19, 25)
close.BorderSizePixel = 0
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 17
close.TextColor3 = Color3.fromRGB(255, 55, 65)
close.AutoButtonColor = false
close.ZIndex = 10
close.Parent = main

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 12)
closeCorner.Parent = close

close.MouseEnter:Connect(function()
	close.BackgroundColor3 = Color3.fromRGB(38, 22, 28)
end)

close.MouseLeave:Connect(function()
	close.BackgroundColor3 = Color3.fromRGB(24, 19, 25)
end)

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--==================================================
-- GAME LIST
--==================================================

local scroll = Instance.new("ScrollingFrame")
scroll.Name = "GameList"
scroll.Position = UDim2.fromOffset(26, 108)
scroll.Size = UDim2.new(1, -52, 1, -188)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(65, 65, 75)
scroll.CanvasSize = UDim2.new()
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 13)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

--==================================================
-- BOTTOM DIVIDER
--==================================================

local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 1, -78)
divider.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
divider.BorderSizePixel = 0
divider.Parent = main

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Position = UDim2.fromOffset(20, -1)
status.Size = UDim2.fromOffset(190, 76)
status.Font = Enum.Font.GothamBold
status.Text = "● SYSTEM: READY"
status.TextSize = 11
status.TextColor3 = GREEN
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = divider

local queue = Instance.new("TextLabel")
queue.BackgroundTransparency = 1
queue.Position = UDim2.new(1, -230, 0, 0)
queue.Size = UDim2.fromOffset(210, 76)
queue.Font = Enum.Font.GothamBold
queue.Text = "TELEPORT READY"
queue.TextSize = 11
queue.TextColor3 = Color3.fromRGB(75, 145, 255)
queue.TextXAlignment = Enum.TextXAlignment.Right
queue.Parent = divider

--==================================================
-- TELEPORT SCREEN
--==================================================

local function showTeleportScreen(gameData)

	scroll.Visible = false
	title.Visible = false
	subtitle.Visible = false
	close.Visible = false
	divider.Visible = false
	dragArea.Visible = false

	local screen = Instance.new("Frame")
	screen.Name = "TeleportScreen"
	screen.Size = UDim2.fromScale(1, 1)
	screen.BackgroundColor3 = BG
	screen.BorderSizePixel = 0
	screen.ZIndex = 20
	screen.Parent = main

	local screenCorner = Instance.new("UICorner")
	screenCorner.CornerRadius = UDim.new(0, 14)
	screenCorner.Parent = screen

	--==================================================
	-- SCREEN ACCENT
	--==================================================

	local screenAccent = Instance.new("Frame")
	screenAccent.Size = UDim2.new(1, 0, 0, 3)
	screenAccent.BackgroundColor3 = gameData.Color
	screenAccent.BorderSizePixel = 0
	screenAccent.ZIndex = 21
	screenAccent.Parent = screen

	--==================================================
	-- HEADING
	--==================================================

	local heading = Instance.new("TextLabel")
	heading.BackgroundTransparency = 1
	heading.Position = UDim2.fromOffset(20, 45)
	heading.Size = UDim2.new(1, -40, 0, 30)
	heading.Font = Enum.Font.GothamBold
	heading.Text = "TELEPORTING TO"
	heading.TextSize = 18
	heading.TextColor3 = gameData.Color
	heading.TextXAlignment = Enum.TextXAlignment.Center
	heading.ZIndex = 22
	heading.Parent = screen

	local gameHeading = Instance.new("TextLabel")
	gameHeading.BackgroundTransparency = 1
	gameHeading.Position = UDim2.fromOffset(20, 76)
	gameHeading.Size = UDim2.new(1, -40, 0, 35)
	gameHeading.Font = Enum.Font.GothamBold
	gameHeading.Text = string.upper(gameData.Name)
	gameHeading.TextSize = 22
	gameHeading.TextColor3 = TEXT
	gameHeading.TextXAlignment = Enum.TextXAlignment.Center
	gameHeading.ZIndex = 22
	gameHeading.Parent = screen

	--==================================================
	-- DESCRIPTION
	--==================================================

	local info = Instance.new("TextLabel")
	info.BackgroundTransparency = 1
	info.Position = UDim2.fromOffset(25, 125)
	info.Size = UDim2.new(1, -50, 0, 30)
	info.Font = Enum.Font.Gotham
	info.Text = "Your script link is ready."
	info.TextSize = 14
	info.TextColor3 = SUBTEXT
	info.TextXAlignment = Enum.TextXAlignment.Center
	info.ZIndex = 22
	info.Parent = screen

	--==================================================
	-- LINK BOX
	--==================================================

	local linkBox = Instance.new("TextBox")
	linkBox.Name = "ScriptLink"
	linkBox.Position = UDim2.fromOffset(35, 170)
	linkBox.Size = UDim2.new(1, -70, 0, 46)
	linkBox.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	linkBox.BorderSizePixel = 0
	linkBox.Font = Enum.Font.Gotham
	linkBox.Text = SCRIPT_LINK
	linkBox.TextSize = 12
	linkBox.TextColor3 = TEXT
	linkBox.ClearTextOnFocus = false
	linkBox.TextEditable = true
	linkBox.Selectable = true
	linkBox.TextXAlignment = Enum.TextXAlignment.Center
	linkBox.ZIndex = 23
	linkBox.Parent = screen

	local linkCorner = Instance.new("UICorner")
	linkCorner.CornerRadius = UDim.new(0, 10)
	linkCorner.Parent = linkBox

	local linkStroke = Instance.new("UIStroke")
	linkStroke.Color = Color3.fromRGB(55, 55, 65)
	linkStroke.Parent = linkBox

	--==================================================
	-- COPY MESSAGE
	--==================================================

	local copyText = Instance.new("TextLabel")
	copyText.BackgroundTransparency = 1
	copyText.Position = UDim2.fromOffset(25, 225)
	copyText.Size = UDim2.new(1, -50, 0, 24)
	copyText.Font = Enum.Font.Gotham
	copyText.Text = "Click the link box, then press Ctrl + C to copy."
	copyText.TextSize = 12
	copyText.TextColor3 = SUBTEXT
	copyText.TextXAlignment = Enum.TextXAlignment.Center
	copyText.ZIndex = 22
	copyText.Parent = screen

	--==================================================
	-- WARNING
	--==================================================

	local warning = Instance.new("TextLabel")
	warning.BackgroundTransparency = 1
	warning.Position = UDim2.fromOffset(30, 275)
	warning.Size = UDim2.new(1, -60, 0, 55)
	warning.Font = Enum.Font.Gotham
	warning.TextWrapped = true
	warning.Text = "If teleportation is unavailable, join the game manually\nand use the link above."
	warning.TextSize = 13
	warning.TextColor3 = Color3.fromRGB(190, 190, 200)
	warning.TextXAlignment = Enum.TextXAlignment.Center
	warning.ZIndex = 22
	warning.Parent = screen

	--==================================================
	-- PROGRESS BACKGROUND
	--==================================================

	local progressBG = Instance.new("Frame")
	progressBG.Position = UDim2.fromOffset(35, 350)
	progressBG.Size = UDim2.new(1, -70, 0, 8)
	progressBG.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	progressBG.BorderSizePixel = 0
	progressBG.ZIndex = 22
	progressBG.Parent = screen

	local progressBGCorner = Instance.new("UICorner")
	progressBGCorner.CornerRadius = UDim.new(1, 0)
	progressBGCorner.Parent = progressBG

	--==================================================
	-- PROGRESS
	--==================================================

	local progress = Instance.new("Frame")
	progress.Size = UDim2.new(0, 0, 1, 0)
	progress.BackgroundColor3 = gameData.Color
	progress.BorderSizePixel = 0
	progress.ZIndex = 23
	progress.Parent = progressBG

	local progressCorner = Instance.new("UICorner")
	progressCorner.CornerRadius = UDim.new(1, 0)
	progressCorner.Parent = progress

	--==================================================
	-- BACK BUTTON
	--==================================================

	local back = Instance.new("TextButton")
	back.Name = "Back"
	back.Position = UDim2.fromOffset(35, 400)
	back.Size = UDim2.new(1, -70, 0, 45)
	back.BackgroundColor3 = BUTTON
	back.BorderSizePixel = 0
	back.Text = "BACK TO GAMES"
	back.Font = Enum.Font.GothamBold
	back.TextSize = 12
	back.TextColor3 = Color3.fromRGB(190, 190, 200)
	back.AutoButtonColor = false
	back.ZIndex = 23
	back.Parent = screen

	local backCorner = Instance.new("UICorner")
	backCorner.CornerRadius = UDim.new(0, 10)
	backCorner.Parent = back

	back.MouseEnter:Connect(function()
		back.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
	end)

	back.MouseLeave:Connect(function()
		back.BackgroundColor3 = BUTTON
	end)

	back.MouseButton1Click:Connect(function()

		screen:Destroy()

		scroll.Visible = true
		title.Visible = true
		subtitle.Visible = true
		close.Visible = true
		divider.Visible = true
		dragArea.Visible = true

	end)

	--==================================================
	-- PROGRESS ANIMATION
	--==================================================

	task.spawn(function()

		for i = 0, 100 do

			if not progress.Parent then
				return
			end

			progress.Size = UDim2.new(i / 100, 0, 1, 0)

			task.wait(0.02)

		end

	end)

	--==================================================
	-- TELEPORT
	--==================================================

	task.delay(0.8, function()

		if screen.Parent and gameData.PlaceId > 0 then

			pcall(function()
				TeleportService:Teleport(gameData.PlaceId, player)
			end)

		end

	end)

end

--==================================================
-- GAME CARDS
--==================================================

for index, gameData in ipairs(GAMES) do

	local card = Instance.new("Frame")
	card.Name = gameData.Name
	card.Size = UDim2.new(1, -3, 0, 74)
	card.BackgroundColor3 = PANEL
	card.BorderSizePixel = 0
	card.LayoutOrder = index
	card.Parent = scroll

	local cardCorner = Instance.new("UICorner")
	cardCorner.CornerRadius = UDim.new(0, 14)
	cardCorner.Parent = card

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(42, 42, 52)
	stroke.Thickness = 1
	stroke.Parent = card

	--==================================================
	-- COLOR BAR
	--==================================================

	local bar = Instance.new("Frame")
	bar.Size = UDim2.fromOffset(6, 54)
	bar.Position = UDim2.fromOffset(15, 10)
	bar.BackgroundColor3 = gameData.Color
	bar.BorderSizePixel = 0
	bar.Parent = card

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(1, 0)
	barCorner.Parent = bar

	--==================================================
	-- GAME NAME
	--==================================================

	local name = Instance.new("TextLabel")
	name.BackgroundTransparency = 1
	name.Position = UDim2.fromOffset(33, 9)
	name.Size = UDim2.new(1, -180, 0, 28)
	name.Font = Enum.Font.GothamBold
	name.Text = gameData.Name
	name.TextSize = 17
	name.TextColor3 = TEXT
	name.TextXAlignment = Enum.TextXAlignment.Left
	name.Parent = card

	--==================================================
	-- DESCRIPTION
	--==================================================

	local description = Instance.new("TextLabel")
	description.BackgroundTransparency = 1
	description.Position = UDim2.fromOffset(34, 39)
	description.Size = UDim2.new(1, -180, 0, 20)
	description.Font = Enum.Font.Gotham
	description.Text = gameData.Description
	description.TextSize = 13
	description.TextColor3 = SUBTEXT
	description.TextXAlignment = Enum.TextXAlignment.Left
	description.Parent = card

	--==================================================
	-- JOIN BUTTON
	--==================================================

	local join = Instance.new("TextButton")
	join.Name = "Join"
	join.Size = UDim2.fromOffset(128, 39)
	join.Position = UDim2.new(1, -143, 0.5, -19)
	join.BackgroundColor3 = BUTTON
	join.BorderSizePixel = 0
	join.Text = "JOIN"
	join.Font = Enum.Font.GothamBold
	join.TextSize = 13
	join.TextColor3 = gameData.Color
	join.AutoButtonColor = false
	join.Parent = card

	local joinCorner = Instance.new("UICorner")
	joinCorner.CornerRadius = UDim.new(0, 10)
	joinCorner.Parent = join

	join.MouseEnter:Connect(function()
		join.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
	end)

	join.MouseLeave:Connect(function()
		join.BackgroundColor3 = BUTTON
	end)

	join.MouseButton1Click:Connect(function()
		showTeleportScreen(gameData)
	end)

end
