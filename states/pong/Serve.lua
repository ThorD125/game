ServeState = Class{__includes = BaseState}

function ServeState:update(dt)
    if server == 1 then
        game.ball.dx = 100
    else
        game.ball.dx = -100
    end

    state_machine:change("game")
end