MenuState = Class{__includes = BaseState}

function MenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        state_machine:change("serve")    
    end
end