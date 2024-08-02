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

    background = Background(img.background)
    high_score_state = HighScoreState()

    pause_state = Menu("Breakout", {
        { 'START',     'play' },
        { 'HIGHSCORE', 'highscore' },
    })
    state_machine = StateMachine {
        ['start'] = function() return StartState() end,
        -- ['enterhighscore'] = function() return EnterHighScoreState() end,
        ['highscore'] = function() return high_score_state end,
        -- ['gameover'] = function() return GameOverState() end,
        ['play'] = function() return PlayState() end,
        -- ['paddleselect'] = function() return PaddleSelectState() end,
        -- ['serve'] = function() return ServeState() end,
        -- ['victory'] = function() return VictoryState() end

    }

    state_machine:change('start')
end

function love.update(dt)
    state_machine:update(dt)
end

function love.draw()
    push:start()

    background:render()

    state_machine:render()

    push:finish()
end
