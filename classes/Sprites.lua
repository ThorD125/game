Sprites = Class{__includes = BaseState}

function Sprites:init(img, x, y, x_count, y_count)
    self.img = img
    self.x = x
    self.y = y
    self.x_count = x_count
    self.y_count = y_count
    self.width_quads = self.img:getWidth()/self.x_count
    self.height_quads = self.img:getHeight()/self.y_count

    self.quads = self:Quads()
end

function Sprites:Quads()
    local quads = {}
    local width = self.img:getWidth()
    local height = self.img:getHeight()
    
    local counter = 0

    for i=0, self.x_count-1 do
        for j=0, self.y_count-1 do
            quads[counter] = love.graphics.newQuad(i*self.width_quads, j*self.height_quads, self.width_quads, self.height_quads, width, height)
            counter = counter + 1
        end
    end

    return quads
end

function Sprites:render(position)
    resetColor()
    if position then
        love.graphics.draw(self.img, self.quads[position], self.x, self.y)
    else
        love.graphics.draw(self.img, self.quads[0], self.x, self.y)
    end
end
