Template = Class{__includes = BaseState}

function Template:init(x, y, width, height)
    self.reset_x = x
    self.reset_y = y
    self.x = self.reset_x
    self.y = self.reset_y
    self.width = width
    self.height = height
end

function Template:reset()
    self.x = self.reset_x
    self.y = self.reset_y
end

function Template:update(dt)

end

function Template:render()
    love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end
