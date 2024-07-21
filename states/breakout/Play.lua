
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:reset()

    self.score = 0
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
        if high_score_state:append(self.score) then
            state_machine:change('highscore')
        else
            state_machine:change('gameover')
        end
    end


    self.paddle:update(dt)
    self.ball:update(dt)

    local bricksCount = 0

    for k, brick in pairs(self.bricks) do
        brick:update(dt)

        if brick.inPlay then
            bricksCount = bricksCount + 1
            if self.ball:collides(brick) then
                brick:hit()

                if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x - 8
                elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x + 32
                elseif self.ball.y < brick.y then
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y - 8
                else
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + 16
                end
            end
        end
    end

    if bricksCount == 0 then
        self:reset()
    end

end

function PlayState:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
        
    end
    love.graphics.print('Score: ' .. score, 10, 30)

    self.paddle:render()
    self.ball:render()

    if self.paused then
    --    renderHugeText('Paused: '.. tostring(self.paused))
       renderHugeText('Paused', size[4])
    end
end


function PlayState:reset()
    self.paddle = Paddle()
    self.ball = Ball()

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    if DEBUG then
        self.ball.dx = 1
        self.ball.dy = 200
    end

    self.paused = false

    self.bricks = LevelMaker.createMap()
end
