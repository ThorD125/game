function renderHugeText(text)
    love.graphics.setFont(font.Xl)
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf(text, 0, 50, VIRTUAL_WINDOW_WIDTH, 'center')
end

function displayFPS()
    love.graphics.setFont(font.Sm)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
