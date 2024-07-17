Menu = Class{__includes = BaseState}

function Menu:render()
    love.graphics.setColor(colors.black)
    renderHugeText('Press Enter to Start')
end

function Menu:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', "game")
    end
end