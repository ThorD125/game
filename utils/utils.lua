function renderHugeText(text, x, y)
    love.graphics.setFont(font.Xl)
    love.graphics.printf(text, x or 0, y or 50, virtual_window_width, 'center')
    resetColor()
end

function displayFPS()
    love.graphics.setFont(font.Sm)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    resetColor()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    
    if key == 'escape' then
        love.event.quit()
    end
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