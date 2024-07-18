Ball = Class{}

function Ball:init(skin)
    self.reset_x = virtual_window_width / 2 - 2
    self.reset_y = virtual_window_height / 2 - 2

    self.x = self.reset_x
    self.y = self.reset_y

    self.width = 8
    self.height = 8
    
    self.dy = 0
    self.dx = 0

    self.skin = skin or math.random(7)
end

function Ball:reset()
    self.x = self.reset_x
    self.y = self.reset_y

    self.dy = 0
    self.dx = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
    end

    if self.x >= virtual_window_width - 8 then
        self.x = virtual_window_width - 8
        self.dx = -self.dx
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
    end
end

function Ball:render()
    love.graphics.draw(img['breakout'], frames['balls'][self.skin], self.x, self.y)
end

function Ball:collides(target)
    if self.x > target.x + target.width or self.x + self.width < target.x then
        return false
    end

    if self.y > target.y + target.height or self.y + self.height < target.y then
        return false
    end

    return true
end