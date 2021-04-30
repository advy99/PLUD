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

	obj.scale = 4

	obj.width = 12 * obj.scale
	obj.height = 10 * obj.scale
	local radius = obj.width * 3/5 / 2
	obj.circle_shape = love.physics.newCircleShape(radius)
	obj.rectangle_shape = love.physics.newRectangleShape(0, obj.height / 4, obj.width, obj.height / 2)

	-- Emparejamos el cuerpo con la forma del jugador
	obj.circle_fixture = love.physics.newFixture(obj.body, obj.circle_shape, 1)
	obj.circle_fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.circle_fixture:setUserData(id)

	obj.rectangle_fixture = love.physics.newFixture(obj.body, obj.rectangle_shape, 1)
	obj.rectangle_fixture:setCategory(Constants.PLAYER_CATEGORY)
	obj.rectangle_fixture:setUserData(id)
	obj.rectangle_fixture:setFriction(0.5)


	-- Variables de su velocidad, fuerza de salto, masa, y estado
	obj.x_speed = 700
	obj.jump_power = 500
	obj.max_speed = 500
	obj.body:setMass(1)
	obj.mode = "jumping"
	obj.previous_mode = obj.mode


	-- orientación y animación
	obj.orientation = 1

	obj.sprite_width = 32
	obj.sprite_height = 32

	obj.animations = {}
	obj.animations.idle = newAnimation(sprite_sheet, 0, obj.sprite_width, obj.sprite_height, 1)
	obj.animations.walk = newAnimation(sprite_sheet, 32, obj.sprite_width, obj.sprite_height, 1)
	obj.animations.jump = newAnimation(sprite_sheet, 64, obj.sprite_width, obj.sprite_height, 1)
	obj.animations.attack = newAnimation(sprite_sheet, 96, obj.sprite_width, obj.sprite_height, 1)
	obj.animations.dead = newAnimation(sprite_sheet, 128, obj.sprite_width, obj.sprite_height, 1)

	obj.current_animation = obj.animations.idle

	obj.remaining_jumps = 1

	obj.time_to_finish_animation = 0

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
	if self.remaining_jumps ~= 0 then
		self:setMode("jumping")
		self.remaining_jumps = self.remaining_jumps - 1
		local x, _ = self.body:getLinearVelocity()
		self.body:setLinearVelocity(x, 0)
		self.body:applyLinearImpulse(0, -self.jump_power)
	end
end

-- cambiar el estado de un jugador
function Player:setMode(mode)
	self.previous_mode = self.mode
	self.mode = mode

	if mode == "grounded" then
		self.remaining_jumps = 1
	end

end

-- Obtener el estado de un jugador
function Player:getMode()
	return self.mode
end

-- Función para que el jugador ataque
function Player:attack()
	self:setMode("attacking");
end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function Player:update(dt)

	-- No permitimos que el jugador se gire
	self.body:setAngle(0)

	if self.time_to_finish_animation <= 0 then

		-- Seleccionamos la animación adecuada en función del estado del jugador
		if self.mode == "grounded" then
			self.current_animation = self.animations.idle
		elseif self.mode == "walking" then
			self.current_animation = self.animations.walk
		elseif self.mode == "jumping" then
			self.current_animation = self.animations.jump
		elseif self.mode == "attacking" then
			self.current_animation = self.animations.attack
			self.time_to_finish_animation = 1
			-- como el ataque es una animación unica, volvemos al estado anterior
			-- en cuanto acabamos la animación
			self:setMode(self.previous_mode)
		elseif self.mode == "dying" then
			self.current_animation = self.animations.dead
			self.time_to_finish_animation = 1
		end
	else
		self.time_to_finish_animation = self.time_to_finish_animation - dt
	end

	self:animate(dt)

	-- Modo DEBUG: Muestra el estado del jugador
	if Constants.DEBUG then
		print("Modo del jugador ", self.fixture:getUserData() ," : ", self.mode)
	end
end

-- Función para animar al jugador

function Player:animate(dt)
	-- Animamos el jugador
	self.current_animation.currentTime = self.current_animation.currentTime + dt
	if self.current_animation.currentTime >= self.current_animation.duration then
		self.current_animation.currentTime = self.current_animation.currentTime - self.current_animation.duration
	end

end


-- Función para dibujar el jugador
function Player:draw()

	-- limpiamos la brocha de dibujado
	love.graphics.reset()
	-- calculamos que sprite se tiene que dibujar
	local spriteNum = math.floor(self.current_animation.currentTime / self.current_animation.duration * #self.animations.idle.quads) + 1

	-- Dibujamos el sprite, dependiendo de la orientación establecemos el ancho para
	-- dibujarlo al reves
	local width = self.body:getX() + (self.orientation * (self.sprite_width / 2 - 1)) * self.scale
	local height = self.body:getY() - (self.sprite_height / 2) * self.scale

	love.graphics.draw(self.current_animation.spriteSheet, self.current_animation.quads[spriteNum], width , height, 0, -self.orientation * self.scale, self.scale )

	if Constants.SHOW_HITBOX then
		love.graphics.setLineWidth( 1 )
		love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
		love.graphics.circle("line", self.body:getX(), self.body:getY(), self.circle_shape:getRadius())
		love.graphics.polygon("line", self.body:getWorldPoints(self.rectangle_shape:getPoints()))
	end
end
