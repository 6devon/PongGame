--https://github.com/Ulydev/push
push = require ('push')

WINDOW_HEIGHT = 720
WINDOW_LENGTH = 1280

VIRTUAL_WINDOW_HEIGHT = 243
VIRTUAL_WINDOW_LENGTH = 432
-- love.load() initializing game
-- love.update(dt) delta time is a term usually used for variably updating scenery based on the elapsed time since the game last updated
--dt is a fraction of a second

-- love.draw() rendering behaviour

-- love.graphics.printf(text, x, y, [width], [align])
--print func to align text on the screen

--love.window.setMode(width, height, params)
--window setup



function love.load()
    push:setupScreen(VIRTUAL_WINDOW_LENGTH, VIRTUAL_WINDOW_HEIGHT,WINDOW_LENGTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    love.graphics.printf('Pong Game!', 0, WINDOW_HEIGHT/2 - 6, WINDOW_LENGTH, 'center')
end

--love.graphics.setDefaultFilter(min, mag)
--texture scaling filter, sligthly blur look

--love.keypressed(key)
--key interaction with game

--love.event.quit()
--quitting application