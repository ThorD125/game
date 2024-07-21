Menu = Class{__includes = BaseState}

function Menu:init(title, options, height)
    self.reset_title = title
    self.reset_options = options
    self.reset_current = 1
    self.reset_height = height or 30

    self.offset = virtual_window_height - ((#options+1) * self.reset_height) 

    self:reset()
end

function Menu:reset()
    self.title = self.reset_title
    self.options = self.reset_options
    self.current = self.reset_current
    self.height = self.reset_height
end

function Menu:render()
    renderHugeText(self.title,size[4],0, 20)

    if not (self.options == nil) then
        local count = 0

        for i, option in pairs(self.options) do
            if count+1 == self.current then
                love.graphics.setColor(colors.blue)
            end
            renderHugeText(option[1], size[3], 0, self.offset + (self.height*count))
            resetColor()
            count = count + 1
        end
    end
end

function Menu:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('return') then
        if not (self.options == nil) then    
            state_machine:change(self.options[self.current][2])
        end
    end
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        if self.current < #self.options then
            self.current = self.current + 1
        else
            self.current = 1
        end
    end
end