require("player")
require("handle_input")
require("constants")
require("platform")


function love.load()
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	local px_per_meter = 64
	love.physics.setMeter(px_per_meter)
	world = love.physics.newWorld(0, Constants.GRAVITY * px_per_meter, true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	objects = {}

	objects.player1 = Player:newPlayer(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, "player1")
	objects.player2 = Player:newPlayer(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2, "player2")

	objects.platform = Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 100, love.graphics.getWidth(), 50, "up_platform")
	objects.platformR = Platform:newPlatform(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 250, love.graphics.getWidth()/5, 50, "down_platform")

end

function love.update(dt)
	world:update(dt)

	objects.player1:update(dt)
	objects.player2:update(dt)

	handleKeyboard(dt)
end

function love.draw()

	for _, object in pairs(objects) do
		object:draw()
	end

end

function beginContact(a, b, coll)

	if a:getUserData() == "player1" then
		objects.player1:endJump()
	elseif a:getUserData() == "player2" then
		objects.player2:endJump()
	end

	if b:getUserData() == "player1" then
		objects.player1:endJump()
	elseif b:getUserData() == "player2" then
		objects.player2:endJump()
	end

end

function endContact(a, b, coll)

end

function preSolve(a, b, coll)

end

function postSolve(a, b, coll, normalimpulse, tangentimpulse)

end
