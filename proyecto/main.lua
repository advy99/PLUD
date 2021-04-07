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

	print(love.graphics.getWidth())
	objects.platform = Platform:newPlatform(world, love.graphics.getWidth() / 2, love.graphics.getHeight() - 100, love.graphics.getWidth(), 50)

end

function love.update(dt)
	world:update(dt)
	handleKeyboard(dt)
end

function love.draw()
	objects.platform:draw()
	objects.player1:draw()
	-- player2:draw()
	-- platform:draw()



end
