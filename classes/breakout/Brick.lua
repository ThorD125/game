Brick = Class{}

function Brick:init(x, y)
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    self.tier = math.random(1,4)
    self.color = math.random(1,4)
    if DEBUG then
        self.tier = 1
    end

    self.inPlay = true
    
    -- self.psystem = love.graphics.newParticleSystem(img.particle, 64)
    -- self.psystem:setParticleLifetime(0.5, 1)
    -- self.psystem:setLinearAcceleration(-15, 0, 15, 80)
    -- self.psystem:setEmissionArea('normal', 10, 10)
end

function Brick:update(dt)

end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(img.breakout, 
            frames.bricks[1 + ((self.color - 1) * 4) + self.tier],
            self.x, self.y)
    end
end

function Brick:hit()
    if self.tier > 0 then
        self.tier = self.tier - 1
    else
        self.inPlay = false
    end
end