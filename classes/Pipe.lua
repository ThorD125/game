Pipe = Class{}


function Pipe:init(x, y, width, height) --y is gap height location
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Pipe:update(dt)
    self.x = self.x - (dt*pipeSpeed)
end

function Pipe:render()
    love.graphics.draw(imgPipe, self.x, self.y)
    love.graphics.draw(imgPipe, self.x, self.y - self.height, 0, 1, -1)
end
