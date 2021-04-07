require("player")
require("handle_input")


function love.load()
	love.math.setRandomSeed(os.time())
	local color_jugador1 = Color("red")
	local color_jugador2 = Color("pink")
	player1 = Player:new(50, love.graphics.getHeight() / 2, color_jugador1)
	player2 = Player:new(love.graphics.getWidth() - 100, love.graphics.getHeight() / 2, color_jugador2)
end

function love.update(dt)
	handleKeyboard(dt)
	if checkCollision(player1, player2) then
		player1.color:changeColor(love.math.random(), love.math.random(), love.math.random())
		player2.color:changeColor(love.math.random(), love.math.random(), love.math.random())
	end
end

function love.draw()
	player1:draw()
	player2:draw()
end

function checkCollision(a, b) --Takes two arguments, the rectangles we want to check for collision.
	return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end
