-- 🔥 GUI MULTIBOTONES CON MELASA 🔥 -- Versión con minimizar, mover, y ejecutar scripts por botones

local player = game:GetService("Players").LocalPlayer local playerGui = player:WaitForChild("PlayerGui")

-- GUI PRINCIPAL local gui = Instance.new("ScreenGui") gui.Name = "MelasaGUI" gui.Parent = playerGui

-- FRAME PRINCIPAL local mainFrame = Instance.new("Frame") mainFrame.Size = UDim2.new(0, 300, 0, 350) mainFrame.Position = UDim2.new(0.1, 0, 0.3, 0) mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) mainFrame.BorderSizePixel = 0 mainFrame.Active = true mainFrame.Draggable = true mainFrame.Parent = gui

-- BOTÓN DE MINIMIZAR local minimizeButton = Instance.new("TextButton") minimizeButton.Size = UDim2.new(0, 30, 0, 30) minimizeButton.Position = UDim2.new(1, -35, 0, 5) minimizeButton.Text = "-" minimizeButton.TextScaled = true minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0) minimizeButton.TextColor3 = Color3.new(1, 1, 1) minimizeButton.Parent = mainFrame

-- CONTENEDOR DE BOTONES local buttonHolder = Instance.new("Frame") buttonHolder.Size = UDim2.new(1, -20, 1, -50) buttonHolder.Position = UDim2.new(0, 10, 0, 40) buttonHolder.BackgroundTransparency = 1 buttonHolder.Parent = mainFrame

-- FUNCIÓN PARA CREAR BOTONES local function createButton(text, callback, order) local button = Instance.new("TextButton") button.Size = UDim2.new(1, 0, 0, 40) button.Position = UDim2.new(0, 0, 0, (order - 1) * 45) button.Text = text button.TextScaled = true button.BackgroundColor3 = Color3.fromRGB(60, 60, 60) button.TextColor3 = Color3.new(1, 1, 1) button.Font = Enum.Font.GothamBold button.Parent = buttonHolder button.MouseButton1Click:Connect(callback) end

-- LISTA DE SCRIPTS Y BOTONES createButton("1 audio", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/nmalka01/nmalka01/refs/heads/main/Brookhaven_audio"))() end, 1)

createButton("2 audio", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ameicaa1/brookhaven-script/main/brookhaven%20script.lua"))() end, 2)

createButton("1 bring parts", function() loadstring(game:HttpGet("https://rawscripts.net/raw/Natural-Disaster-Survival-Blackhole-Tool-Control-Unanc*d-Parts-27791"))() end, 3)

createButton("2 bring parts", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yofriendfromschool1/Sky-Hub/main/FE%20Trolling%20GUI.luau"))() end, 4)

createButton("3 bring parts", function() loadstring(game:HttpGet("https://pastebin.com/raw/Q3Fjw3PZ"))() end, 5)

createButton("4 bring parts (blackhole)", function() loadstring([[ -- Código largo insertado correctamente local Players = game:GetService("Players") local RunService = game:GetService("RunService") local LocalPlayer = Players.LocalPlayer local Workspace = game:GetService("Workspace")

local angle = 1
    local radius = 10
    local blackHoleActive = false

    local function setupPlayer()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local Folder = Instance.new("Folder", Workspace)
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        return humanoidRootPart, Attachment1
    end

    local humanoidRootPart, Attachment1 = setupPlayer()

    if not getgenv().Network then
        getgenv().Network = {
            BaseParts = {},
            Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
        }

        Network.RetainPart = function(part)
            if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
                table.insert(Network.BaseParts, part)
                part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                part.CanCollide = false
            end
        end

        local function EnablePartControl()
            LocalPlayer.ReplicationFocus = Workspace
            RunService.Heartbeat:Connect(function()
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
                for _, part in pairs(Network.BaseParts) do
                    if part:IsDescendantOf(Workspace) then
                        part.Velocity = Network.Velocity
                    end
                end
            end)
        end

        EnablePartControl()
    end

    local function ForcePart(v)
        if v:IsA("Part") and not v.Anchored and not v.Parent:FindFirstChild("Humanoid") and not v.Parent:FindFirstChild("Head") and v.Name ~= "Handle" then
            for _, x in next, v:GetChildren() do
                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                    x:Destroy()
                end
            end
            if v:FindFirstChild("Attachment") then
                v:FindFirstChild("Attachment"):Destroy()
            end
            if v:FindFirstChild("AlignPosition") then
                v:FindFirstChild("AlignPosition"):Destroy()
            end
            if v:FindFirstChild("Torque") then
                v:FindFirstChild("Torque"):Destroy()
            end
            v.CanCollide = false

            local Torque = Instance.new("Torque", v)
            Torque.Torque = Vector3.new(1000000, 1000000, 1000000)
            local AlignPosition = Instance.new("AlignPosition", v)
            local Attachment2 = Instance.new("Attachment", v)
            Torque.Attachment0 = Attachment2
            AlignPosition.MaxForce = math.huge
            AlignPosition.MaxVelocity = math.huge
            AlignPosition.Responsiveness = 500
            AlignPosition.Attachment0 = Attachment2
            AlignPosition.Attachment1 = Attachment1
        end
    end

    local function toggleBlackHole()
        blackHoleActive = not blackHoleActive
        if blackHoleActive then
            for _, v in next, Workspace:GetDescendants() do
                ForcePart(v)
            end

            Workspace.DescendantAdded:Connect(function(v)
                if blackHoleActive then
                    ForcePart(v)
                end
            end)

            spawn(function()
                while blackHoleActive and RunService.RenderStepped:Wait() do
                    angle = angle + math.rad(2)

                    local offsetX = math.cos(angle) * radius
                    local offsetZ = math.sin(angle) * radius

                    Attachment1.WorldCFrame = humanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
                end
            end)
        else
            Attachment1.WorldCFrame = CFrame.new(0, -1000, 0)
        end
    end

    LocalPlayer.CharacterAdded:Connect(function()
        humanoidRootPart, Attachment1 = setupPlayer()
        if blackHoleActive then
            toggleBlackHole()
        end
    end)

    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()
    local window = library:Window("Projeto LKB")

    window:Slider("Radius Blackhole",1,100,10, function(Value)
       radius = Value
    end)

    window:Toggle("Blackhole", true, function(Value)
           if Value then
                toggleBlackHole()
            else
                blackHoleActive = false
            end
    end)

    spawn(function()
        while true do
            RunService.RenderStepped:Wait()
            if blackHoleActive then
                angle = angle + math.rad(angleSpeed)
            end
        end
    end)

    toggleBlackHole()
]])()

end, 6)

-- BOLA DE MINIMIZAR local miniBall = Instance.new("TextButton") miniBall.Size = UDim2.new(0, 60, 0, 60) miniBall.Position = UDim2.new(0, 20, 0, 300) miniBall.Text = "📦" miniBall.Visible = false miniBall.BackgroundColor3 = Color3.fromRGB(0, 120, 255) miniBall.TextColor3 = Color3.new(1, 1, 1) miniBall.TextScaled = true miniBall.Parent = gui miniBall.Active = true miniBall.Draggable = true

-- FUNCIONALIDAD DE MINIMIZAR Y MAXIMIZAR minimizeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false miniBall.Visible = true end)

miniBall.MouseButton1Click:Connect(function() mainFrame.Visible = true miniBall.Visible = false end)

-- OPCIONAL: ajustar el parent si necesitas correrlo desde StarterGui manualmente gui.ResetOnSpawn = false

