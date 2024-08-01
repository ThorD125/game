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
    -- ['full_sheet'] = love.graphics.newImage('assets/images/mario/full_sheet.png'),
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

sprites = {
    ['backgrounds'] = Sprites(img.backgrounds, 0, 0, 1, 3),
    ['blue_alien'] = Sprites(img.blue_alien, 0, 0, 11, 1),
    ['bushes_and_cacti'] = Sprites(img.bushes_and_cacti, 0, 0, 7, 5),
    ['buttons'] = Sprites(img.buttons, 0, 0, 4, 4),
    ['coins_and_bombs'] = Sprites(img.coins_and_bombs, 0, 0, 3, 2),
    ['crates_and_blocks'] = Sprites(img.crates_and_blocks, 0, 0, 4, 3),
    ['creatures'] = Sprites(img.creatures, 0, 0, 8, 7),
    ['doors_and_windows'] = Sprites(img.doors_and_windows, 0, 0, 8, 4),
    ['faces_and_hills'] = Sprites(img.faces_and_hills, 0, 0, 9, 6),
    ['fireballs'] = Sprites(img.fireballs, 0, 0, 4, 6),
    ['flags'] = Sprites(img.flags, 0, 0, 9, 4),
    -- full_sheet = Sprites(img.full_sheet, 0, 0, 1, 1)
    ['gems'] = Sprites(img.gems, 0, 0, 4, 2),
    ['green_alien'] = Sprites(img.green_alien, 0, 0, 11, 1),
    ['hearts'] = Sprites(img.hearts, 0, 0, 6, 1),
    ['jump_blocks'] = Sprites(img.jump_blocks, 0, 0, 6, 5),
    ['keys_and_locks'] = Sprites(img.keys_and_locks, 0, 0, 4, 2),
    ['ladders_and_signs'] = Sprites(img.ladders_and_signs, 0, 0, 7, 5),
    ['mushrooms'] = Sprites(img.mushrooms, 0, 0, 5, 9),
    ['numbers'] = Sprites(img.numbers, 0, 0, 10, 1),
    ['pink_alien'] = Sprites(img.pink_alien, 0, 0, 11, 1),
    ['tiles'] = Sprites(img.tiles, 0, 0, 6, 10),
    ['tile_tops'] = Sprites(img.tile_tops, 0, 0, 6, 18),
    ['water'] = Sprites(img.water, 0, 0, 8, 2),
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
