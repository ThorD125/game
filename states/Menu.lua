MenuState = Class{__includes = BaseState}

function MenuState:render()
    love.graphics.setColor(colors.black)
    renderHugeText('Press Enter to Start', size[1])
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', {nextstate = "game"})
    end
end