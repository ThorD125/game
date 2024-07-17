Gameover = Class{__includes = BaseState}

function Gameover:render()
    renderHugeText('Loser: '.. game.score:getScore(1))
end

function Gameover:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:resetGame()
        stateMachine:change('countdown', game)
    end
end