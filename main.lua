-- function love.draw()
--     love.graphics.print("Hello World", 400, 300)
-- end
push = require 'libs.push.push'
Class = require 'libs.hump.class'

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
    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    normalFont = love.graphics.newFont('assets/font/pokemon.ttf', 8)
    scoreFont = love.graphics.newFont('assets/font/pokemon.ttf', 32)

    love.graphics.setFont(normalFont)

    push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 10
    player2Y = VIRTUAL_WINDOW_HEIGHT - 30
    
    ballX = VIRTUAL_WINDOW_HEIGHT / 2
    ballY = VIRTUAL_WINDOW_WIDTH / 2
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start'
end

function love.update(dt)
    if love.keyboard.isDown('w') and love.keyboard.isDown('s') then
        player1Y = player1Y
    elseif love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_WINDOW_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') and love.keyboard.isDown('down') then
        player2Y = player2Y
    elseif love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_WINDOW_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end


text = 'Hello Pong!'

function love.draw()

    push:start()

    love.graphics.rectangle('fill', ballY, ballX, 5, 5)

    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WINDOW_WIDTH - 10, player2Y, 5, 20)

    love.graphics.setFont(normalFont)
    love.graphics.printf(
        text,          -- text to render
        0,                      -- starting X (0 since we're going to center it based on width)
        VIRTUAL_WINDOW_WIDTH / 2 - 6,  -- starting Y (halfway down the screen)
        VIRTUAL_WINDOW_HEIGHT,           -- number of pixels to center within (the entire screen here)
        'center')               -- alignment mode, can be 'center', 'left', or 'right'
    
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WINDOW_WIDTH / 2 - 50, VIRTUAL_WINDOW_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WINDOW_WIDTH / 2 + 30, VIRTUAL_WINDOW_HEIGHT / 3)
    
    push:finish()
end

function love.keypressed(key)
    text = key
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ballX = VIRTUAL_WINDOW_HEIGHT / 2
            ballY = VIRTUAL_WINDOW_WIDTH / 2
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50, 50)
        
        end
    end
end

-- function love.gamepadpressed(joystick, button)
--     text = button
-- end

-- function love.gamepadaxis(joystick, axis, value)
--     text = axis
-- end