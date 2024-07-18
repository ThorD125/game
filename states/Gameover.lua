GameOverState = Class{__includes = BaseState}

function GameOverState:render()
    love.graphics.setColor(colors.black)
    renderHugeText('Loser: '.. game.score:getScore(1))
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        game:reset()
        state_machine:change('countdown', game)
    end
end