Sprites = Class{__includes = BaseState}

function Sprites:init(img, x, y, x_count, y_count, positions)
    self.img = img
    self.x = x
    self.y = y
    self.x_count = x_count
    self.y_count = y_count
    
    self.width = self.img:getWidth()/self.x_count
    self.height = self.img:getHeight()/self.y_count
    
    self.positions = positions or {
            ["up"] = { 
                ["still"] = 9,
                ["left"] = 5,
                ["right"] = 1,
            },
            ["down"] = {
                ["still"] = 10,
                ["left"] = 6,
                ["right"] = 2,
            },
            ["left"] = {
                ["still"] = 12,
                ["right"] = 8,
                ["left"] = 4,
            },
            ["right"] = {
                ["still"] = 11,
                ["left"] = 7,
                ["right"] = 3,
            }
        }

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
            quads[self.quad_count] = love.graphics.newQuad(i*self.width, j*self.height, self.width, self.height, width, height)
        end
    end

    return quads
end

function Sprites:render(quad_count_position, x, y)
    resetColor()
    love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], math.floor(x or self.x), math.floor(y or self.y), 0, self.x_scale, self.y_scale)
    --     love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], (x or self.x) - virtual_window_width, y or self.y)
    -- elseif virtual_window_height - self:getHeight() < self.y then
    --     love.graphics.draw(self.img, self.quads[quad_count_position] or self.quads[1], x or self.x, (y or self.y) - virtual_window_height)
    -- end
end
