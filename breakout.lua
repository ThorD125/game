push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.StateMachine'

require 'classes.Scoreboard'

require 'states.BaseState'
require 'states.CountdownState'

require 'states.breakout.start'

window_width = 1280
window_height = 720
virtual_window_width = 512
virtual_window_height = 288

img = {
    ['arrows'] = love.graphics.newImage('assets/images/breakout/arrows.png'),
    ['background'] = love.graphics.newImage('assets/images/breakout/background.png'),
    ['blocks'] = love.graphics.newImage('assets/images/breakout/blocks.png'),
    ['breakout'] = love.graphics.newImage('assets/images/breakout/breakout.png'),
    ['main'] = love.graphics.newImage('assets/images/breakout/breakout.png'),
    ['hearts'] = love.graphics.newImage('assets/images/breakout/hearts.png'),
    ['particle'] = love.graphics.newImage('assets/images/breakout/particle.png'),
    ['ui'] = love.graphics.newImage('assets/images/breakout/ui.png'),
}

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
        ['start'] = function() return Start() end,
        -- ['highscore'] = function() return HighScore() end,
        -- ['enterhighscore'] = function() return EnterHighScore() end,
        -- ['gameover'] = function() return Gameover() end,
        -- ['game'] = function() return game end,
        -- ['paddleselect'] = function() return PaddleSelect() end,
        -- ['serve'] = function() return Serve() end,
        -- ['victory'] = function() return Victory() end
    }
    
    state_machine:change('start')
end

function love.update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    state_machine:update(dt)
end

function love.draw()
    push:start()
    love.graphics.draw(img.background, -background_scroll, 0)
    
    state_machine:render()
    
    push:finish()
end
