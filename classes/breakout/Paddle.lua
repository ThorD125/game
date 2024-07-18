Paddle = Class{}

function Paddle:init()
    self.reset_x = virtual_window_width / 2 - 32
    self.reset_y = virtual_window_height - 32
    self.x = self.reset_x
    self.y = self.reset_y
    self.width = 64
    self.height = 16

    self.dx = 0

    self.skin = 1

    self.size = 2
end

function Paddle:reset()
    self.x = self.reset_x
    self.y = self.reset_y
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') and love.keyboard.isDown('right') then
        self.dx = 0
    elseif love.keyboard.isDown('left') then
        self.dx = -paddle_speed
    elseif love.keyboard.isDown('right') then
        self.dx = paddle_speed
    else
        self.dx = 0
    end
    
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(virtual_window_width - self.width, self.x + self.dx * dt)
    end

end

function Paddle:render()
    love.graphics.draw(img.breakout, frames.paddles[self.size + 4 * (self.skin - 1)], self.x, self.y)
end
