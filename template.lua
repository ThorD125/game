push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.StateMachine'

require 'classes.Scoreboard'

require 'states.BaseState'
require 'states.CountdownState'

require 'states.Menu'
require 'states.Game'
require 'states.Gameover'

window_width = 1280
window_height = 720
virtual_window_width = 512
virtual_window_height = 288

img_background = love.graphics.newImage('assets/images/background.png')

background_scroll = 0
background_scroll_speed = 30
ground_scroll = 0
ground_scroll_speed = 60

function love.load()
    love.window.setTitle('template')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(virtual_window_width, virtual_window_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    game = Game()

    state_machine = StateMachine {
        ['menu'] = function() return Menu() end,
        ['countdown'] = function() return CountdownState() end,
        ['game'] = function() return game end,
        ['gameover'] = function() return Gameover() end
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
    love.graphics.draw(img_background, -background_scroll, 0)
    
    state_machine:render()
    
    push:finish()
end
