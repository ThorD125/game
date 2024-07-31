Character = Class{__includes = BaseState}

function Character:init(sprite_image, sprite_x_amount, sprite_y_amount, up, down, left, right, speed)
    self.image = love.graphics.newImage(sprite_image)
    self.sprite = Sprites(self.image, 0, 0, sprite_x_amount, sprite_y_amount)

    -- self.movement = Movement(virtual_window_width/2, virtual_window_height/2, self.sprite:getWidth(),self.sprite:getWidth(), "up", "down", "left", "right", speed)
    self.movement = Movement(virtual_window_width/2, virtual_window_height/2, self.sprite:getWidth(),self.sprite:getWidth(), up, down, left, right, speed)

    self.level = 0

    self.health = HealthBar_Minecraft(10,10, (virtual_window_width/2), virtual_window_height)
end

function Character:update(dt)
    self.movement:update(dt)

    self.sprite.x = self.movement.x
    self.sprite.y = self.movement.y
end

function Character:render()
    self.sprite:render()
    self.health:render()
end