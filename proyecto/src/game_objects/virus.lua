--
-- Clase Virus
--
--

require("src/game_objects/game_object")
require("src/enums/constants")
require("src/general_functions")


-- El virus será un tipo de GameObject
Virus = GameObject:subclass('Virus')


--
-- Constructor del virus
-- Necesitamos el mundo donde estará, su posición x e y, y su id
--
--
function Virus:initialize(world, x, y)
	-- creamos el selfeto con base de GameObject
	GameObject.initialize(self, world, x, y, "dynamic")


	-- orientación y animación
	self.orientation = 1

	self.sprite_width = 512
	self.sprite_height = 512

	local img = love.graphics.newImage("img/virus.png")
	self.animation = newAnimation(img, 0, self.sprite_width, self.sprite_height, 0.25)

	-- le asignamos una altura y anchura, asociados a su forma

	self.scale = 0.1

	local radius = (self.sprite_width - 100) * self.scale / 2
	self.circle_shape = love.physics.newCircleShape(radius)

	-- Emparejamos el cuerpo con la forma del jugador
	self.circle_fixture = love.physics.newFixture(self.body, self.circle_shape, 1)
	-- self.circle_fixture:setGroupIndex(Constants.OBJECTS_GROUP)
	-- self.circle_fixture:setCategory(Constants.VIRUS_CATEGORY)
	-- self.circle_fixture:setMask(65535) -- Máscara más grande

	self.circle_fixture:setFilterData(Constants.VIRUS_CATEGORY, 65535, Constants.OBJECTS_GROUP)

	self.circle_fixture:setUserData("virus")

	self.circle_fixture:setSensor(true)

	self.x_speed = 0
	self.y_speed = 500
	self.x_direction = 0
	self.y_direction = 1
end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function Virus:update(dt)

	self.animation.currentTime = (self.animation.currentTime + dt) % self.animation.duration
	self.body:setLinearVelocity( self.x_speed * self.x_direction , self.y_speed * self.y_direction)
	-- self.body:setAngularVelocity(math.pi)
end

function Virus:getCurrentQuad()
	-- calculamos que sprite se tiene que dibujar
	return math.floor(self.animation.currentTime / self.animation.duration * #self.animation.quads) + 1

end
-- Función para dibujar el jugador
function Virus:draw()

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

function Virus:setPosition(x, y)
	self.body:setPosition(x, y)
end

function Virus:getPosition()
	return self.body:getPosition()
end
