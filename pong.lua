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

    game = GameState()

    state_machine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['game'] = function() return game end,
        ['serve'] = function() return ServeState() end,
        ['gameover'] = function() return GameOverState() end,
        ['winner'] = function() return WinState() end,
    }
    
    state_machine:change("menu")
end

function love.update(dt)
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end

    state_machine:update(dt)
end



function love.draw()
    push:start()
    
    state_machine:render()

    push:finish()
end
