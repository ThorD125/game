WinState = Class{__includes = BaseState}

function WinState:init()
    WinState:reset()
end

function WinState:render()
    love.graphics.setFont(font.XXl)
    love.graphics.setColor(0, 255, 0, 255)
    
    
    if 1 == score:checkWinner() then
        love.graphics.print(tostring("player1"), virtual_window_width/2, virtual_window_height/2)
    else 
        love.graphics.print(tostring("player2"), virtual_window_width/2, virtual_window_height/2)
    end
    
    resetColor()
end