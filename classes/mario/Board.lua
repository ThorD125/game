Board = Class{__includes = BaseState}

function Board:init(width, height)
    self.width = width
    self.height = height
    self:reset()
end

function Board:reset()
    camera_scroll = 0

    self.blocks = Sprites(img_main.blocks, 0, 0, 4, 6)

    self.tiles = {}
    for y = 1, self.height do
        table.insert(self.tiles, {})
        for x = 1, self.width do
            table.insert(self.tiles[y], {
                id = y > 5 and 1 or 0
            })
        end
    end
end

function Board:update(dt)
end

function Board:render()
    love.graphics.translate(-math.floor(camera_scroll), 0)

    for y = 1, self.height do
        for x = 1, self.width do
            local current_tile = self.tiles[y][x]
            if current_tile.id == 1 then
                self.blocks:render(current_tile.id, (x-1)*self.blocks.width, (y-1)*self.blocks.height)
            end
        end
    end
end
