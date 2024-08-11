Board = Class { __includes = BaseState }

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

    for y = 1, self.height do
        -- for x = 1, self.width do
        x = 5
        self.tiles[y][x].id = 1
    end

    local y = 2
    for x = 1, self.width, 5 do
        self.tiles[y][x] = Board:generate_opstackle(self.tiles[y][x])
    end
    for x = 1, self.width, 7 do
        for y = 5, self.height do
            self.tiles[y][x] = Board:generate_gap(self.tiles[y][x])
            self.tiles[y][x] = Board:generate_gap(self.tiles[y][x + 1])
        end
    end
end

function Board:pointToTile(x, y)
    return self.tiles[math.floor(y / self.blocks.height) + 1][math.floor(x / self.blocks.width) + 1]
end

function Board:generate_gap(tile)
    tile.id = 0
    return tile
end

function Board:generate_opstackle(tile)
    x = math.random(1, 4)

    if x == 1 then
        tile.id = 2
    else
        tile.id = 0
    end


    return tile
end

function Board:update(dt)
end

function Board:render()
    love.graphics.translate(-math.floor(camera_scroll), 0)

    for y = 1, self.height do
        for x = 1, self.width do
            local current_tile = self.tiles[y][x]
            if not (current_tile.id == 0) then
                self.blocks:render(current_tile.id, (x - 1) * self.blocks.width, (y - 1) * self.blocks.height)
            end
        end
    end
end
