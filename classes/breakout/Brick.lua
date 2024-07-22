Brick = Class{__includes = BaseState}

function Brick:init(x, y)
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    self.tier = math.random(0,3)
    self.color = math.random(0,3)
    if DEBUG then
        self.tier = 1
        self.color = 1
    end

    self.inPlay = true
    
    -- self.psystem = love.graphics.newParticleSystem(img.particle, 64)
    -- self.psystem:setParticleLifetime ( 10,10 )
    -- self.psystem:setSizeVariation ( 1 )
    -- self.psystem:setSpeed ( 20, 20 )
    -- self.psystem:setColors ( 1, 1, 1, 1, 1, 1, 1, 0 )
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
    -- self.psystem:setColors(255,0,255,255,100,0,100,0)
    -- self.psystem:emit(64)

    score = score + 1
    if self.tier > 0 then
        self.tier = self.tier - 1
    else
        self.inPlay = false
    end
end