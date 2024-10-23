-- Made by Zingorr, Added to PizzaFactoryRemix by CSWC - 10/23/24
wait(1)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30.9692764, 7.01014566, -443.712738, -0.0368146226, -1.18420891e-08, 0.999322116, 3.6141059e-09, 1, 1.19832642e-08, -0.999322116, 4.05281542e-09, -0.0368146226)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local ffc = game.FindFirstChild

-- **Rough** List of houses with their CFrame coordinates
local houses = {
    CFrame.new(-30.9692764, 7.01014566, -443.712738), -- B1 house
    CFrame.new(40.7544098, 7.00028086, -475.953979), -- B2 house
    CFrame.new(-38.2014313, 7.00008202, -615.995056), -- B3 house
    CFrame.new(34.1237526, 7.01029873, -651.582153), -- B4 house
    CFrame.new(-42.5083694, 6.76008797, -790.086792), -- B5 house
    CFrame.new(40.8492317, 7.00034046, -835.990112), -- B6 house
    CFrame.new(199.163635, 7.01033974, -460.003845), -- A1 house
    CFrame.new(206.516586, 7.00039196, -652.140869), -- A2 house
    CFrame.new(206.499451, 7.00038719, -824.087158), -- A3 house
    CFrame.new(-202.378128, 6.99999475, -435.736633), -- C1 house
    CFrame.new(-202.514328, 7.00004816, -621.020203), -- C2 house
    CFrame.new(-206.497513, 6.76011705, -789.92749) -- C3 house
}

local function typeofHouse(houseId)
    local houseObj = workspace.Houses:FindFirstChild(houseId) -- Assuming house names like "House1", "House2", etc.
    if houseObj then
        return houseObj
    else
        return nil
    end
end

-- Iterate over each house
local function teleportToHouses()
    local args1 = {
        [1] = player.Character.Head.face,
        [2] = "http://www.roblox.com/asset/?id=144080495"
    }
    workspace.Main.ChangeFace:FireServer(unpack(args1))
    wait(0.1)
    
    local args2 = { [1] = "ToolHold" }
    workspace.Animation.AnimationStarted:FireServer(unpack(args2))
    wait(0.1)

    for h, houseCFrame in ipairs(houses) do
        character.HumanoidRootPart.CFrame = houseCFrame
        local house = typeofHouse("House" .. h)
        
        if house then
            house.Doors.FrontDoorMain.ClickDetector.Detector:FireServer()
        else
            warn("House not found: House" .. h)
        end
        
        wait(8) -- Wait for 8 seconds before moving to the next house
    end
end

-- Start
teleportToHouses()
