StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:render()
    love.graphics.setColor(colors.white)
    renderHugeText('Breakout', 0, 50)

    if highlighted == 1 then
        love.graphics.setColor(colors.blue)
    end
    renderHugeText('START', 0, 150)
    resetColor()
    
    if highlighted == 2 then
        love.graphics.setColor(colors.blue)
    end
    renderHugeText('HIGHSCORE', 0, 175)
    resetColor()
end

function StartState:update(dt)    
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
    end

    if love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            state_machine:change('play')
        elseif highlighted == 2 then
            state_machine:change('highscore')
        end
    end
end