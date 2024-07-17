
Game = Class{__includes = BaseState}

function Game:init()
    self:reset()
end

function Game:update(dt)
    if love.keyboard.wasPressed("space") then
        state_machine:change("gameover")
    end
end

function Game:render()
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.rectangle('fill', 100, 100, 100, 100)
end


function Game:reset()
    self.score = Scoreboard(1, 10, 10)
end
