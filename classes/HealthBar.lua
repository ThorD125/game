HealthBar = Class{}

function HealthBar:init(current_hearts, hearts_max, x, y, img)
    self.reset_current_hearts = current_hearts
    self.reset_hearts_max = hearts_max *2
    self.reset_x = x
    self.reset_y = y
    self.reset_img = img
    
    self.width = self.reset_img:getWidth()
    self.height = self.reset_img:getHeight()
    
    self:reset()
end

function HealthBar:loseHeart()
    self.hearts = self.current_hearts - 1
end

function HealthBar:healHeart()
    self.hearts = self.current_hearts + 1
end

function HealthBar:render(dt)
    for i = 1, self.hearts_max do
        if i <= self.current_hearts then
            if i % 2 == 0 then
                love.graphics.draw(img_main.hearts, self.quads[2], self.x + (i * 5) - 5, self.y)
            else
                love.graphics.draw(img_main.hearts, self.quads[1], self.x + (i * 5) - 5, self.y)
            end
        else
            if i % 2 == 0 then
                love.graphics.draw(img_main.hearts, self.quads[4], self.x + (i * 5) - 5, self.y)
            else
                love.graphics.draw(img_main.hearts, self.quads[3], self.x + (i * 5) - 5, self.y)
            end
        end
    end
end

function HealthBar:reset()
    self.hearts_max = self.reset_hearts_max
    self.current_hearts = self.reset_current_hearts
    
    self.x = (self.reset_x < virtual_window_width) and self.reset_x or (virtual_window_width - self.width)
    self.y = (self.reset_y < virtual_window_height) and self.reset_y or (virtual_window_height - self.height)

    self.img = self.reset_img


    self.quads = GenerateHalfHearthQuads(img_main.hearts)
end

function GenerateHalfHearthQuads(atlas)
    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(i*9, 0, 5, 9, img_main.hearts)
        counter = counter + 1
        quads[counter] = love.graphics.newQuad((i*9)+5, 0, 5, 9, img_main.hearts)
        counter = counter + 1
    end

    return quads
end
