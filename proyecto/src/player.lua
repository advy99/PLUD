--
-- Clase Player
--
--

require("src/game_object")
require("src/constants")
require("src/animations")


-- El jugador será un tipo de GameObject
Player = GameObject:subclass('Player')


--
-- Constructor del jugador
-- Necesitamos el mundo donde estará, su posición x e y, y su id
--
--
function Player:initialize(world, x, y, sprite_sheet, id)
	-- creamos el selfeto con base de GameObject
	GameObject.initialize(self, world, x, y, "dynamic")

	-- le asignamos una altura y anchura, asociados a su forma

	self.scale = 4

	self.width = 12 * self.scale
	self.height = 10 * self.scale
	local radius = self.width * 3/5 / 2
	self.circle_shape = love.physics.newCircleShape(radius)
	self.rectangle_shape = love.physics.newRectangleShape(0, self.height / 4, self.width, self.height / 2)

	-- Emparejamos el cuerpo con la forma del jugador
	self.circle_fixture = love.physics.newFixture(self.body, self.circle_shape, 1)
	self.circle_fixture:setCategory(Constants.PLAYER_CATEGORY)
	self.circle_fixture:setUserData(id)

	self.rectangle_fixture = love.physics.newFixture(self.body, self.rectangle_shape, 1)
	self.rectangle_fixture:setCategory(Constants.PLAYER_CATEGORY)
	self.rectangle_fixture:setUserData(id)
	self.rectangle_fixture:setFriction(0.5)


	-- Variables de su velocidad, fuerza de salto, masa, y estado
	self.x_speed = 700
	self.jump_power = 500
	self.max_speed = 500
	self.body:setMass(1)
	self.mode = "jumping"
	self.previous_mode = self.mode


	-- orientación y animación
	self.orientation = 1

	self.sprite_width = 32
	self.sprite_height = 32

	self.animations = {}
	self.animations.idle = newAnimation(sprite_sheet, 0, self.sprite_width, self.sprite_height, 1)
	self.animations.walk = newAnimation(sprite_sheet, 32, self.sprite_width, self.sprite_height, 1)
	self.animations.jump = newAnimation(sprite_sheet, 64, self.sprite_width, self.sprite_height, 1)
	self.animations.attack = newAnimation(sprite_sheet, 96, self.sprite_width, self.sprite_height, 1)
	self.animations.dead = newAnimation(sprite_sheet, 128, self.sprite_width, self.sprite_height, 1)

	self.current_animation = self.animations.idle

	self.remaining_jumps = 1

	self.time_to_finish_animation = 0
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

	self:startWalking()

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

function Player:startWalking()
	if self.mode == "grounded" then
		self:setMode("walking")
	end
end

-- Función para que el jugador deje de andar
function Player:stopWalking()
	if self.mode == "walking" then
		self:setMode(self.previous_mode);
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

-- Función para que el jugador muera
function Player:kill()
	self:setMode("dying");
end

-- Función para gestionar que animación es necesaria utilizar en ese momento
function Player:handleAnimations(dt)

	-- Si tenemos una animación a medias, no cambiamos de animación
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
			self:setMode(self.previous_mode)
		end
	else
		self.time_to_finish_animation = self.time_to_finish_animation - dt
	end

end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function Player:update(dt)

	-- No permitimos que el jugador se gire
	self.body:setAngle(0)

	self:handleAnimations(dt)
	self:animate(dt)

	-- Modo DEBUG: Muestra el estado del jugador
	if Constants.DEBUG then
		print("Modo del jugador ", self.circle_fixture:getUserData() ," : ", self.mode)
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
