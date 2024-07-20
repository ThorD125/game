HealthBar_Minecraft = Class{__includes = BaseState}

function HealthBar_Minecraft:init(current_hearts, hearts_max, x, y)
    self.reset_current_hearts = current_hearts*2
    self.reset_hearts_max = hearts_max*2
    self.reset_x = x
    self.reset_y = y
    
    self.width = img_main.hearts:getWidth()
    self.height = img_main.hearts:getHeight()
    
    self:reset()
end

function HealthBar_Minecraft:update(dt) 
    -- if love.keyboard.wasPressed('g') then
    --     self:loseHeart()
    -- elseif love.keyboard.wasPressed('h') then
    --     self:healHeart()
    -- end
end

function HealthBar_Minecraft:loseHeart()
    self.current_hearts = self.current_hearts - 1
end

function HealthBar_Minecraft:healHeart()
    self.current_hearts = self.current_hearts + 1
end

function HealthBar_Minecraft:render(dt)
    for i = 1, self.hearts_max do
        if i <= self.current_hearts then
            if i % 2 == 0 then
                love.graphics.draw(img_main.hearts, self.quads[2], self.x + (i * 5), self.y)
            else
                love.graphics.draw(img_main.hearts, self.quads[1], self.x + (i * 5), self.y)
            end
        else
            if i % 2 == 0 then
                love.graphics.draw(img_main.hearts, self.quads[4], self.x + (i * 5), self.y)                    
            else
                love.graphics.draw(img_main.hearts, self.quads[3], self.x + (i * 5), self.y)
            end
        end
    end
end

function HealthBar_Minecraft:reset()
    self.hearts_max = self.reset_hearts_max
    self.current_hearts = self.reset_current_hearts
    
    if (self.reset_x < (virtual_window_width - (self.reset_hearts_max * 5) - 4)) then
        self.x = self.reset_x
    else
        self.x = virtual_window_width - (self.reset_hearts_max * 5) - 4
    end
    if (self.reset_y < virtual_window_height) then
        self.y = self.reset_y
    else
        self.y = virtual_window_height - self.height
    end

    self.quads = self.GenerateHalfHearthQuads(img_main.hearts)
end

function HealthBar_Minecraft:GenerateHalfHearthQuads(atlas)
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
