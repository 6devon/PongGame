--https://github.com/Ulydev/push
push = require ('push')
Class = require('class')
require 'ball'
require 'paddle'

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
    love.window.setTitle('Pong')

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

    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WINDOW_LENGTH - 10, VIRTUAL_WINDOW_HEIGHT - 30, 5, 20)

    ball = Ball(VIRTUAL_WINDOW_LENGTH/ 2 -2, VIRTUAL_WINDOW_HEIGHT/2 -2, 4, 4)

    --start string state
    gameState = 'start'

end

function love.update(dt)
    if  gameState == 'play' then
        
        if ball:collides(player1) then
            ball.dx = -ball.dx *1.04 --if collision is detected, dx is reversed, 4% is added
            ball.x = player1.x +5 --shift 
            --keping velocity going in the same direction but randomizing it
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx *1.04 --if collision is detected, dx is reversed
            ball.x = player2.x -4 -- minus by width od the ball

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        --upper and lower screen detection
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_WINDOW_HEIGHT - 4 then 
            ball.y = VIRTUAL_WINDOW_HEIGHT - 4
            ball.dy = -ball.dy
        end
    end
        if love.keyboard.isDown('w') then
            --math.max ensures that paddles won't go above screen frames
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end

        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end

        if gameState == 'play' then
            ball:update(dt)
        end
        player1:update(dt)
        player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit() --function to terminate application
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ball:reset()

        end
    end
end

function love.draw()
    push:apply('start')
    --whatever is here is going to render at this resolution
    love.graphics.clear(107/255, 69/255, 187/255, 0.90)
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Start State', 0 , 20, VIRTUAL_WINDOW_LENGTH, 'center')
    else
        love.graphics.printf('Play State', 0 , 20, VIRTUAL_WINDOW_LENGTH, 'center')
    end
    love.graphics.setFont(scoreFont)

    --love.graphics.printf('Pong Game!', 0, 50, VIRTUAL_WINDOW_LENGTH, 'center')
    love.graphics.setFont(scoreFont)
    

    love.graphics.print(tostring(player1Score), VIRTUAL_WINDOW_LENGTH /2 - 50, VIRTUAL_WINDOW_HEIGHT /3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WINDOW_LENGTH /2 + 30, VIRTUAL_WINDOW_HEIGHT /3)

    --love.graphics.rectangle('fill', 10, player1Y, 5, 20)
    
    --love.graphics.rectangle('fill', VIRTUAL_WINDOW_LENGTH - 10, player2Y, 5, 20)
    --love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    player1:render()
    player2:render()
    ball:render()

    displayFPS()
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

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end


