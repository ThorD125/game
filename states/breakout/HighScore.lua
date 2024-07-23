HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
    HighScoreState:reset()
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed("escape") then
        state_machine:change("start")
    end
end



function HighScoreState:render()
    love.graphics.setColor(255, 0, 0, 255)

    local y = 0
    local height = 20
    local offset = 100

    local not_found_current_score = true
    for i, score in ipairs(self.high_score_table) do
        if score == self.last_score_added and not_found_current_score then 
            renderHugeText("**" .. tostring(i) .. ": " ..tostring(score) .. "**", size[1], 0, offset + y*height)
            not_found_current_score = false
        elseif score == 0 then
            renderHugeText(tostring(i) .. " --------", size[1], 0, offset + y*height)
        else
            renderHugeText(tostring(i) .. ": " ..tostring(score), size[1], 0, offset + y*height)
        end
        y = y + 1
    end
end


score = 0
function HighScoreState:reset()
    self.last_score_added = 0
    
    love.filesystem.setIdentity("breakout")
    if not love.filesystem.getInfo("breakout" .. '.lst') then
        local scores = ''
        local high_score_amount = 5
        for i=0, high_score_amount, 1 do
            scores = scores .. "0" .. '\n'
        end

        love.filesystem.write("breakout.lst", scores)
    end
        
        
    self.high_score_table = {}
    count = 1
    for line in love.filesystem.lines("breakout.lst") do
        self.high_score_table[count]=tonumber(line)
        count = count + 1
    end
end

function HighScoreState:append(new_score)
    if score > self.high_score_table[#self.high_score_table] then

        table.insert(self.high_score_table, #self.high_score_table, new_score)
        table.sort(self.high_score_table, function(a, b) return a > b end)
        table.slice(self.high_score_table, 1, #self.high_score_table -1)

        local scores = ""
        for i=1, #self.high_score_table do
            scores = scores .. self.high_score_table[i] .. '\n'
        end
        love.filesystem.write("breakout.lst", scores)

        self.last_score_added = new_score

        return true
    else
        return false
    end
end