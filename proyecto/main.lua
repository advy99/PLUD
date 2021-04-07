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

	objects.player1 = {}
	objects.player1.body = love.physics.newBody(world, 200, 550, "dynamic")
	objects.player1.shape = love.physics.newRectangleShape(50, 50) --the ball's shape has a radius of 20
	objects.player1.fixture = love.physics.newFixture(objects.player1.body, objects.player1.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.player1.fixture:setRestitution(0.9)

	objects.ground = {}
   objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
   objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
   objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) --attach shape to body

--
--
	-- local color_jugador1 = Color("red")
	-- local color_jugador2 = Color("pink")
	-- player1 =Player:new(50, love.graphics.getHeight() / 2, color_jugador1)
-- player2 = Player:new(love.graphics.getWidth() - 100, love.graphics.getHeight() / 2, color_jugador2)
--
	-- platform =Platform:new(0, love.graphics.getHeight() - 0, love.graphics.getWidth(), 50, color_jugador1)
end

function love.update(dt)
	world:update(dt)

	handleKeyboard(dt)
end

function love.draw()
	love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
	-- player1:draw()
	-- player2:draw()
	-- platform:draw()

	love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
	love.graphics.polygon("fill", objects.player1.body:getWorldPoints(objects.player1.shape:getPoints()))

end
