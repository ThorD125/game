Pipe = Class{}


function Pipe:init(x, y, gapHeight)
    self.x = x
    self.y = y
    self.width = PIPE_WIDTH
    self.height = imgPipe:getHeight()
    self.gapHeight = gapHeight
end

function Pipe:update(dt)
    self.x = self.x - (dt*pipeSpeed)
end

function Pipe:render()
    love.graphics.draw(imgPipe, self.x, self.y)
    love.graphics.draw(imgPipe, self.x, self.y - self.gapHeight, 0, 1, -1)
end
