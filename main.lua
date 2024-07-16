-- function love.draw()
--     love.graphics.print("Hello World", 400, 300)
-- end
push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.Ball'
require 'classes.Paddle'
require 'classes.Scoreboard'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243

PADDLE_SPEED = 200



function love.load()
    -- love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    --     fullscreen = false,
    --     resizable = false,
    --     vsync = true
    -- })
    love.window.setTitle('Pong')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1 = Paddle(10, VIRTUAL_WINDOW_HEIGHT / 2 - 10, 5, 20, 'w', 's')
    player2 = Paddle(VIRTUAL_WINDOW_WIDTH - 10, VIRTUAL_WINDOW_HEIGHT / 2 - 10, 5, 20, 'up', 'down')
    server = 1

    ball = Ball(VIRTUAL_WINDOW_HEIGHT / 2, VIRTUAL_WINDOW_WIDTH / 2, 5, 5)


    fontSm = love.graphics.newFont("assets/font/pokemon.ttf", 8)
    font = love.graphics.newFont("assets/font/pokemon.ttf", 8)
    fontXl = love.graphics.newFont("assets/font/pokemon.ttf", 16)
    fontXXl = love.graphics.newFont("assets/font/pokemon.ttf", 32)

    score = Scoreboard(2, VIRTUAL_WINDOW_WIDTH / 2 - 50, VIRTUAL_WINDOW_HEIGHT / 3, 50)

    gameState = 'menu'
    
end

function love.update(dt)
    
    player1:update(dt)
    player2:update(dt)

    if gameState == 'serve' then
        if server == 1 then
            ball.dx = 100
        else
            ball.dx = -100
        end
        gameState = 'inGame'
    end

    
    if gameState == 'inGame' then
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
            gameState = 'gameEnded'
        elseif ball.x > VIRTUAL_WINDOW_WIDTH then
            score:addCount(1)
            ball:reset()
            server = 1
            gameState = 'gameEnded'
        end
    end
end



function love.draw()
    
    push:start()
    
    player1:render()
    player2:render()
    ball:render()
    
    score:render()
    
    displayFPS()
    push:finish()
end

function love.keypressed(key)
    text = key
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if gameState == 'menu' then
            gameState = 'serve'
        elseif gameState == "gameEnded" then
            gameState = 'serve'
            ball:reset()
        else
            gameState = 'menu'
            score:reset()
            ball:reset()
        end
    end
end

function displayFPS()
    love.graphics.setFont(fontSm)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()) .. " GS: " .. gameState..server, 10, 10)
end
-- function love.gamepadpressed(joystick, button)
--     text = button
-- end

-- function love.gamepadaxis(joystick, axis, value)
--     text = axis
-- end