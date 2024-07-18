Pipe = Class{}


function Pipe:init(x, y, gapHeight)
    self.x = x
    self.y = y
    self.width = pipe_width
    self.height = img.pipe:getHeight()
    self.gapHeight = gapHeight
end

function Pipe:update(dt)
    self.x = self.x - (dt*pipe_speed)
end

function Pipe:render()
    love.graphics.draw(img.pipe, self.x, self.y)
    love.graphics.draw(img.pipe, self.x, self.y - self.gapHeight, 0, 1, -1)
end
