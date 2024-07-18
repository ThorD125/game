-- function love.draw()
--     love.graphics.print("Hello World", 400, 300)
-- end

font = {
    ['Sm'] = love.graphics.newFont("assets/font/pokemon.ttf", 8),
    ['l'] = love.graphics.newFont("assets/font/pokemon.ttf", 8),
    ['Xl'] = love.graphics.newFont("assets/font/pokemon.ttf", 16),
    ['XXl'] = love.graphics.newFont("assets/font/pokemon.ttf", 32)
}

sound = {
    ['collision']=love.audio.newSource('assets/sound/collision.wav', 'stream'),
    ['laser']=love.audio.newSource('assets/sound/laser.wav', 'stream'),
    ['bg']=love.audio.newSource('assets/sound/backgroound.mp3', 'stream'),
}

sound['bg']:setLooping(true)
sound['bg']:play()
sound['bg']:setVolume(0.2)

require 'utils.utils'
require 'utils.colors'

-- 01
-- require 'pong'
-- 02
-- require 'flappy'
-- 03
require 'breakout'
-- 04
-- require 'match'
-- 05
-- require 'mario'
-- 06
-- require 'zelda'
-- 07
-- require 'angry'
-- 08
-- require 'pokemon'
-- 09
-- require 'unity'
-- 10
-- require 'dreadhall'
-- 11
-- require 'portal'
-- 12
-- require 'valve'

-- require 'rpg'
-- require 'template'

function love.resize(w, h)
    push:resize(w, h)
end

-- function love.gamepadpressed(joystick, button)
--     text = button
-- end

-- function love.gamepadaxis(joystick, axis, value)
--     text = axis
-- end