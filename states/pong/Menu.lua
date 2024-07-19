MenuState = Class{__includes = BaseState}

function MenuState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        state_machine:change("serve")    
    end
end

function MenuState:render()
    love.graphics.setFont(font[size[3]])
    love.graphics.printf('Pong', 0, 64, virtual_window_width, 'center')
    love.graphics.setFont(font[size[2]])
    love.graphics.printf('Press Enter to Play', 0, 100, virtual_window_width, 'center')
end