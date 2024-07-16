Bird = Class{}


function Bird:init(x, y, keyUp) --y is gap height location
    self.x = x
    self.y = y
    self.width = imgBird:getWidth()
    self.height = imgBird:getHeight()
    self.keyUp = keyUp
end

function Bird:update(dt)
    self.y = self.y + GRAVITY * dt
end

function Bird:jump()
    self.y = self.y - GRAVITY
end

function Bird:collides(pipe)
    birdTop = self.y
    birdBottom = self.y + self.height

    gapTop = pipe.y
    gapBottom = pipe.y + pipe.gapHeight

    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + pipe.width then


    end

    return false
end

function Bird:render()
    love.graphics.draw(imgBird, self.x, self.y)
end
