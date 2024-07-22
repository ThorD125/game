function renderHugeText(text, size, x, y)
    love.graphics.setFont(font[size])
    if x == nil then
        x = 0
    end
    textwidth = virtual_window_width - (2*x)
    love.graphics.printf(text, x or 0, y or 50, textwidth, 'center')
    resetColor()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

love.keyboard.keysPressed = {}

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function resetColor()
    love.graphics.setColor(colors.white)
end

function backgroundRender(background)
    local image_width = background:getWidth()
    local image_height = background:getHeight()
    local scale_x = virtual_window_width / (image_width -1)
    local scale_y = virtual_window_height / (image_height -1)
    love.graphics.draw(background, 0, 0, 0, scale_x, scale_y)
end
