MenuState = Class{__includes = BaseState}

function MenuState:render()
    renderHugeText('Press Enter to Start')
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown')
    end
end