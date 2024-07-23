Background = Class{__includes = BaseState}

function Background:init(img, x, x_speed, y, y_speed)
    self.img = img
    self.x = x or 0
    self.x_speed = x_speed or 0
    self.y = y or 0
    self.y_speed = y_speed or 0
    
    self.image_width = self.img:getWidth()
    self.image_height = self.img:getHeight()
    self.x_scale = virtual_window_width / (self.image_width -1)
    self.y_scale = virtual_window_height / (self.image_height -1)
end

function Background:render()
    love.graphics.draw(self.img, self.x, self.y, 0, self.x_scale, self.y_scale)
    love.graphics.draw(self.img, self.x + (self.image_width*self.x_scale), self.y, 0, self.x_scale, self.y_scale)
end

function Background:update(dt)
    self.x = self.x - self.x_speed * dt
    if (self.x + (self.image_width*self.x_scale)) < virtual_window_width - self.x_speed then
        self.x = 0
    end

    self.y = self.y - self.y_speed * dt
    if virtual_window_height < (self.y + (self.image_height*self.y_scale))  then
        self.y = 0
    end
end
