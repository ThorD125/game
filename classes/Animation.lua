Sprite_Animations = Class {}

function Sprite_Animations:init(frames, interval)
    self.frames = frames
    self.interval = interval
    self.timer = 0
    self.currentFrame = 1
end

function Sprite_Animations:update(dt)
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
        end
    end
end

function Sprite_Animations:current_move()
    return self.frames[self.currentFrame]
end
