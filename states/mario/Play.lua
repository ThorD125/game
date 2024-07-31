
PlayState = Class{__includes = BaseState}

function PlayState:init()
    self:reset()
end

DEBUG = true

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
        elseif love.keyboard.wasPressed('escape') then
            love.event.quit()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        return
    end 

    map:update(dt)

    -- mario:update(dt)

end

function PlayState:render()

    map:render()

    if self.paused then
    --    renderHugeText('Paused: '.. tostring(self.paused))
       renderHugeText('Paused', size[4])
    end
end

function PlayState:reset()
    self.paused = false
    
    local positions = {
        ["up"] = { 
            ["still"] = 9,
            ["left"] = 5,
            ["right"] = 1,
        },
        ["down"] = {
            ["still"] = 10,
            ["left"] = 6,
            ["right"] = 2,
        },
        ["left"] = {
            ["still"] = 12,
            ["right"] = 8,
            ["left"] = 4,
        },
        ["right"] = {
            ["still"] = 11,
            ["left"] = 7,
            ["right"] = 3,
        }
    }

    map = Board(100, 15)

    -- mario = Character('assets/images/Drayden.png', 3, 4, nil, nil, "l", "m", 100, positions)
    -- mario = Character('assets/images/Drayden.png',3, 4, "j", "k", "l", "m", 100, positions)
    -- mario = Character('assets/images/Drayden.png',3, 4, nil, nil, "left", "right", 100)
    
end
