Bird = Class{}


function Bird:init(x, y, keyUp) --y is gap height location
    self.x = x
    self.y = y
    self.keyUp = keyUp
end

function Bird:update(dt)
    self.y = self.y + GRAVITY * dt
    if love.keyboard.isDown(self.keyUp) then
        self.y = self.y - GRAVITY * dt *2
    end
end

function Bird:render()
    love.graphics.draw(imgBird, self.x, self.y)
end
