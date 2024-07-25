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
            self.current_tile_position_y = self:ClampY(self.current_tile_position_y-1)
        elseif love.keyboard.wasPressed("down") then
            self.current_tile_position_y = self:ClampY(self.current_tile_position_y+1)
        elseif love.keyboard.wasPressed("left") then
            self.current_tile_position_x = self:ClampX(self.current_tile_position_x-1)
        elseif love.keyboard.wasPressed("right") then
            self.current_tile_position_x = self:ClampX(self.current_tile_position_x+1)
        end
    end
end

function Board:swap(x, y)
    local current_tile = self.tiles[self.current_tile_position_y][self.current_tile_position_x]
    
    local new_y = self.current_tile_position_y+y
    new_y = self:ClampY(new_y)
    local new_x = self.current_tile_position_x+x
    new_x = self:ClampX(new_x)

    local change_tile = self.tiles[new_y][new_x]

    local direction = ""
    if x == 1 then
        direction = "right"
    elseif x == -1 then
        direction = "left"
    elseif y == 1 then
        direction = "down"
    elseif y == -1 then
        direction = "up"
    end

    coords = self:CheckAll(new_x, new_y, current_tile.sprite, direction)
    if coords then
        current_tile.sprite, change_tile.sprite = change_tile.sprite, nil

        for i, coord in ipairs(coords) do
            local x = coord[1]
            if x < 1 then
                return 
            end
            if self.width < x then
                return 
            end
            local y = coord[2]
            if y < 1 then
                return 
            end
            if self.height < y then
                return 
            end
            self.tiles[y][x].sprite = nil
        end
    end
    self.selected = false
end

function Board:ClampX(x)
    if x < 1 then
        x = 1
    end
    if self.width < x then
        x = self.width
    end
    return x
end

function Board:ClampY(y)
    if y < 1 then
        y = 1
    end
    if self.height < y then
        y = self.height
    end
    return y
end

function Board:Clamping(x, y)
    x = self:ClampX(x)
    y = self:ClampY(y)
    return x, y
end

function Board:CheckAll(new_x, new_y, new_color, direction)
    -- return ((self:CheckIndividual(new_color,new_x, new_y, 1, 0)) and self:CheckIndividual(new_color,new_x, new_y, 2, 0) and not(direction == "left"))
    -- or ((self:CheckIndividual(new_color,new_x, new_y, -1, 0)) and self:CheckIndividual(new_color,new_x, new_y, 1, 0) and not(direction == "right"))
    -- or ((self:CheckIndividual(new_color,new_x, new_y, -1, 0)) and self:CheckIndividual(new_color,new_x, new_y, -2, 0) and not(direction == "left" or direction == "right"))
    -- or ((self:CheckIndividual(new_color,new_x, new_y, 0, 1)) and self:CheckIndividual(new_color,new_x, new_y, 0, 2) and not(direction == "up"))
    -- or ((self:CheckIndividual(new_color,new_x, new_y, 0, -1)) and self:CheckIndividual(new_color,new_x, new_y, 0, -2) and not(direction == "down" ))
    -- or ((self:CheckIndividual(new_color,new_x, new_y, 0, -1)) and self:CheckIndividual(new_color,new_x, new_y, 0, 1) and not(direction == "up" or direction == "down"))

    if ((self:CheckIndividual(new_color,new_x, new_y, -1, 0)) and self:CheckIndividual(new_color,new_x, new_y, 1, 0) and not(direction == "left" or direction == "right")) then
        return {{new_x - 1, new_y + 0}, {new_x + 1, new_y + 0}}
    end
    if ((self:CheckIndividual(new_color,new_x, new_y, 0, -1)) and self:CheckIndividual(new_color,new_x, new_y, 0, 1) and not(direction == "up" or direction == "down")) then
        return {{new_x + 0, new_y - 1}, {new_x + 0, new_y + 1}}
    end

    if ((self:CheckIndividual(new_color,new_x, new_y, 1, 0)) and self:CheckIndividual(new_color,new_x, new_y, 2, 0) and not(direction == "left")) then
        return {{new_x + 1, new_y + 0}, {new_x + 2, new_y + 0}}
    end
    if ((self:CheckIndividual(new_color,new_x, new_y, -1, 0)) and self:CheckIndividual(new_color,new_x, new_y, -2, 0) and not(direction == "right")) then
        return {{new_x - 1, new_y + 0}, {new_x - 2, new_y + 0}}
    end
    if ((self:CheckIndividual(new_color,new_x, new_y, 0, 1)) and self:CheckIndividual(new_color,new_x, new_y, 0, 2) and not(direction == "up")) then
        return {{new_x + 0, new_y + 1}, {new_x + 0, new_y + 2}}
    end
    if ((self:CheckIndividual(new_color,new_x, new_y, 0, -1)) and self:CheckIndividual(new_color,new_x, new_y, 0, -2) and not(direction == "down" )) then
        return {{new_x + 0, new_y - 1}, {new_x + 0, new_y - 2}}
    end
end

function Board:CheckIndividual(new_color, new_x, new_y, x, y)
    local x = new_x+x
    if x < 1 then
        return false
    end
    if self.width < x then
        return false
    end
    local y = new_y+y
    if y < 1 then
        return false
    end
    if self.height < y then
        return false
    end
    return self:tileColor(x, y) == new_color
    -- return true
    -- return self.tiles[change_y][change_x].sprite == new_color

end

function Board:tileColor(x,y)
    return self.tiles[y][x].sprite
end

function Board:render()
    for y=1, self.height do
        for x=1, self.width do
            local tile = self.tiles[y][x]
            if tile.sprite then
                self.tile_sprites:render(tile.sprite, tile.x, tile.y)
            end
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
                sprite = math.random(2)
            })
        end
    end

    return tiles
end