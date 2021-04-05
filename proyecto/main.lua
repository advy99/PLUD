require("player")
require("handle_input")


function love.load()
	local color_jugador1 = ColorRGB:new(255, 0, 0)
	local color_jugador2 = ColorRGB:new(0, 255, 0)
	player1 = Player:new(50, love.graphics.getHeight() / 2, color_jugador1)
	player2 = Player:new(love.graphics.getWidth() - 50, love.graphics.getHeight() / 2, color_jugador2)
end

function love.update(dt)
	handleKeyboard(dt)
end

function love.draw()
	player1:draw()
	player2:draw()
end

function checkCollision(a, b) --Takes two arguments, the rectangles we want to check for collision.
	return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end
