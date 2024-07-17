push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.Pipe'
require 'classes.Bird'
require 'classes.Scoreboard'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WINDOW_WIDTH = 512
VIRTUAL_WINDOW_HEIGHT = 288

imgBackground = love.graphics.newImage('assets/images/flappy/bg.png')
imgGround = love.graphics.newImage('assets/images/flappy/gr.png')
imgPipe = love.graphics.newImage('assets/images/flappy/pipe.png') 
imgBird = love.graphics.newImage('assets/images/flappy/bird.png') 

backgroundScroll = 0
backgroundScrollSpeed = 30
groundScroll = 0
groundScrollSpeed = 60

backgroundLoopingPoint = 413 --this is where the image repeats

pipeSpeed = 40
GRAVITY = 20
pipeFirstOffset = 60

pipeamount = (VIRTUAL_WINDOW_WIDTH / 2) / imgPipe:getWidth() + 2
PIPE_WIDTH = imgPipe:getWidth()

function love.load()
    love.window.setTitle('flapper')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    font = {
        ['Sm'] = love.graphics.newFont("assets/font/pokemon.ttf", 8),
        ['l'] = love.graphics.newFont("assets/font/pokemon.ttf", 8),
        ['Xl'] = love.graphics.newFont("assets/font/pokemon.ttf", 16),
        ['XXl'] = love.graphics.newFont("assets/font/pokemon.ttf", 32)
    }

    setupGame()

    gameState = 'menu'
end

function setupGame()
    score = Scoreboard(1, 10, 10)
    pipes = {}

    -- i = 1
    for i = 1, pipeamount do
        pipeFirstOffset = pipeFirstOffset + math.random(-20, 20)
        pipes[i] = Pipe((VIRTUAL_WINDOW_WIDTH/2) + 2 * i * PIPE_WIDTH, pipeFirstOffset, 60)
    end

    bird = Bird(50, 100, 'space')
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

    if gameState == 'game' then
        backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) % backgroundLoopingPoint
        groundScroll = (groundScroll + groundScrollSpeed * dt) % VIRTUAL_WINDOW_WIDTH

        for i, pipe in pairs(pipes) do
            pipe:update(dt)
        end

        if bird.y < 0 or bird.y > VIRTUAL_WINDOW_HEIGHT then
            gameState = 'gameover'
        end



        -- for i, pipe in pairs(pipes) do
            if bird:collides(pipes[1]) then
                gameState = 'gameover'
            end
        -- end
        if bird.x + (bird.width/2) > pipes[1].x + (PIPE_WIDTH/2) then
            table.remove(pipes, 1)
            table.insert(pipes, Pipe(pipes[#pipes].x + PIPE_WIDTH*2, 100, 60))
            score:addCount(1)
        end

        bird:update(dt)
    end

end

function love.draw()
    push:start()

    renderGame()
    if gameState == 'menu' then
        renderMenu()
    end
    if gameState == 'gameover' then
        renderGameOver()
    end

    displayFPS()
    push:finish()
end

function renderGame()
    love.graphics.draw(imgBackground, -backgroundScroll, 0)
    love.graphics.draw(imgGround, -groundScroll, VIRTUAL_WINDOW_HEIGHT - 16)

    for i, pipe in pairs(pipes) do
        pipe:render()
    end
    bird:render()
    score:render()
end

function renderGameOver()
    love.graphics.setFont(font.Xl)
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf('Loser: '.. score:getScore(1), 0, 50, VIRTUAL_WINDOW_WIDTH, 'center')
end

function renderMenu()
    love.graphics.setFont(font.Xl)
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf('Press Enter to Start', 0, 50, VIRTUAL_WINDOW_WIDTH, 'center')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'enter' or key == 'return' then
        if gameState == 'gameover' then
            setupGame()
        end
        gameState = 'game'
    end
    if gameState == 'game' then
        if key == "space" then
            gameState = 'game'
            bird:jump()
        end
    end
end


function displayFPS()
    love.graphics.setFont(font.Sm)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()) .. " GS: " .. gameState, 10, 10)
end
