StartState = Class{__includes = BaseState}

local highlighted = 1

testHeart = HealthBar_Minecraft(5, 10, 7000, 7000)

function StartState:render()
    love.graphics.setColor(colors.white)
    renderHugeText('Breakout', size[4], 0, 50)

    if highlighted == 1 then
        love.graphics.setColor(colors.blue)
    end
    renderHugeText('START', size[3], 0, 150)
    resetColor()
    
    if highlighted == 2 then
        love.graphics.setColor(colors.blue)
    end
    renderHugeText('HIGHSCORE', size[3], 0, 175)
    resetColor()

    testHeart:render()
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

    if love.keyboard.wasPressed('x') then
        testHeart:loseHeart()
    end
    if love.keyboard.wasPressed('y') then
        testHeart:healHeart()
    end
    -- testHeart:update(dt)
end