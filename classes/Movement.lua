Movement = Class{__includes = BaseState}

function Movement:init(x, y, width, height, up, down, left, right, speed, diagonal_allowed)
    self.reset_x = x
    self.reset_y = y
    self.reset_width = width
    self.reset_height = height

    self.reset_up = up
    self.reset_down = down
    self.reset_left = left
    self.reset_right = right

    self.reset_speed = speed

    self.reset_diagonal_allowed = diagonal_allowed or false

    self:reset()

    joystick_left = love.joystick.getJoysticks()[1]
end

function Movement:update(dt)
    if joystick_left then
        local axisX = joystick_left:getAxis(1)
        local axisY = joystick_left:getAxis(2)
        self.x = self.x + axisX * self.speed * dt
        self.y = self.y + axisY * self.speed * dt
    else
        if self.diagonal_allowed then
            if self.key.up and love.keyboard.isDown(self.key.up) and not love.keyboard.isDown(self.key.down) then
                self.y = self.y - self.speed * dt
            elseif self.key.down and love.keyboard.isDown(self.key.down) and not love.keyboard.isDown(self.key.up) then
                self.y = self.y + self.speed * dt
            end
            if self.key.left and love.keyboard.isDown(self.key.left) and not love.keyboard.isDown(self.key.right) then
                self.x = self.x - self.speed * dt
            elseif self.key.right and love.keyboard.isDown(self.key.right) and not love.keyboard.isDown(self.key.left) then
                self.x = self.x + self.speed * dt
            end
        else 
            if self.key.up and love.keyboard.isDown(self.key.up) and not love.keyboard.isDown(self.key.down) then
                self.y = self.y - self.speed * dt
            elseif self.key.down and love.keyboard.isDown(self.key.down) and not love.keyboard.isDown(self.key.up) then
                self.y = self.y + self.speed * dt
            elseif self.key.left and love.keyboard.isDown(self.key.left) and not love.keyboard.isDown(self.key.right) then
                self.x = self.x - self.speed * dt
            elseif self.key.right and love.keyboard.isDown(self.key.right) and not love.keyboard.isDown(self.key.left) then
                self.x = self.x + self.speed * dt
            end
        end
    end

    if virtual_window_width < self.x then
        self.x = self.x - virtual_window_width
    elseif self.x < 0 then
        self.x = self.x + virtual_window_width
    end

    
    if virtual_window_height < self.y then
        self.y = self.y - virtual_window_height
    elseif self.y < 0 then
        self.y = self.y + virtual_window_height
    end
end


function Movement:reset()
    self.x = self.reset_x -- or 100
    self.y = self.reset_y -- or 100
    self.width = self.reset_width -- or 100
    self.height = self.reset_height -- or 100

    self.key = {
        ['up'] = self.reset_up, -- or 'w',
        ['down'] = self.reset_down, -- or 's',
        ['left'] = self.reset_left, -- or 'a',
        ['right'] = self.reset_right, -- or 'd',
    }

    self.speed = self.reset_speed -- or 100

    self.diagonal_allowed = self.reset_diagonal_allowed
end


function Movement:render()
    love.graphics.setColor(colors.red)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    if virtual_window_width - self.width < self.x then
        love.graphics.rectangle('fill', self.x - virtual_window_width, self.y, self.width, self.height)
    end
end

