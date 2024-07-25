Board = Class{__includes = BaseState}

function Board:init(width, height)
    self.reset_width = width
    self.reset_height = height
    self.reset_x_offset = 10
    self.reset_y_offset = 10
    self.reset_selected = false

    self:reset()
end

function Board:update(dt)
    self:checkKeyStuf()
end

function Board:checkKeyStuf(dt)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        self.selected = not self.selected
    end
    if self.selected then
        if love.keyboard.wasPressed("up") then
            self:swap(0,-1)
        elseif love.keyboard.wasPressed("down") then
            self:swap(0,1)
        elseif love.keyboard.wasPressed("left") then
            self:swap(-1,0)
        elseif love.keyboard.wasPressed("right") then
            self:swap(1,0)
        end
    else
        if love.keyboard.wasPressed("up") then
            self.current_tile_position_y = self.current_tile_position_y-1
        elseif love.keyboard.wasPressed("down") then
            self.current_tile_position_y = self.current_tile_position_y+1
        elseif love.keyboard.wasPressed("left") then
            self.current_tile_position_x = self.current_tile_position_x-1
        elseif love.keyboard.wasPressed("right") then
            self.current_tile_position_x = self.current_tile_position_x+1
        end
    end
end

function Board:swap(x, y)
    local current_tile = self.tiles[self.current_tile_position_y][self.current_tile_position_x]
    local new_y = self.current_tile_position_y+y
    if new_y < 1 then
        new_y = 1
    end
    if self.height-1 < new_y then
        new_y = self.height-1
    end
    local new_x = self.current_tile_position_x+x
    if new_x < 1 then
        new_x = 1
    end
    if self.width-1 < new_x then
        new_x = self.width-1
    end
    local change_tile = self.tiles[new_y][new_x]
    if self:CheckSwap(new_x, new_y, current_tile.sprite) then
        current_tile.sprite, change_tile.sprite = change_tile.sprite, current_tile.sprite
    end
    self.selected = false
end

function Board:CheckSwap(new_x, new_y, new_color)
    return (((self:check(new_color,new_x, new_y, 1, 0)) and self:check(new_color,new_x, new_y, 2, 0))
    or ((self:check(new_color,new_x, new_y, -1, 0)) and self:check(new_color,new_x, new_y, 1, 0))
    or ((self:check(new_color,new_x, new_y, 0, -1)) and self:check(new_color,new_x, new_y, 0, 1))
    or ((self:check(new_color,new_x, new_y, -1, 0)) and self:check(new_color,new_x, new_y, -2, 0))
    or ((self:check(new_color,new_x, new_y, 0, 1)) and self:check(new_color,new_x, new_y, 0, 2))
    or ((self:check(new_color,new_x, new_y, 0, -1)) and self:check(new_color,new_x, new_y, 0, -2)))
end

function Board:check(new_color, new_x, new_y, x, y)
    local change_x = new_x+x
    if change_x < 1 then
        change_x = 1
    end
    if self.width-1 < change_x then
        change_x = self.width-1
    end
    local change_y = new_y+y
    if change_y < 1 then
        change_y = 1
    end
    if self.height-1 < change_y then
        change_y = self.height-1
    end
    -- return true
    return self:tileColor(change_x, change_y) == new_color
    -- return self.tiles[change_y][change_x].sprite == new_color

end

function Board:tileColor(x,y)
    return self.tiles[y][x].sprite
end

function Board:render()
    for y=1, self.height do
        for x=1, self.width do
            local tile = self.tiles[y][x]
            self.tile_sprites:render(tile.sprite, tile.x, tile.y)
            if self.current_tile_position_x == tile.x_grid and self.current_tile_position_y == tile.y_grid then
                if self.selected then
                     love.graphics.setColor(colors.selector_selected)
                else
                    love.graphics.setColor(colors.selector)
                end
                love.graphics.rectangle("fill", tile.x, tile.y, self.tile_sprites:getWidth(),self.tile_sprites:getHeight())
                resetColor()
            end
        end
    end
end

function Board:reset()
    self.height = self.reset_height
    self.width = self.reset_width
    self.x_offset = self.reset_x_offset
    self.y_offset = self.reset_y_offset
    self.tile_sprites = Sprites(img.tiles, 0, 0, 12, 9)
    self.selected = self.reset_selected

    self.current_tile_position_x = math.floor(self.width/2)
    self.current_tile_position_y = math.floor(self.height/2)

    self.tiles = self:generate_tiles()
end

function Board:generate_tiles()
    local tiles = {}

    for y=1, self.height do
        table.insert(tiles, {})
        for x=1, self.width do
            table.insert(tiles[y],   {
                x = (x - 1) * 32 + self.x_offset,
                y = (y - 1) * 32 + self.y_offset,
                x_grid = x,
                y_grid = y,
                
                -- sprite = math.random(self.tile_sprites.quad_count)
                sprite = math.random(5)
            })
        end
    end

    return tiles
end