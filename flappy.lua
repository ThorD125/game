push = require 'libs.push.push'
Class = require 'libs.hump.class'

require 'classes.StateMachine'

require 'classes.Pipe'
require 'classes.Bird'
require 'classes.Scoreboard'

require 'states.Base'
require 'states.Countdown'

require 'states.flappy.Menu'
require 'states.flappy.Game'
require 'states.flappy.Gameover'

window_width = 1280
window_height = 720
virtual_window_width = 512
virtual_window_height = 288

img = {
    ['background'] = love.graphics.newImage('assets/images/flappy/background.png'),
    ['ground'] = love.graphics.newImage('assets/images/flappy/ground.png'),
    ['pipe'] = love.graphics.newImage('assets/images/flappy/pipe.png') ,
    ['bird'] = love.graphics.newImage('assets/images/flappy/bird.png') ,
}

background_scroll = 0
background_scroll_speed = 30
ground_scroll = 0
ground_scroll_speed = 60

background_looping_point = 413 --this is where the image repeats

pipe_speed = 40
gravity = 20
pipe_first_offset = 60

pipe_amount = (virtual_window_width / 2) / ['pipe']:getWidth() + 2,
pipe_width = img.pipe:getWidth()

function love.load()
    love.window.setTitle('flapper')
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
    background_scroll = (background_scroll + background_scroll_speed * dt) % background_looping_point
    ground_scroll = (ground_scroll + ground_scroll_speed * dt) % virtual_window_width

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    state_machine:update(dt)
end

function love.draw()
    push:start()
    love.graphics.draw(img.background, -background_scroll, 0)
    
    state_machine:render()
    
    love.graphics.draw(img.ground, -ground_scroll, virtual_window_height - 16)
    push:finish()
end
