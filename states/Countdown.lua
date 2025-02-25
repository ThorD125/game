CountdownState = Class{__includes = BaseState}

function CountdownState:init(x, y, countNumbers, countTime, nextstate)
    self.x = x or 0
    self.y = y or 120
    self.count = countNumbers or 3
    self.timer = 0
    self.COUNTDOWN_TIME = countTime or 0.75
    self.nextstate = nextstate or "play"
end

function CountdownState:enter(params)
    if params then
        self.nextstate = params.nextstate
    else
        self.nextstate = "play"
    end
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.COUNTDOWN_TIME then
        self.timer = self.timer % self.COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            -- state_machine:change(self.nextstate)
            state_machine:change(self.nextstate)
        end
    end
end

function CountdownState:render()
    love.graphics.setColor(colors.black)
    renderHugeText(tostring(self.count), size[4])
end