
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:reset()
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
    
    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
        self.ball.y = self.paddle.y - 8

        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
        
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
        end
    end

    if self.ball.y >= virtual_window_height then
        -- lose one 
    end


    self.paddle:update(dt)
    self.ball:update(dt)
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    if self.paused then
       renderHugeText('Paused: '.. tostring(self.paused))
    end
end


function PlayState:reset()
    self.paddle = Paddle()
    self.ball = Ball()

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    self.paused = false
end
