StartState = Class{__includes = BaseState}

function StartState:render()
    love.graphics.setColor(colors.black)
    renderHugeText('Press Enter to Start')
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', "game")
    end
end