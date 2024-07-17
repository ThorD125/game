
Game = Class{__includes = BaseState}

function Game:init()
    self:resetGame()
end

function Game:update(dt)
    if love.keyboard.wasPressed("space") then
        self.bird:jump()
    end

    for i, pipe in pairs(self.pipes) do
        pipe:update(dt)
    end

    if self.bird.y < 0 or self.bird.y > virtual_window_height then
        state_machine:change('gameover')
    end

    if self.bird:collides(self.pipes[1]) then
        state_machine:change('gameover')
    end

    if self.bird.x + (self.bird.width/2) > self.pipes[1].x + (pipe_width/2) then
        table.remove(self.pipes, 1)
        table.insert(self.pipes, Pipe(self.pipes[#self.pipes].x + pipe_width*2, 100, 60))
        self.score:addCount(1)
        sound.collision:play()
    end

    self.bird:update(dt)
end

function Game:render()
    for i, pipe in pairs(self.pipes) do
        pipe:render()
    end
    self.bird:render()
    self.score:render()
end


function Game:resetGame()
    self.score = Scoreboard(1, 10, 10)
    self.pipes = {}

    for i = 1, pipe_amount do
        pipeFirstOffset = math.random(virtual_window_width/4,virtual_window_width - (virtual_window_width/4) - 60)
        self.pipes[i] = Pipe((virtual_window_width/2) + 2 * i * pipe_width, pipeFirstOffset, 60)
    end

    self.bird = Bird(50, 100, 'space')
end
