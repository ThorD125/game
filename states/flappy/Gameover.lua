GameOverState = Class{__includes = BaseState}

function GameOverState:render()
    renderHugeText('Loser: '.. game.score:getScore(1), size[3])
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', {nextstate = "game"})
    end
end