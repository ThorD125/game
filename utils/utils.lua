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
