
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:reset()
end

DEBUG = true

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
        elseif love.keyboard.wasPressed('escape') then
            love.event.quit()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        return
    end

    -- Timer.update(dt)
    
    -- if timer < duration then
    --     timer = timer + dt
    --     flappyX = math.min(flappy_max, flappy_max * (timer / duration))
    --     for k, bird in pairs(birds) do
            
    --         -- math.min ensures we don't go past the end
    --         -- timer / MOVE_DURATION is a ratio that we effectively just multiply our
    --         -- X by each turn to make it seem as if we're moving right
    --         bird.x = math.min(flappy_max, flappy_max * (timer / bird.rate))
    --     end
    -- end
end

function PlayState:render()

    -- -- for x=1, #self.counters do
    -- --     renderHugeText(self.counters[x], size[2], 100, 10*x)
    -- -- end
    -- -- for k, bird in pairs(birds) do
    -- --     love.graphics.draw(flappy, bird.x, bird.y)
    -- -- end
    -- -- renderHugeText(tostring(timer), size[3], 0, 50)

    -- -- love.graphics.draw(flappy.img, flappy.x, flappy.y)
    
    -- board:render()
    if self.paused then
    --    renderHugeText('Paused: '.. tostring(self.paused))
       renderHugeText('Paused', size[4])
    end
end


function PlayState:reset()
    self.paused = false
    
end