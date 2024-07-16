Scoreboard = Class{}



function Scoreboard:init(amountOfPeople, x, y, width)
    self.amountOfPeople = amountOfPeople
    self.scores = {}
    self.x = x
    self.y = y
    self.width = width

    self:reset()
end

function Scoreboard:render(dt)
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(fontXXl)

    for i, score in ipairs(self.scores) do
        love.graphics.print(tostring(score), self.x + (i-1)*self.width, self.y )
    end
end

function Scoreboard:addCount(player)
    self.scores[player] = self.scores[player] + 1
end

function Scoreboard:reset()
    for i = 1, self.amountOfPeople do
        self.scores[i] = 0
    end
end