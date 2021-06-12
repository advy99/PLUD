--
-- Clase EnergyBall
--
--

require("src/game_objects/game_object")
require("src/enums/constants")
require("src/general_functions")


-- El jugador será un tipo de GameObject
EnergyBall = GameObject:subclass('EnergyBall')


--
-- Constructor del jugador
-- Necesitamos el mundo donde estará, su posición x e y, y su id
--
--
function EnergyBall:initialize(world, x, y)
	-- creamos el selfeto con base de GameObject
	GameObject.initialize(self, world, x, y, "dynamic")


	-- orientación y animación
	self.orientation = 1

	self.sprite_width = 94
	self.sprite_height = 86

	local img = love.graphics.newImage("img/energy_ball.png")
	self.animation = newAnimation(img, 0, self.sprite_width, self.sprite_height, 0.25)

	-- le asignamos una altura y anchura, asociados a su forma

	self.scale = 0.75

	local radius = (self.sprite_width - 15) * self.scale / 2
	self.circle_shape = love.physics.newCircleShape(radius)

	-- Emparejamos el cuerpo con la forma del jugador
	self.circle_fixture = love.physics.newFixture(self.body, self.circle_shape, 1)
	self.circle_fixture:setGroupIndex(Constants.OBJECTS_GROUP)
	self.circle_fixture:setCategory(Constants.DEATH_BALL_CATEGORY)

	self.circle_fixture:setUserData("energy_ball")

	self.x_speed = 300
	self.y_speed = 300
	self.x_direction = 1
	self.y_direction = 1
end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function EnergyBall:update(dt)

	self.animation.currentTime = (self.animation.currentTime + dt) % self.animation.duration
	self.body:setLinearVelocity( self.x_speed * self.x_direction , self.y_speed * self.y_direction)
	-- self.body:setAngularVelocity(math.pi)
end

function EnergyBall:changeBallDirection(x, y)
	self.x_direction = x
	self.y_direction = y
end

function EnergyBall:getCurrentQuad()
	-- calculamos que sprite se tiene que dibujar
	return math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1

end

function EnergyBall:changeBallDirection()
	self.x_direction = -self.x_direction
	self.y_direction = -self.y_direction
end

-- Función para dibujar el jugador
function EnergyBall:draw()

		love.graphics.reset()

		-- Dibujamos el sprite, dependiendo de la orientación establecemos el ancho para
		-- dibujarlo al reves
		local width = self.body:getX() + (self.orientation * (self.sprite_width / 2 - 1)) * self.scale
		local height = self.body:getY() - (self.sprite_height / 2) * self.scale

		love.graphics.draw(self.animation.spriteSheet, self.animation.quads[self:getCurrentQuad()], width , height, 0, -self.orientation * self.scale, self.scale )

		if Constants.SHOW_HITBOX then
			love.graphics.setLineWidth( 1 )
			love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
			love.graphics.circle("line", self.body:getX(), self.body:getY(), self.circle_shape:getRadius())
		end
end
