push = require 'libs.push.push'
Class = require 'libs.hump.class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WINDOW_WIDTH = 432
VIRTUAL_WINDOW_HEIGHT = 243

background = love.graphics.newImage('assets/images/background.png')

function love.load()
    love.window.setTitle('atitle')
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

    gameState = 'game'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    
end

function love.draw()
    push:start()
    
    local scaleX = VIRTUAL_WINDOW_WIDTH / background:getWidth()
    local scaleY = VIRTUAL_WINDOW_HEIGHT / background:getHeight()
    
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

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
