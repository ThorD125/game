
GameState = Class{__includes = BaseState}

function GameState:init()
    GameState:reset()
end

function GameState:update(dt)
    if love.keyboard.wasPressed("space") then
        GameState.bird:jump()
    end

    for i, pipe in pairs(GameState.pipes) do
        pipe:update(dt)
    end

    if GameState.bird.y < 0 or GameState.bird.y > virtual_window_height then
        state_machine:change('gameover')
    end

    if GameState.bird:collides(GameState.pipes[1]) then
        state_machine:change('gameover')
    end

    if GameState.bird.x + (GameState.bird.width/2) > GameState.pipes[1].x + (pipe_width/2) then
        table.remove(GameState.pipes, 1)
        table.insert(GameState.pipes, Pipe(GameState.pipes[#GameState.pipes].x + pipe_width*2, 100, 60))
        GameState.score:addCount(1)
        sound.collision:play()
    end

    GameState.bird:update(dt)
end

function GameState:render()
    for i, pipe in pairs(GameState.pipes) do
        pipe:render()
    end
    GameState.bird:render()
    GameState.score:render()
end


function GameState:reset()
    GameState.score = Scoreboard(1, 10, 10)
    GameState.pipes = {}

    for i = 1, pipe_amount do
        pipeFirstOffset = math.random(virtual_window_width/4,virtual_window_width - (virtual_window_width/4) - 60)
        GameState.pipes[i] = Pipe((virtual_window_width/2) + 2 * i * pipe_width, pipeFirstOffset, 60)
    end

    GameState.bird = Bird(50, 100, 'space')
end
