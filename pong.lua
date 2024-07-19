require 'dependencies.template'
require 'dependencies.pong'

function love.load()
    love.window.setTitle('Pong')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(virtual_window_width, virtual_window_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1 = Paddle(10, virtual_window_height / 2 - 10, 5, 20, 'w', 's')
    player2 = Paddle(virtual_window_width - 10, virtual_window_height / 2 - 10, 5, 20, 'up', 'down')
    server = 1
    ball = Ball(virtual_window_width / 2, virtual_window_height / 2, 5, 5)
    score = Scoreboard(2, virtual_window_width / 2 - 50, virtual_window_height / 3, 50)

    state_machine = StateMachine {
        ['game'] = function() return GameState() end,
        ['serve'] = function() return ServeState() end,
        ['menu'] = function() return MenuState() end,
        ['gameover'] = function() return GameOverState() end,
        ['winner'] = function() return WinState() end,
    }
    

    state_machine:change("menu")
end

function love.update(dt)

    state_machine:update(dt)
    player1:update(dt)
    player2:update(dt)
    
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end



function love.draw()
    push:start()
    
    state_machine:render()
    score:render()

    push:finish()
end
