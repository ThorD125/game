push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.StateMachine'

require 'classes.Pipe'
require 'classes.Bird'
require 'classes.Scoreboard'

require 'states.BaseState'
require 'states.CountdownState'

require 'states.flappy.Menu'
require 'states.flappy.Game'
require 'states.flappy.Gameover'

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

    resetGame()

    gStateMachine = StateMachine {
        ['menu'] = function() return Menu() end,
        ['countdown'] = function() return CountdownState() end,
        ['game'] = function() return Game() end,
        ['gameover'] = function() return Gameover() end

    }
    gStateMachine:change('menu')
end

function resetGame()
    score = Scoreboard(1, 10, 10)
    pipes = {}

    -- i = 1
    for i = 1, pipeamount do
        pipeFirstOffset = math.random(VIRTUAL_WINDOW_WIDTH/4,VIRTUAL_WINDOW_WIDTH - (VIRTUAL_WINDOW_WIDTH/4) - 60)
        pipes[i] = Pipe((VIRTUAL_WINDOW_WIDTH/2) + 2 * i * PIPE_WIDTH, pipeFirstOffset, 60)
    end

    bird = Bird(50, 100, 'space')
end


function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) % backgroundLoopingPoint
    groundScroll = (groundScroll + groundScrollSpeed * dt) % VIRTUAL_WINDOW_WIDTH

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    gStateMachine:update(dt)
end

function love.draw()
    push:start()
    love.graphics.draw(imgBackground, -backgroundScroll, 0)
    
    gStateMachine:render()
    
    love.graphics.draw(imgGround, -groundScroll, VIRTUAL_WINDOW_HEIGHT - 16)

    displayFPS()
    push:finish()
end
