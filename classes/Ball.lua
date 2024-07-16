Ball = Class{}

function Ball:init(x, y, width, height)
    self.resetX = x
    self.resetY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = self.resetX
    self.y = self.resetY
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    
    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
    end

    if self.y >= VIRTUAL_WINDOW_HEIGHT - 5 then
        self.y = VIRTUAL_WINDOW_HEIGHT - 5
        self.dy = -self.dy
    end
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, 5, 5)
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end