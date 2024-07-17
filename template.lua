push = require 'libs.push.push'
Class = require 'libs.hump.class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
virtual_window_width = 432
virtual_window_height = 243

background = love.graphics.newImage('assets/images/background.png')

function love.load()
    love.window.setTitle('atitle')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(virtual_window_width, virtual_window_height, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    setupGame()

    gameState = 'game'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    
end

function love.draw()
    push:start()
    
    local scaleX = virtual_window_width / background:getWidth()
    local scaleY = virtual_window_height / background:getHeight()
    
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

    renderGame()

    push:finish()
end

function setupGame()
    text = 'setupgame'
end

function renderGame()
    love.graphics.setFont(font.Sm)
    love.graphics.setColor(255,255,255,255)
    love.graphics.print(text, 50, 50)
    resetColor()
end



function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
