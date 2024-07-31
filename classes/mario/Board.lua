Board = Class{__includes = BaseState}

function Board:init(width, height)
    self.reset_width = width
    self.reset_height = height
    self:reset()
end

function Board:reset()
    self.camera_scroll = 100

    self.blocks = Sprites(img_main.blocks, 0, 0, 4, 6)

    self.tiles = {}
    for y = 1, self.reset_height do
        table.insert(self.tiles, {})
        for x = 1, self.reset_width do
            table.insert(self.tiles[y], {
                id = y > 5 and 1 or 0
            })
        end
    end
end

function Board:update(dt)
    if love.keyboard.isDown("l") then
        self.camera_scroll = self.camera_scroll - camera_speed * dt
    elseif love.keyboard.isDown("m") then
        self.camera_scroll = self.camera_scroll + camera_speed * dt
    end
end

function Board:render()
    love.graphics.translate(-math.floor(self.camera_scroll), 0)

    for y = 1, self.reset_height do
        for x = 1, self.reset_width do
            local current_tile = self.tiles[y][x]
            if current_tile.id == 1 then
                self.blocks:render(current_tile.id, (x-1)*self.blocks:getWidth(), (y-1)*self.blocks:getHeight())
            end
        end
    end
end
