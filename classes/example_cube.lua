ExampleCube = Class{__includes = BaseState}

require 'utils.example_movement'

function ExampleCube:init()
    self.moving = Movement()
end

function ExampleCube:update(dt)
    self.moving:update(dt)
end

function ExampleCube:render()
    self.moving:render()
end
