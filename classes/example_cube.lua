ExampleCube = Class{__includes = BaseState}

require 'classes.Movement'

function ExampleCube:init()
    self.moving = Movement()
end

function ExampleCube:update(dt)
    self.moving:update(dt)
    
end

function ExampleCube:render()
    globx = self.moving.x
    globy = self.moving.y
    self.moving:render()
end
