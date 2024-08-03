PlayState = Class { __includes = BaseState }

function PlayState:init()
    self:reset()
end

DEBUG = true

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('return') then
            self.paused = false
        elseif love.keyboard.wasPressed('escape') then
            love.event.quit()
        else
            return
        end
    elseif love.keyboard.wasPressed('return') then
        self.paused = true
        return
    end


    if love.keyboard.isDown("k") then
        char.face_current = char.faces.left
        char.x = char.x - char.speed * dt
        char.animation_current = char.animation_movements.walk
        if char.x < 0 then
            char.x = 0
        end
    elseif love.keyboard.isDown("l") then
        char.face_current = char.faces.right
        char.x = char.x + char.speed * dt
        char.animation_current = char.animation_movements.walk

        if (map.width * 16) < char.x + char.sprite.width then
            -- if (map.width * 16) - virtual_window_width < camera_scroll then
            char.x = (map.width * 16) - char.sprite.width
        end
    else
        char.animation_current = char.animation_movements.still
    end
    camera_scroll = char.x - (virtual_window_width / 2) + (char.sprite.width / 2)
    if camera_scroll < 0 then
        camera_scroll = 0
    end

    if (map.width * 16) - virtual_window_width < camera_scroll then
        camera_scroll = (map.width * 16) - virtual_window_width
    end


    map:update(dt)

    char.animation_current:update(dt)
    -- mario:update(dt)
end

function PlayState:render()
    map:render()
    char.sprite:render(char.sprite.positions[char.face_current][char.animation_current:current_move()], char.x, char.y)


    if self.paused then
        --    renderHugeText('Paused: '.. tostring(self.paused))
        renderHugeText('Paused', size[4])
    end

    -- love.graphics.rectangle("fill", width, 0, 16, 16)
end

function PlayState:reset()
    self.paused = false


    map = Board(20, 15)

    local drayden = love.graphics.newImage('assets/images/Drayden.png')
    animation_still = Sprite_Animations({ "still" }, 0.2)
    animation_walk = Sprite_Animations({ "left", "right" }, 0.2)
    char = {
        ["img"] = drayden,
        ["width"] = drayden:getWidth(),
        ["height"] = drayden:getHeight(),
        ["sprite"] = Sprites(drayden, 0, 0, 3, 4),
        ["x"] = 100,
        ["y"] = 30,
        ["speed"] = move_speed,
        ["animation_movements"] = {
            ["still"] = animation_still,
            ["walk"] = animation_walk,
        },
        ["animation_current"] = animation_still,
        ["faces"] = {
            ["up"] = "up",
            ["down"] = "down",
            ["left"] = "left",
            ["right"] = "right",
        },
        ["face_current"] = "down",
        ["moves"] = {
            ["still"] = "still",
            ["left"] = "left",
            ["right"] = "right",
        },
    }

    -- mario = Character('assets/images/Drayden.png', 3, 4, nil, nil, "l", "m", 100, positions)
    -- mario = Character('assets/images/Drayden.png',3, 4, "j", "k", "l", "m", 100, positions)
    -- mario = Character('assets/images/Drayden.png',3, 4, nil, nil, "left", "right", 100)
end
