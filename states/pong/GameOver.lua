GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then        
        state_machine:change("serve")
        game.ball:reset()
    end
    if game.score:checkWinner() then
        state_machine:change("winner")
    end
end

function GameOverState:render()
    love.graphics.setColor(colors.white)
    renderHugeText('Press enter to continue', size[3])
    game.score:render()
end