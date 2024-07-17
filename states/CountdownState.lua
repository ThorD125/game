CountdownState = Class{__includes = BaseState}

function CountdownState:init(nextstate, x, y, countNumbers, countTime)
    self.nextstate = nextstate
    self.x = x or 0
    self.y = y or 120
    self.count = countNumbers or 3
    self.timer = 0
    self.COUNTDOWN_TIME = countTime or 0.75
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.COUNTDOWN_TIME then
        self.timer = self.timer % self.COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change(self.nextstate)
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), self.x, self.y, VIRTUAL_WIDTH, 'center')
end