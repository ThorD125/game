Sprites = Class{__includes = BaseState}

function Sprites:init(img, x, y, x_count, y_count)
    self.img = img
    self.x = x
    self.y = y
    self.x_count = x_count
    self.y_count = y_count
    self.width_quads = self:getWidth()
    self.height_quads = self:getHeight()

    self.quads = self:Quads()
end

function Sprites:Quads()
    local quads = {}
    local width = self.img:getWidth()
    local height = self.img:getHeight()
    
    self.quad_count = 0

    for i=0, self.x_count-1 do
        for j=0, self.y_count-1 do
            self.quad_count = self.quad_count + 1
            quads[self.quad_count] = love.graphics.newQuad(i*self.width_quads, j*self.height_quads, self.width_quads, self.height_quads, width, height)
        end
    end

    return quads
end

function Sprites:getWidth()
    return self.img:getWidth()/self.x_count
end

function Sprites:getHeight()
    return self.img:getHeight()/self.y_count
end

function Sprites:render(quad_count_position, x, y)
    resetColor()
    love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], x or self.x, y or self.y)
    if virtual_window_width - self:getWidth() < self.x then
        love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], (x or self.x) - virtual_window_width, y or self.y)
    elseif virtual_window_height - self:getHeight() < self.y then
        love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], x or self.x, (y or self.y) - virtual_window_height)
    end
end
