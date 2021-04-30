--
-- Clase Player
--
--

require("game_object")
require("constants")
require("animations")


-- El jugador será un tipo de GameObject
Player = GameObject:new()

--
-- Constructor del jugador
-- Necesitamos el mundo donde estará, su posición x e y, y su id
--
--
function Player:newPlayer(world, x, y, sprite_sheet, id)
	-- creamos el objeto con base de GameObject
	obj = GameObject:newGameObject(world, x, y, "dynamic")
	-- le asignamos una altura y anchura, asociados a su forma
	obj.width = 32
	obj.height = 32
	obj.shape = love.physics.newRectangleShape(obj.width, obj.height)

	-- Emparejamos el cuerpo con la forma del jugador
	obj.fixture = love.physics.newFixture(obj.body, obj.shape, 1)
	obj.fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.fixture:setUserData(id)

	-- Variables de su velocidad, fuerza de salto, masa, y estado
	obj.x_speed = 700
	obj.jump_power = 500
	obj.max_speed = 500
	obj.body:setMass(1)
	obj.mode = "jumping"

	obj.scale = 4

	-- orientación y animación
	obj.orientation = 1

	obj.animations = {}
	obj.animations.idle = newAnimation(sprite_sheet, 0, 32, 32, 1)
	obj.animations.walk = newAnimation(sprite_sheet, 32, 32, 32, 1)


	setmetatable(obj, self)
	self.__index = self
	return obj
end

-- función para mover al jugador en el eje x
-- Se necesitan valores en x, que será -1 o 1, y se escalara con respecto al valor
-- de x_speed del jugador

function Player:move(dir_x)

	-- cambiamos la orientacion del jugador
	self.orientation = dir_x

	-- le aplicamos la fuerza correspondiente
	self.body:applyForce(self.x_speed * dir_x, 0)

	-- si ha llegado a su limite de velocidad, lo mantenemos en el limite
	local x, y = self.body:getLinearVelocity()

	if ( x > self.max_speed ) then
		self.body:setLinearVelocity(self.max_speed, y)
	elseif ( x < -self.max_speed ) then
		self.body:setLinearVelocity(-self.max_speed, y)
	end

	if Constants.DEBUG then
		print(x, "\t", y)
	end

end

-- función para que el jugador salte
function Player:jump()
	-- si no está saltando, cambiamos el estado a saltando y le aplicamos
	-- la fuerza de salto
	-- aplicamos la fuerza negativa, ya que el eje Y crece hacia abajo
	if self.mode ~= "jumping" then
		self.mode = "jumping"
		local x, _ = self.body:getLinearVelocity()
		self.body:setLinearVelocity(x, 0)
		self.body:applyLinearImpulse(0, -self.jump_power)
	end
end

-- cambiar el estado de un jugador
function Player:setMode(mode)
	self.mode = mode
end

-- obtener el estado de un jugador
function Player:getMode()
	return self.mode
end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function Player:update(dt)

	-- No permitimos que el jugador se gire
	self.body:setAngle(0)

	if self.mode == "grounded" then
		-- Animamos el jugador
		self.animations.idle.currentTime = self.animations.idle.currentTime + dt
		if self.animations.idle.currentTime >= self.animations.idle.duration then
			self.animations.idle.currentTime = self.animations.idle.currentTime - self.animations.idle.duration
		end
	end

	if Constants.DEBUG then
		print("Modo del jugador ", self.fixture:getUserData() ," : ", self.mode)
	end
end

-- Función para dibujar el jugador
function Player:draw()

	-- limpiamos la brocha de dibujado
	love.graphics.reset()
	-- calculamos que sprite se tiene que dibujar
	local spriteNum = math.floor(self.animations.idle.currentTime / self.animations.idle.duration * #self.animations.idle.quads) + 1

	-- Dibujamos el sprite, dependiendo de la orientación establecemos el ancho para
	-- dibujarlo al reves
	local width = self.orientation * self.width
	love.graphics.draw(self.animations.idle.spriteSheet, self.animations.idle.quads[spriteNum], self.body:getX() + (width / 2) * self.scale , self.body:getY() - (self.height / 2) * self.scale, 0, -self.orientation * self.scale, self.scale )

	if Constants.SHOW_HITBOX then
		love.graphics.setLineWidth( 1 )
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end
end
