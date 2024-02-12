Ball = Class{}

function Ball:init(x, y, length, height)
    --self 
    self.x = x
    self.y = y
    self.length = length
    self.height = height

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--AABB Collision Detection
--no edges of our boxes are outside of rectangle

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.length or paddle.x > self.x + self.length then
        return false
    end
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.width then
        return false
    end
    return true
end

function Ball:reset()
    self.x = VIRTUAL_WINDOW_LENGTH/ 2 -2
    self.y = VIRTUAL_WINDOW_HEIGHT/ 2 -2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.length, self.height)
end