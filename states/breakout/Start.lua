StartState = Class{__includes = BaseState}

local highlighted = 1

testHeart = HealthBar_Minecraft(5, 10, 7000, 7000)

function StartState:init()
    menu = Menu("Breakout",
        {
        {'START','play'},
        {'HIGHSCORE','highscore'},
    })
end

function StartState:render()
    menu:render()
    testHeart:render()
end

function StartState:update(dt)
    
    testHeart:update(dt)
    menu:update(dt)
end