
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.paused = false
end

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
    
    


    self.paddle:update(dt)
end

function PlayState:render()
    self.paddle:render()

    if self.paused then
       renderHugeText('Paused: '.. tostring(self.paused))
    end
end


function PlayState:reset()
end
