-- LibraryModule.lua

local Library = {}

-- Function to create a frame
function Library:CreateFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 300) -- Smaller size for mobile compatibility
    frame.Position = UDim2.new(0.5, -175, 0.5, -150) -- Centered position
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Visible = true
    frame.ClipsDescendants = true

    -- Header for dragging and title
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    header.BorderSizePixel = 0
    header.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Kavo UI Clone"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -40, 0.5, -15)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 18
    closeButton.Parent = header
    closeButton.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)

    return frame
end

-- Function to create a label
function Library:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = parent
    return label
end

-- Function to create a button
function Library:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.MouseButton1Click:Connect(callback)
    button.Parent = parent

    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)

    return button
end

-- Function to create a toggle
function Library:CreateToggle(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    toggle.BorderSizePixel = 0
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Text = text .. " OFF"
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 16
    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        toggle.Text = text .. (isOn and " ON" or " OFF")
        callback(isOn)
    end)
    toggle.Parent = parent

    -- Hover effect
    toggle.MouseEnter:Connect(function()
        toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    toggle.MouseLeave:Connect(function()
        toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)

    return toggle
end

-- Function to create a text box
function Library:CreateTextBox(parent, placeholder, callback)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 40)
    textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    textBox.BorderSizePixel = 0
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderText = placeholder
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.ClearTextOnFocus = false
    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)
    textBox.Parent = parent

    return textBox
end

-- Function to make frame draggable
function Library:MakeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

return Library
