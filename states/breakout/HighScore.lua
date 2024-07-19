HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
    HighScoreState:reset()
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed("escape") then
        state_machine:change("start")
    end
end


high_score_table = {}
high_score_amount = 5

score = 0


function HighScoreState:render()
    love.graphics.setColor(255, 0, 0, 255)

    local y = 0
    local height = 20
    local offset = 100

    local not_found_current_score = true
    for i, score in ipairs(high_score_table) do
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


function HighScoreState:reset()
    self.last_score_added = 0

    for i = 1, high_score_amount do
        high_score_table[i] = 0
    end
end

function HighScoreState:append(new_score)
    if score > high_score_table[#high_score_table] then

        table.insert(high_score_table, #high_score_table, new_score)
        table.sort(high_score_table, function(a, b) return a > b end)
        table.slice(high_score_table, 1, #high_score_table -1)

        self.last_score_added = new_score

        return true
    else
        return false
    end
end