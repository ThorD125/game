Gameover = Class{__includes = BaseState}

function Gameover:render()
    renderHugeText('Loser: '.. score:getScore(1))
end