Tile = Class{}

function Tile:init(x, y, width, height)
    self.resetX = x
    self.resetY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Tile:reset()
    self.x = self.resetX
    self.y = self.resetY
end

function Tile:update(dt)

end

function Tile:render()
    love.graphics.color(0, 0, 0, 1)
    love.graphics.rectangle('fill', self.x, self.y, width, height)
end
