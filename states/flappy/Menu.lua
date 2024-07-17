Menu = Class{__includes = BaseState}

function Menu:render()
    renderHugeText('Press Enter to Start')
end

function Menu:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:resetGame()
        stateMachine:change('countdown', "game")
    end
end