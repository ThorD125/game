GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then        
        state_machine:change("server")
        ball:reset()
    end
    if score:checkWinner() then
        state_machine:change("winnder")
    end
end