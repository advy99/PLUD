require("player")
require("ball")

player1 = Player:new(50, love.graphics.getHeight() / 2)
player2 = Player:new(love.graphics.getWidth() - 50, love.graphics.getHeight() / 2)


function love.load()
	Ball:load()
end

function love.update(dt)
	handleKeyboard(dt)
 	Ball:update(dt)
end

function love.draw()
	player1:draw()
	player2:draw()
	Ball:draw()
end

function handleKeyboard(dt)
	if love.keyboard.isDown("w") then
		player1:move(1, dt)
	elseif love.keyboard.isDown("s")  then
		player1:move(-1, dt)
	end

	if  love.keyboard.isDown("up")  then
		player2:move(1, dt)
	elseif  love.keyboard.isDown("down")  then
		player2:move(-1, dt)
	end
end

function checkCollision(a, b) --Takes two arguments, the rectangles we want to check for collision.
	return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end
