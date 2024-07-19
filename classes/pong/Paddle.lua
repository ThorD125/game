Paddle = Class{}

function Paddle:init(x, y, width, height, keyUp, keyDown)
    self.resetX = x
    self.resetY = y
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.keyDown = keyDown
    self.keyUp = keyUp
end

function Paddle:reset()
    self.x = self.resetX
    self.y = self.resetY
end

function Paddle:update(dt)
    if love.keyboard.wasPressed(self.keyUp) and love.keyboard.wasPressed(self.keyDown) then
        -- self.y = self.y
    elseif love.keyboard.wasPressed(self.keyUp) then
        self.y = math.max(0, self.y - (paddle_speed * dt))
    elseif love.keyboard.wasPressed(self.keyDown) then
        self.y = math.min(virtual_window_height - 20, self.y + (paddle_speed * dt))
    end
end

function Paddle:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    resetColor()
end