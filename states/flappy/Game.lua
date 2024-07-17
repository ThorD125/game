
Game = Class{__includes = BaseState}

function Game:update(dt)
    if love.keyboard.wasPressed("space") then
        bird:jump()
    end

    for i, pipe in pairs(pipes) do
        pipe:update(dt)
    end

    if bird.y < 0 or bird.y > VIRTUAL_WINDOW_HEIGHT then
        gStateMachine:change('gameover')
    end

    if bird:collides(pipes[1]) then
        gStateMachine:change('gameover')
    end

    if bird.x + (bird.width/2) > pipes[1].x + (PIPE_WIDTH/2) then
        table.remove(pipes, 1)
        table.insert(pipes, Pipe(pipes[#pipes].x + PIPE_WIDTH*2, 100, 60))
        score:addCount(1)
        sound.collision:play()
    end

    bird:update(dt)
end

function Game:render()
    for i, pipe in pairs(pipes) do
        pipe:render()
    end
    bird:render()
    score:render()
end
