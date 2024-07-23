require 'dependencies.match'

img = {
    ['background'] = love.graphics.newImage('assets/images/match/background.png'),
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
    
    menu = Menu("match",{
        {'START','play'},
        {'HIGHSCORE','highscore'},
    })

    background = Background(img.background, 0, background_scroll_speed)

    state_machine = StateMachine {
        ['menu'] = function() return menu end,
        -- ['enterhighscore'] = function() return EnterHighScoreState() end,
        -- ['highscore'] = function() return high_score_state end,
        -- ['gameover'] = function() return GameOverState() end,
        -- ['play'] = function() return PlayState() end,
           -- ['paddleselect'] = function() return PaddleSelectState() end,
        -- ['serve'] = function() return ServeState() end,
        -- ['victory'] = function() return VictoryState() end
        
    }
    
    state_machine:change('menu')
end

function love.update(dt)
    background:update(dt)
    state_machine:update(dt)
end

function love.draw()
    push:start()

    background:render()

    state_machine:render()
    
    push:finish()
end
