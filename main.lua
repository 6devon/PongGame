--https://github.com/Ulydev/push
push = require ('push')

WINDOW_HEIGHT = 720
WINDOW_LENGTH = 1280

VIRTUAL_WINDOW_HEIGHT = 243
VIRTUAL_WINDOW_LENGTH = 432
-- love.load() initializing game
-- love.update(dt) delta time is a term usually used for variably updating scenery based on the elapsed time since the game last updated
--dt is a fraction of a second
PADDLE_SPEED = 200
-- love.draw() rendering behaviour

-- love.graphics.printf(text, x, y, [width], [align])
--print func to align text on the screen

--love.window.setMode(width, height, params)
--window setup

--math.randomseed(num) random numer generator
--os.time() returns time in seconds
--math.random(min, max)
--random num between min and max
--

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('Moonchild.ttf', 15)
    scoreFont = love.graphics.newFont('Moonchild.ttf', 30)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WINDOW_LENGTH, VIRTUAL_WINDOW_HEIGHT,WINDOW_LENGTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_WINDOW_HEIGHT - 50

    ballX = VIRTUAL_WINDOW_LENGTH /2 -2
    ballY = VIRTUAL_WINDOW_HEIGHT /2 -2
    
    --delta x, detla y, velocity of the ball
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)
    --start string state
    gameState = 'start'

end

function love.update(dt)
    if love.keyboard.isDown('w') then
        --math.max ensures that paddles won't go above screen frames
        player1Y = math.max(0, player1Y + -PADDLE_SPEED *dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_WINDOW_HEIGHT -20, player1Y + PADDLE_SPEED *dt)
    end
    if love.keyboard.isDown('up') then
        player2Y = math.max(0,player2Y + -PADDLE_SPEED *dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_WINDOW_HEIGHT -20,player2Y + PADDLE_SPEED *dt)
    end
    if gameState == 'play' then
        ballX = ballX + ballDX *dt
        ballY = ballY + ballDY *dt
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit() --function to terminate application
    end
end

function love.draw()
    push:apply('start')
    --whatever is here is going to render at this resolution
    love.graphics.clear(188/255, 161/255, 245/255, 0.90)
    love.graphics.setFont(smallFont)

    love.graphics.printf('Pong Game!', 0, 20, VIRTUAL_WINDOW_LENGTH, 'center')
    love.graphics.setFont(scoreFont)

    love.graphics.print(tostring(player1Score), VIRTUAL_WINDOW_LENGTH /2 - 50, VIRTUAL_WINDOW_HEIGHT /3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WINDOW_LENGTH /2 + 30, VIRTUAL_WINDOW_HEIGHT /3)

    love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    
    love.graphics.rectangle('fill', VIRTUAL_WINDOW_LENGTH - 10, player2Y, 5, 20)
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    --end rendering at virtual resolution
    push:apply('end') 
end

--love.graphics.setDefaultFilter(min, mag)
--texture scaling filter, sligthly blur look

--love.keypressed(key)
--key interaction with game

--love.event.quit()
--quitting application

--love.graphics.newFont(path, size)
--loads font into specific path

--love.graphics.setFont(font)
--set font to currently active font

--love.graphics.clear(r, g, b, a)
--wipes screen with RGBA defined color

--love.graphics.rectangle( mode, x, y, width, height, rx, ry, segments )
--love.keyboard.isDown(key) -- returns true or false wheter key is pressed down or not


