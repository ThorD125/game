require 'dependencies.mario'

img = {
    ['backgrounds'] = love.graphics.newImage('assets/images/mario/backgrounds.png'),
    ['blue_alien'] = love.graphics.newImage('assets/images/mario/blue_alien.png'),
    ['bushes_and_cacti'] = love.graphics.newImage('assets/images/mario/bushes_and_cacti.png'),
    ['buttons'] = love.graphics.newImage('assets/images/mario/buttons.png'),
    ['coins_and_bombs'] = love.graphics.newImage('assets/images/mario/coins_and_bombs.png'),
    ['crates_and_blocks'] = love.graphics.newImage('assets/images/mario/crates_and_blocks.png'),
    ['creatures'] = love.graphics.newImage('assets/images/mario/creatures.png'),
    ['doors_and_windows'] = love.graphics.newImage('assets/images/mario/doors_and_windows.png'),
    ['faces_and_hills'] = love.graphics.newImage('assets/images/mario/faces_and_hills.png'),
    ['fireballs'] = love.graphics.newImage('assets/images/mario/fireballs.png'),
    ['flags'] = love.graphics.newImage('assets/images/mario/flags.png'),
    ['full_sheet'] = love.graphics.newImage('assets/images/mario/full_sheet.png'),
    ['gems'] = love.graphics.newImage('assets/images/mario/gems.png'),
    ['green_alien'] = love.graphics.newImage('assets/images/mario/green_alien.png'),
    ['hearts'] = love.graphics.newImage('assets/images/mario/hearts.png'),
    ['jump_blocks'] = love.graphics.newImage('assets/images/mario/jump_blocks.png'),
    ['keys_and_locks'] = love.graphics.newImage('assets/images/mario/keys_and_locks.png'),
    ['ladders_and_signs'] = love.graphics.newImage('assets/images/mario/ladders_and_signs.png'),
    ['mushrooms'] = love.graphics.newImage('assets/images/mario/mushrooms.png'),
    ['numbers'] = love.graphics.newImage('assets/images/mario/numbers.png'),
    ['pink_alien'] = love.graphics.newImage('assets/images/mario/pink_alien.png'),
    ['tiles'] = love.graphics.newImage('assets/images/mario/tiles.png'),
    ['tile_tops'] = love.graphics.newImage('assets/images/mario/tile_tops.png'),
    ['water'] = love.graphics.newImage('assets/images/mario/water.png'),
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
    

    background = Background(img.backgrounds, 0, background_scroll_speed)
    
    menu = Menu("",{
        {'START','countdown'},
        {'HIGHSCORE','highscore'},
    })

    state_machine = StateMachine {
        ['menu'] = function() return menu end,
        ['countdown'] = function () return CountdownState() end,
        ['play'] = function () return PlayState() end,
        
        -- ['start'] = function() return StartState() end,
        -- ['enterhighscore'] = function() return EnterHighScoreState() end,
        -- ['highscore'] = function() return high_score_state end,
        -- ['gameover'] = function() return GameOverState() end,
        -- ['play'] = function() return PlayState() end,
           -- ['paddleselect'] = function() return PaddleSelectState() end,
        -- ['serve'] = function() return ServeState() end,
        -- ['victory'] = function() return VictoryState() end
        
    }
    
    -- state_machine:change('menu')
    state_machine:change('play')
    -- state_machine:change('countdown')
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
