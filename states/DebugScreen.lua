DebugScreen = Class{__includes = BaseState}

function DebugScreen:init()
    globx = nil
    globy = nil

    self.enabled = true
end

function DebugScreen:update(dt)
    if love.keyboard.wasPressed("f3") then
        self:toggle()
    end
end

function DebugScreen:render()
    if not self.enabled then
        return
    end

    love.graphics.setFont(font[size[1]])
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.print('State: ' .. state_machine:getCurrentState(), 10, 20)

    if not (globx == nil or globy == nil) then
        love.graphics.print('xy: ' .. tostring(globx) .. "," .. tostring(globy), 10, 30)
    end

    resetColor()
end

function DebugScreen:toggle()
    self.enabled = not self.enabled
end
