GameState = Class{__includes = BaseState}

function GameState:update(dt)
    ball:update(dt)

    if ball:collides(player1) then
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 5

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end

    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 4

        if ball.dy < 0 then
            ball.dy = -math.random(10, 150)
        else
            ball.dy = math.random(10, 150)
        end
    end

    if ball.x < 0 then
        score:addCount(2)
        ball:reset()
        server = 2
            state_machine:change("gameover")
    elseif ball.x > virtual_window_width then
        score:addCount(1)
        ball:reset()
        server = 1
            state_machine:change("gameover")
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then    
        state_machine:change("menu")
        score:reset()
        ball:reset()
    end
end

function GameState:render()
    player1:render()
    player2:render()
    ball:render()
end