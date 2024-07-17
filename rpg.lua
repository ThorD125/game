push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.Player'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WINDOW_WIDTH = 256
VIRTUAL_WINDOW_HEIGHT = 192

tileWidth = VIRTUAL_WINDOW_WIDTH / 15
tileHeight = VIRTUAL_WINDOW_HEIGHT / 15


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

    setupGame()

    gameState = 'game'
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    if love.keyboard.isDown('up') then
        player:up(dt)
    end
    if love.keyboard.isDown('down') then
        player:down(dt)
    end
    if love.keyboard.isDown('left') then
        player:left(dt)
    end
    if love.keyboard.isDown('right') then
        player:right(dt)
    end
end

function love.draw()
    push:start()
    
    local scaleX = VIRTUAL_WINDOW_WIDTH / background:getWidth()
    local scaleY = VIRTUAL_WINDOW_HEIGHT / background:getHeight()
    
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

    renderGame()

    displayFPS()
    push:finish()
end

function setupGame()
    player = Player(50, 50, 50, 50)
end

function renderGame()
    player:render()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
