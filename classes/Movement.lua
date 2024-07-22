Movement = Class{__includes = BaseState}

function Movement:init(x, y, width, height, up, down, left, right, speed)
    self.reset_x = x
    self.reset_y = y
    self.reset_width = width
    self.reset_height = height

    self.reset_down = down
    self.reset_up = up
    self.reset_left = left
    self.reset_right = right

    self.reset_speed = speed

    Movement:reset()

    joystick_left = love.joystick.getJoysticks()[1]
end

function Movement:update(dt)
    if joystick_left then
        local axisX = joystick_left:getAxis(1)
        local axisY = joystick_left:getAxis(2)
        self.x = self.x + axisX * self.speed * dt
        self.y = self.y + axisY * self.speed * dt
    else
        if love.keyboard.isDown(self.key.up) and not love.keyboard.isDown(self.key.down) then
            self.y = self.y - self.speed * dt
        elseif love.keyboard.isDown(self.key.down) and not love.keyboard.isDown(self.key.up) then
            self.y = self.y + self.speed * dt
        end
        if love.keyboard.isDown(self.key.left) and not love.keyboard.isDown(self.key.right) then
            self.x = self.x - self.speed * dt
        elseif love.keyboard.isDown(self.key.right) and not love.keyboard.isDown(self.key.left) then
            self.x = self.x + self.speed * dt
        end
    end
end

function Movement:reset()
    self.x = self.reset_x or 100
    self.y = self.reset_y or 100
    self.width = self.reset_width or 100
    self.height = self.reset_height or 100

    self.key = {
        ['up'] = self.reset_up or 'w',
        ['down'] = self.reset_down or 's',
        ['left'] = self.reset_left or 'a',
        ['right'] = self.reset_right or 'd',
    }

    self.speed = self.reset_speed or 100
end


function Movement:render()
    love.graphics.setColor(colors.red)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

