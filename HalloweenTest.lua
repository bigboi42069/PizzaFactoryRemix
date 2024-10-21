if getconnections then
	for _,c in next, getconnections(game:GetService("ScriptContext").Error) do
		c:Disable()
	end
end

local player = game:GetService("Players").LocalPlayer
local ffc = game.FindFirstChild
local character, root, humanoid

local function getHousePart(address)
	local houses = workspace.Houses:GetChildren()
	for i = 1, #houses do
		local h = houses[i]
		if ffc(h, "Address") and h.Address.Value == address and ffc(h, "GivePizza", true) then
			return ffc(h, "GivePizza", true)
		end
	end
end

local function onCharacterAdded(char)
	if not char then return end
	character = char
	root = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	humanoid:SetStateEnabled("FallingDown", false)
end

onCharacterAdded(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(onCharacterAdded)

local function smoothTP2(cf)
	local cf0 = (cf - cf.p) + root.Position + Vector3.new(0, 4, 0)
	local diff = cf.p - root.Position
	local oldg = workspace.Gravity
	workspace.Gravity = 0
	for i = 0, diff.Magnitude, 0.9 do
		humanoid.Sit = false
		root.CFrame = cf0 + diff.Unit * i
		root.Velocity, root.RotVelocity = Vector3.new(), Vector3.new()
		wait()
	end
	root.CFrame = cf
	workspace.Gravity = oldg
end

local function smoothTP(cf)
	if (cf.p - root.Position).Magnitude > 95 then
		local btns = workspace.JobButtons:GetChildren()
		if player:FindFirstChild("House") and player.House.Value then
			btns[#btns + 1] = player.House.Value:FindFirstChild("Marker")
		end
		table.sort(btns, function(a, b) 
			return (a.Position - cf.p).Magnitude < (b.Position - cf.p).Magnitude 
		end)
		if (btns[1].Position - cf.p).Magnitude < (cf.p - root.Position).Magnitude then
			game:GetService("ReplicatedStorage").PlayerChannel:FireServer("TeleportToJob", ((btns[1].Name == "Marker") and "House" or btns[1].Name))
			wait(0.7)
			if (cf.p - root.Position).Magnitude < 8 then
				return
			end
		end
	end
	smoothTP2(cf)
end

local function main()
	local fatass = false
	for i = 1, 12 do
		humanoid.Sit = false
		local giver = getHousePart("House"..i)
		if giver then
			local ogp = giver.Position
			if (giver.Position - root.Position).Magnitude > 9 then
				smoothTP(giver.CFrame + Vector3.new(0, 7, 0))
				if giver.Parent == nil or (giver.Position - ogp).Magnitude > 1 then
					giver = getHousePart("House"..i) or giver
					smoothTP(giver.CFrame + Vector3.new(0, 7, 0))
				end
				wait(10)
				fatass = false
			else
				if fatass then
					wait(0.2)
				else
					wait(0.7)
				end
				wait()
				fatass = true
			end
		end
	end
	delTick = tick()
end

main()
