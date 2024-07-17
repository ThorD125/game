Gameover = Class{__includes = BaseState}

function Gameover:render()
    renderHugeText('Loser: '.. score:getScore(1))
end

function Gameover:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        resetGame()
        gStateMachine:change('countdown', game)
    end
end