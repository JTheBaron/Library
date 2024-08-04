

local Library = {}

-- Create a new UI Frame
function Library:CreateFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0.8, 0)
    frame.Position = UDim2.new(0.1, 0, 0.1, 0)
    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    frame.BorderSizePixel = 0
    frame.Name = "MainFrame"
    return frame
end

-- Create a new Button
function Library:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.5, 0, 0.1, 0)
    button.Position = UDim2.new(0.25, 0, 0.2, 0)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.Text = text
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Create a new Label
function Library:CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0.1, 0)
    label.Position = UDim2.new(0.25, 0, 0.05, 0)
    label.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = parent
    return label
end

-- Create a new Toggle
function Library:CreateToggle(parent, text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.5, 0, 0.1, 0)
    toggle.Position = UDim2.new(0.25, 0, 0.35, 0)
    toggle.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    toggle.Text = text
    toggle.Parent = parent
    
    local isOn = false
    toggle.MouseButton1Click:Connect(function()
        isOn = not isOn
        callback(isOn)
        toggle.Text = text .. (isOn and " ON" or " OFF")
    end)
    return toggle
end

-- Create a new TextBox
function Library:CreateTextBox(parent, placeholderText, callback)
    local textbox = Instance.new("TextBox")
    textbox.Size = UDim2.new(0.5, 0, 0.1, 0)
    textbox.Position = UDim2.new(0.25, 0, 0.5, 0)
    textbox.BackgroundColor3 = Color3.new(0.9, 0.9, 0.9)
    textbox.PlaceholderText = placeholderText
    textbox.Parent = parent
    
    textbox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textbox.Text)
        end
    end)
    return textbox
end

-- Draggable functionality for frames
function Library:MakeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos
    
    local function update(input)
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
    
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
            update(input)
        end
    end)
end

return Library
