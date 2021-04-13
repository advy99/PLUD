require("player")
require("handle_input")
require("constants")
require("platform")


function love.load()
	love.math.setRandomSeed(os.time()) -- Semilla para el cambio de colores aleatorio al colisionar

	local px_per_meter = 64
	love.physics.setMeter(px_per_meter)
	world = love.physics.newWorld(0, Constants.GRAVITY * px_per_meter, true)

	objects = {}

	objects.player1 = Player:newPlayer(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	objects.player2 = Player:newPlayer(world, love.graphics.getWidth() / 4, love.graphics.getHeight() / 2)

	objects.platform = Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 100, love.graphics.getWidth(), 50)
	objects.platformR = Platform:newPlatform(world, love.graphics.getWidth() / 4, love.graphics.getHeight() - 250, love.graphics.getWidth()/5, 50)

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
