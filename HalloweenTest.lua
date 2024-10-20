-- Function to teleport smoothly using a CFrame position
local function smoothTP(cf)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
end

-- Infinite loop to repeat the actions
while true do
    for i = 1, 12 do
        local house = "House" .. i  -- Capital 'H' in the house names

        -- Check if the house exists in the workspace
        if workspace.Houses:FindFirstChild(house) then
            -- Reference to the giver part of the house (assuming the giver is a specific part at the house)
            local giver = workspace.Houses[house].Medium.Giver -- Update this path if "Giver" part is named differently
            
            -- Get the player's current position
            local root = game.Players.LocalPlayer.Character.HumanoidRootPart

            -- Calculate the distance between the player and the giver
            local distance = (giver.Position - root.Position).Magnitude

            -- If the distance is greater than 9 studs, teleport the player to the giver's position
            if distance > 9 then
                smoothTP(giver.CFrame + Vector3.new(0, 7, 0))  -- Offset by 7 on Y-axis to avoid clipping
            end

            -- Wait for a short time after teleporting
            wait(1)

            -- Define arguments to change the location to the porch
            local args = {
                [1] = "LocationChanged",
                [2] = "Porch",
                [3] = workspace.Houses[house]
            }

            -- Fire the location change event
            game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(args))

            -- Fire the front door's click detector
            local frontDoor = workspace.Houses[house].Medium.Doors.FrontDoorMain.ClickDetector.Detector
            frontDoor:FireServer()

            -- Wait 5 seconds between each house action
            wait(5)
        else
            warn("House " .. house .. " not found!")
        end
    end

    -- Wait 5 seconds before restarting the loop
    wait(5)
end
