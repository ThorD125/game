
GameState = Class{__includes = BaseState}

function GameState:init()
    GameState:reset()
end

function GameState:update(dt)
    if love.keyboard.wasPressed("space") then
        state_machine:change("gameover")
    end
end

function GameState:render()
    love.graphics.setColor(1, 0, 0, 255)
    love.graphics.rectangle('fill', 100, 100, 100, 100)
end


function GameState:reset()
    GameState.score = Scoreboard(1, 10, 10)
end
