Gameover = Class{__includes = BaseState}

function Gameover:render()
    love.graphics.setColor(colors.black)
    renderHugeText('Loser: '.. game.score:getScore(1))
end

function Gameover:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', game)
    end
end