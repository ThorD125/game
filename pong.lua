push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.Ball'
require 'classes.Paddle'
require 'classes.Scoreboard'

window_width = 1280
window_height = 720
virtual_window_width = 432
virtual_window_height = 243
paddle_speed = 200
x_to_win = 10

function love.load()
    love.window.setTitle('Pong')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(virtual_window_width, virtual_window_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1 = Paddle(10, virtual_window_height / 2 - 10, 5, 20, 'w', 's')
    player2 = Paddle(virtual_window_width - 10, virtual_window_height / 2 - 10, 5, 20, 'up', 'down')
    server = 1
    ball = Ball(virtual_window_width / 2, virtual_window_height / 2, 5, 5)
    score = Scoreboard(2, virtual_window_width / 2 - 50, virtual_window_height / 3, 50)

    game_state = 'menu'
end

function love.update(dt)
    player1:update(dt)
    player2:update(dt)

    if game_state == 'serve' then
        if server == 1 then
            ball.dx = 100
        else
            ball.dx = -100
        end

        game_state = 'inGame'
    end
    
    if game_state == 'inGame' then
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
            game_state = 'gameEnded'
        elseif ball.x > virtual_window_width then
            score:addCount(1)
            ball:reset()
            server = 1
            game_state = 'gameEnded'
        end
    end

    if game_state == 'gameEnded' then
        if score:checkWinner() then
            game_state = 'winner'
        end
    end
end



function love.draw()
    push:start()
    
    player1:render()
    player2:render()
    ball:render()
    
    score:render()
    
    if game_state == 'winner' then
        love.graphics.setFont(font.XXl)
        love.graphics.setColor(0, 255, 0, 255)
        
        
        if 1 == score:checkWinner() then
            love.graphics.print(tostring("player1"), virtual_window_width/2, virtual_window_height/2)
        else 
            love.graphics.print(tostring("player2"), virtual_window_width/2, virtual_window_height/2)
        end
        
        resetColor()
    end

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if game_state == 'menu' then
            game_state = 'serve'
        elseif game_state == "gameEnded" then
            game_state = 'serve'
            ball:reset()
        else
            game_state = 'menu'
            score:reset()
            ball:reset()
        end
    end
end
