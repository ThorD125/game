Template = Class{}

function Template:init(x, y, width, height)
    self.resetX = x
    self.resetY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Template:reset()
    self.x = self.resetX
    self.y = self.resetY
end

function Template:update(dt)

end

function Template:render()
    love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end
