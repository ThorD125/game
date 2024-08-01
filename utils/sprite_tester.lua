function love.load()
    love.window.setTitle('Sprite Drayden')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.time())
    
    test_img = love.graphics.newImage('assets/images/Drayden.png')
    -- test_img = love.graphics.newImage('assets/images/Cynthia.png')
    testSprite = Sprites(test_img, 0, 0, 3, 4)
    
    virtual_window_width = testSprite.img:getWidth()
    virtual_window_height = testSprite.img:getHeight()

    pixels_square = 700

    scale_x = pixels_square / virtual_window_width
    scale_y = pixels_square / virtual_window_height
    if scale_x < scale_y then
        scaler = scale_x
    else
        scaler = scale_y
    end


    -- if scaler < 1 then
    --     scaler = virtual_window_width / pixels_square
    -- end

    window_width = virtual_window_width * scaler
    window_height = virtual_window_height * scaler
    push:setupScreen(virtual_window_width, virtual_window_height, window_width, window_height, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    debug = true
end

function love.update(dt)
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end



function love.draw()
    push:start()
    love.graphics.setColor(255,0,255, 0.5)
    love.graphics.rectangle('fill', 0, 0, virtual_window_width, virtual_window_height)
    love.graphics.rectangle('fill', 0, 0, testSprite.width_quads, testSprite.height_quads)
    if debug then
        for x=0, virtual_window_width, testSprite.width_quads do
            love.graphics.line(x, 0, x, virtual_window_height)
        end
        for y=0, virtual_window_height, testSprite.height_quads do
            love.graphics.line(0, y, virtual_window_width, y)
        end
        resetColor()
        love.graphics.setColor(255,255,255, 0.8)
        love.graphics.draw(testSprite.img, 0, 0)
    end
    resetColor()
    
    resetColor()
    testSprite:render(0)
    -- testSprite:render(2)

    push:finish()
end

