
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

    Timer.update(dt)
end

function PlayState:render()
    if self.paused then
    --    renderHugeText('Paused: '.. tostring(self.paused))
       renderHugeText('Paused', size[4])
    end

    for x=1, #self.counters do
        renderHugeText(self.counters[x], size[2], 100, 10*x)
    end

end


function PlayState:reset()
    self.paused = false

    self.intervals = {1,2,3,4,5}
    self.counters = {0,0,0,0,0}


    for i=1, #self.counters do
        Timer.every(self.intervals[i], function ()
            self.counters[i] = self.counters[i] + 1
        end)
    end
end
