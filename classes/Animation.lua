Animation = Class {}

function Animation:init(frames, interval)
    self.frames = frames
    self.interval = interval or 0.3
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
        end
    end
end

function Animation:current_move()
    return self.frames[self.currentFrame]
end
