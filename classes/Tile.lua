Player = Class{}

function Player:init(x, y, width, height)
    self.resetX = x
    self.resetY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Player:reset()
    self.x = self.resetX
    self.y = self.resetY
end

function Player:update(dt)

end

function Player:render()
    love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end

function Player:up(dt)
    self.y = self.y - 1
end

function Player:down(dt)
    self.y = self.y + 1
end

function Player:left(dt)
    self.x = self.x - 1
end

function Player:right(dt)
    self.x = self.x + 1
end