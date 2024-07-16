push = require 'libs.push.push'
Class = require 'libs.hump.class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WINDOW_WIDTH = 512
VIRTUAL_WINDOW_HEIGHT = 288

background = love.graphics.newImage('assets/images/flappy-bg.png')
ground = love.graphics.newImage('assets/images/flappy-gr.png')

function love.load()
    love.window.setTitle('flapper')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WINDOW_WIDTH, VIRTUAL_WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gameState = 'game'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, VIRTUAL_WINDOW_HEIGHT - 16)

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
