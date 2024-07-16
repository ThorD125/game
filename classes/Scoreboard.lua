Scoreboard = Class{}



function Scoreboard:init(amountOfPeople, x, y, width, normalFont, scoreFont)
    self.amount = amountOfPeople
    self.scores = {}
    self.x = x
    self.y = y
    self.width = width

    for i = 1, amountOfPeople do
        self.scores[i] = 0
    end
    
    self.normalFont = normalFont
    self.scoreFont = scoreFont

end

function Scoreboard:render(dt)
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(self.scoreFont)

    for i, score in ipairs(self.scores) do
        love.graphics.print(tostring(score), self.x + (i-1)*self.width, self.y )
    end
end

