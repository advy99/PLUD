require("player")
require("handle_input")
require("physics")
require("platform")


function love.load()
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar
	local color_jugador1 = Color("red")
	local color_jugador2 = Color("pink")
	player1 = Player:new(50, love.graphics.getHeight() / 2, color_jugador1)
	player2 = Player:new(love.graphics.getWidth() - 100, love.graphics.getHeight() / 2, color_jugador2)

	platform = Platform:new(0, love.graphics.getHeight() - 75, love.graphics.getWidth(), 50, color_jugador1)
end

function love.update(dt)
	handleKeyboard(dt)
	if checkCollision(player1, player2) then
		player1.color:changeColor(love.math.random(), love.math.random(), love.math.random())
		player2.color:changeColor(love.math.random(), love.math.random(), love.math.random())
	end

	if checkCollision(player1, platform) then
		player1.mass = -player1.mass
	end

	gravity(player1, dt)
	gravity(player2, dt)
	gravity(platform, dt)
end

function love.draw()
	player1:draw()
	player2:draw()
	platform:draw()
end

function checkCollision(a, b) --Takes two arguments, the rectangles we want to check for collision.
	return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end

function gravity(obj, dt)
	if obj.has_gravity then
		obj.y = obj.y + Constants.GRAVITY * obj.mass * dt
	end
end
