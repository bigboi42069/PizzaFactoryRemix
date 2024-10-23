-- Made by Zingorr, Added to PizzaFactoryRemix by CSWC - 10/23/24
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.9692764, 7.01014566, -443.712738)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- **Rough** List of houses with their CFrame coordinates
local houses = {
    House1 = CFrame.new(199.163635, 7.01033974, -460.003845), -- A1 house
    House2 = CFrame.new(206.516586, 7.00039196, -652.140869), -- A2 house
    House3 = CFrame.new(206.499451, 7.00038719, -824.087158), -- A3 house
    House4 = CFrame.new(-30.9692764, 7.01014566, -443.712738), -- B1 house
    House5 = CFrame.new(40.7544098, 7.00028086, -475.953979), -- B2 house
    House6 = CFrame.new(-38.2014313, 7.00008202, -615.995056), -- B3 house
    House7 = CFrame.new(34.1237526, 7.01029873, -651.582153), -- B4 house
    House8 = CFrame.new(-42.5083694, 6.76008797, -790.086792), -- B5 house
    House9 = CFrame.new(40.8492317, 7.00034046, -835.990112), -- B6 house
    House10 = CFrame.new(-202.378128, 6.99999475, -435.736633), -- C1 house
    House11 = CFrame.new(-202.514328, 7.00004816, -621.020203),  -- C2 house
    House12 = CFrame.new(-206.497513, 6.76011705, -789.92749) -- C3 house
}

-- Function to find any ClickDetector in a house
local function fireAnyClickDetector(house)
    for _, child in pairs(house:GetChildren()) do
        if child:IsA("Model") then
            for _, doorChild in pairs(child:GetChildren()) do
                if doorChild:IsA("Model") and doorChild:FindFirstChild("ClickDetector") then
                    local detector = doorChild.ClickDetector:FindFirstChild("Detector")
                    if detector then
                        detector:FireServer()  -- Fire the ClickDetector
                        return true  -- Successfully fired the ClickDetector
                    end
                end
            end
        end
    end
    return false  -- No ClickDetector found
end

-- Function to teleport to houses and interact with ClickDetectors
local function teleportToHouses()
    local args1 = {
        [1] = player.Character.Head.face,
        [2] = "http://www.roblox.com/asset/?id=144080495"
    }
    workspace.Main.ChangeFace:FireServer(unpack(args1))
    wait(0.1)

    local args2 = {
        [1] = "ToolHold"
    }
    workspace.Animation.AnimationStarted:FireServer(unpack(args2))
    wait(0.1)

    for houseName, houseCFrame in pairs(houses) do
        character.HumanoidRootPart.CFrame = houseCFrame  -- Teleport to the house
        local house = workspace.Houses:FindFirstChild(houseName)

        if house then
            local success = fireAnyClickDetector(house)  -- Try to fire any ClickDetector

            if not success then
                warn("ClickDetector not found in " .. houseName)  -- Log if it wasn't found
            end
        end
        
        wait(8)  -- Wait for 8 seconds before the next house
    end
end

-- Start the teleportation and interaction
teleportToHouses()
