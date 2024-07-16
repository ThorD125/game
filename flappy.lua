push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.Pipe'
require 'classes.Bird'

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
    onepipe = Pipe(VIRTUAL_WINDOW_WIDTH, 100, 32, 50)
    bird = Bird(50, 100, 'space')

    gameState = 'game'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + backgroundScrollSpeed * dt) % backgroundLoopingPoint
    groundScroll = (groundScroll + groundScrollSpeed * dt) % VIRTUAL_WINDOW_WIDTH

    onepipe:update(dt)
    bird:update(dt)
end

function love.draw()
    push:start()

    
    love.graphics.draw(imgBackground, -backgroundScroll, 0)
    love.graphics.draw(imgGround, -groundScroll, VIRTUAL_WINDOW_HEIGHT - 16)

    onepipe:render()
    bird:render()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function displayFPS()
    love.graphics.setFont(font.Sm)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()) .. " GS: " .. gameState..server, 10, 10)
end
