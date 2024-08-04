-- LibraryModule.lua

local Library = {}

-- Function to create a frame
function Library:CreateFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Visible = true
    return frame
end

-- Function to create a label
function Library:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 50)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    label.BorderSizePixel = 0
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = parent
    return label
end

-- Function to create a button
function Library:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = UDim2.new(0, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.MouseButton1Click:Connect(callback)
    button.Parent = parent
    return button
end

-- Function to create a toggle
function Library:CreateToggle(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 50)
    toggle.Position = UDim2.new(0, 0, 0, 100)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
    return toggle
end

-- Function to create a text box
function Library:CreateTextBox(parent, placeholder, callback)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 50)
    textBox.Position = UDim2.new(0, 0, 0, 150)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
