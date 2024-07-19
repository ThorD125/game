GameState = Class{__includes = BaseState}

function GameState:init()
    self.player1 = Paddle(10, virtual_window_height / 2 - 10, 5, 20, 'w', 's')
    self.player2 = Paddle(virtual_window_width - 10, virtual_window_height / 2 - 10, 5, 20, 'up', 'down')
    self.server = 1
    self.ball = Ball(virtual_window_width / 2, virtual_window_height / 2, 5, 5)
    self.score = Scoreboard(2, virtual_window_width / 2 - 50, virtual_window_height / 3, 50)
end

function GameState:update(dt)
    
    self.player1:update(dt)
    self.player2:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.player1) then
        self.ball.dx = -self.ball.dx * 1.03
        self.ball.x = self.player1.x + 5

        if self.ball.dy < 0 then
            self.ball.dy = -math.random(10, 150)
        else
            self.ball.dy = math.random(10, 150)
        end
    end

    if self.ball:collides(self.player2) then
        self.ball.dx = -self.ball.dx * 1.03
        self.ball.x = self.player2.x - 4

        if self.ball.dy < 0 then
            self.ball.dy = -math.random(10, 150)
        else
            self.ball.dy = math.random(10, 150)
        end
    end

    if self.ball.x < 0 then
        self.score:addCount(2)
        self.ball:reset()
        self.server = 2
            state_machine:change("gameover")
    elseif self.ball.x > virtual_window_width then
        self.score:addCount(1)
        self.ball:reset()
        self.server = 1
            state_machine:change("gameover")
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then    
        state_machine:change("menu")
        self.score:reset()
        self.ball:reset()
    end
end

function GameState:render()
    self.player1:render()
    self.player2:render()
    self.ball:render()
    self.score:render()
end

function GameState:reset()
    self.player1:reset()
    self.player2:reset()
    self.ball:reset()
end