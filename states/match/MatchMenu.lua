
MatchMenu = Class{__includes = BaseState}

function MatchMenu:init()
    self:reset()
end

function MatchMenu:update(dt)
    menu:update()
    Timer.update(dt)
end

function MatchMenu:render()
    menu:render()
    self:drawMatch3Text(-60)
end


function MatchMenu:reset()
    menu = Menu("",{
        {'START','countdown'},
        {'HIGHSCORE','highscore'},
    })
     
    self.colors = {
        [1] = {217/255, 87/255, 99/255, 1},
        [2] = {95/255, 205/255, 228/255, 1},
        [3] = {251/255, 242/255, 54/255, 1},
        [4] = {118/255, 66/255, 138/255, 1},
        [5] = {153/255, 229/255, 80/255, 1},
        [6] = {223/255, 113/255, 38/255, 1}
    }

    -- letters of MATCH 3 and their spacing relative to the center
    self.letterTable = {
        {'M', -108},
        {'A', -64},
        {'T', -28},
        {'C', 2},
        {'H', 40},
        {'3', 112}
    }
    self.colorTimer = Timer.every(0.075, function()
        
        -- shift every color to the next, looping the last to front
        -- assign it to 0 so the loop below moves it to 1, default start
        self.colors[0] = self.colors[6]

        for i = 6, 1, -1 do
            self.colors[i] = self.colors[i - 1]
        end
    end)

end


function MatchMenu:drawMatch3Text(y)
    
    love.graphics.setColor(1, 1, 1, 128/255)
    love.graphics.rectangle('fill', virtual_window_width / 2 - 76, virtual_window_height / 2 + y - 11, 150, 58, 6)

    for i = 1, 6 do
        love.graphics.setColor(self.colors[i])
        love.graphics.printf(self.letterTable[i][1], 0, virtual_window_height / 2 + y,
            virtual_window_width + self.letterTable[i][2], 'center')
    end
end