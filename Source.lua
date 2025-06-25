
local Player = game.Players.LocalPlayer
local bases = game.Workspace:WaitForChild("Bases")
local base = bases:FindFirstChild(Player.Name)
local basecollectpos
local TweenService = game:GetService("TweenService")
local process = false
local unlocked = false
local name

local lockPart = base:WaitForChild("LockPart")
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, lockPart, 0)
firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, lockPart, 1)
lockPart.DescendantRemoving:Connect(function(descendant)
    if descendant:IsA("IntValue") and descendant.Name == "Locked" then
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, lockPart, 0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, lockPart, 1)
    end
end)

for _,collect in pairs(base.Base:GetChildren()) do
    if collect:IsA("BasePart") and collect.Color == Color3.fromRGB(0, 255, 0) and collect:FindFirstChild("SurfaceGui") then
        basecollectpos = collect.Position
    end
end

for _, laser in pairs(bases:GetDescendants()) do
    if laser:IsA("Folder") and laser.Name == "LaserParts" then
        local part = laser:FindFirstChild("Part")
        if part then
            part:GetPropertyChangedSignal("Transparency"):Connect(function()
                if part.Transparency == 1 then
                    print(laser.Parent.Name .. "'s Base Unlocked")
                elseif part.Transparency == 0 then
                    print(laser.Parent.Name .. "'s Base Locked")
                    if name and name == laser.Parent.Name then
                        print("Lock")
                        unlocked = false
                        name = nil
                    end
                end

                if process == false and part.Transparency == 1 then
                    process = true
                    unlocked = true
                    name = laser.Parent.Name
                    local factory = laser.Parent:FindFirstChild("Factory")
                    if factory then
                        for _, anime in pairs(factory:GetDescendants()) do
                            if anime:IsA("BasePart") and anime.Name == "HumanoidRootPart" and anime:FindFirstChildOfClass("ProximityPrompt") then
                                local char = Player.Character
                                if char then
                                    local hrp = char:FindFirstChild("HumanoidRootPart")
                                    local ProximityPrompt = anime:FindFirstChild("ProximityPrompt")
                                    print(ProximityPrompt:GetFullName())
                                    if hrp then
                                        hrp.CFrame = anime.CFrame
                                        wait(0.20)
                                        fireproximityprompt(ProximityPrompt)
                                        wait(0.20)
                                        hrp.CFrame = CFrame.new(-463, 22, 551)
                                        wait(0.5)
                                        local goalCFrame2 = CFrame.new(-461, 22, 56)
                                        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                        local tween2 = TweenService:Create(hrp, tweenInfo, {CFrame = goalCFrame2})
                                        tween2:Play()
                                        wait(0.5)
                                        local goalCFrame = CFrame.new(basecollectpos) * CFrame.new(0, 3, 0)
                                        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = goalCFrame})
                                        tween:Play()
                                        print("Unlocked: ".. tostring(unlocked))
                                        if unlocked == false then
                                            process = false
                                            break
                                        else
                                            wait(1)
                                        end
                                    end
                                end
                            else
                                unlocked = false
                                process = false
                            end
                        end
                    end
                end
            end)
        end
    end
end

function sell()
    local Player = game.Players.LocalPlayer
    local bases = game.Workspace:WaitForChild("Bases")
    local base = bases:FindFirstChild(Player.Name)
    local prompts = {}

    if base then
        for _, descendant in pairs(base:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Name == "HumanoidRootPart" then
                local prompt = descendant:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    table.insert(prompts, prompt)
                end
            end
        end
    end

    task.spawn(function()
        for _, prompt in ipairs(prompts) do
            local char = Player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(prompt.Parent.Position + Vector3.new(0, 3, 0))
            end

            task.wait(0.1)
            fireproximityprompt(prompt)
        end
    end)
end 

while true do
    wait(40)
    if process == false then
        sell()
        process = true
        wait(1)
        process = false
    end
end

queueonteleport('loadstring(game:HttpGet('https://raw.githubusercontent.com/FocusKerem/StealAnimeScript/refs/heads/main/Source.lua'))()
')
