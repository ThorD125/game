ServeState = Class{__includes = BaseState}

function ServeState:update(dt)
    if server == 1 then
        ball.dx = 100
    else
        ball.dx = -100
    end

    state_machine:change("game")
end