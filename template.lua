
require 'dependencies.template'

require 'states.Menu'
require 'states.Game'
require 'states.Gameover'
require 'classes.example_movement'
require 'classes.example_cube'
require 'utils.utils'


function love.load()
    love.window.setTitle('template')
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
        ['countdown'] = function() return CountdownState() end,
        ['game'] = function() return game end,
        ['gameover'] = function() return GameOverState() end
    }
    
    state_machine:change('menu')
end

function love.update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    state_machine:update(dt)
end

function love.draw()
    push:start()
    

    backgroundRender(img.background)
    
    state_machine:render()
    
    push:finish()
end
