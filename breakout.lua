require 'dependencies.template'
require 'dependencies.breakout'



img = {
    ['arrows'] = love.graphics.newImage('assets/images/breakout/arrows.png'),
    ['background'] = love.graphics.newImage('assets/images/breakout/background.png'),
    ['blocks'] = love.graphics.newImage('assets/images/breakout/blocks.png'),
    ['breakout'] = love.graphics.newImage('assets/images/breakout/breakout.png'),
    ['hearts'] = love.graphics.newImage('assets/images/breakout/hearts.png'),
    ['particle'] = love.graphics.newImage('assets/images/breakout/particle.png'),
    ['ui'] = love.graphics.newImage('assets/images/breakout/ui.png'),
}

-- img = {
--     ['background'] = love.graphics.newImage('graphics/background.png'),
--     ['main'] = love.graphics.newImage('graphics/breakout.png'),
--     ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
--     ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
--     ['particle'] = love.graphics.newImage('graphics/particle.png')
-- }
frames = {
    ['arrows'] = GenerateQuads(img.arrows, 24, 24),
    ['paddles'] = GenerateQuadsPaddles(img.breakout),
    ['balls'] = GenerateQuadsBalls(img.breakout),
    ['bricks'] = GenerateQuadsBricks(img.breakout),
    ['hearts'] = GenerateQuads(img.hearts, 10, 9)
}

function love.load()
    love.window.setTitle('template')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())

    push:setupScreen(virtual_window_width, virtual_window_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    state_machine = StateMachine {
        ['start'] = function() return StartState() end,
        -- ['highscore'] = function() return HighScore() end,
        -- ['enterhighscore'] = function() return EnterHighScore() end,
        -- ['gameover'] = function() return Gameover() end,
        ['play'] = function() return PlayState() end,
        -- ['paddleselect'] = function() return PaddleSelect() end,
        -- ['serve'] = function() return Serve() end,
        -- ['victory'] = function() return Victory() end
    }
    
    state_machine:change('start')
end

function love.update(dt)
    state_machine:update(dt)
end

function love.draw()
    push:start()

    backgroundRender(img.background)

    state_machine:render()
    
    push:finish()
end
