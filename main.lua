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
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1 = Paddle(10, VIRTUAL_WINDOW_HEIGHT / 2 - 10, 5, 20, 'w', 's')
    player2 = Paddle(VIRTUAL_WINDOW_WIDTH - 10, VIRTUAL_WINDOW_HEIGHT / 2 - 10, 5, 20, 'up', 'down')

    ball = Ball(VIRTUAL_WINDOW_HEIGHT / 2, VIRTUAL_WINDOW_WIDTH / 2, 5, 5)


    normalFont = love.graphics.newFont("assets/font/pokemon.ttf", 8)
    scoreFont = love.graphics.newFont("assets/font/pokemon.ttf", 32)

    score = Scoreboard(2, VIRTUAL_WINDOW_WIDTH / 2 - 50, VIRTUAL_WINDOW_HEIGHT / 3, 50, normalFont, scoreFont)

    gameState = 'start'
    
end

function love.update(dt)
    
    player1:update(dt)
    player2:update(dt)
    
    if gameState == 'play' then
        ball:update(dt)
    end
end


text = 'Hello Pong!'

function love.draw()

    push:start()

    player1:render()
    player2:render()
    ball:render()
    
    score:render()

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

            ball:reset()
        end
    end
end

-- function love.gamepadpressed(joystick, button)
--     text = button
-- end

-- function love.gamepadaxis(joystick, axis, value)
--     text = axis
-- end