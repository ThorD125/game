
GameState = Class{__includes = BaseState}

function GameState:init()
    GameState:reset()

    self.movingObject = ExampleCube()
end

function GameState:update(dt)
    self.movingObject:update(dt)
end

function GameState:render()
    self.movingObject:render()
end


function GameState:reset()
    GameState.score = Scoreboard(1, 10, 10)
end
