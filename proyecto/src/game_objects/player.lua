--
-- Clase Player
--
--

require("src/game_objects/game_object")
require("src/enums/constants")
require("src/general_functions")


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

	self.score = 0

	-- le asignamos una altura y anchura, asociados a su forma

	self.scale = 0.75

	self.width = 48 * self.scale
	self.height = 40 * self.scale

	self.player_id = id
	local radius = self.width * 3/5 / 2
	self.circle_shape = love.physics.newCircleShape(radius)
	self.rectangle_shape = love.physics.newRectangleShape(0, self.height / 4, self.width, self.height / 2)

	-- Emparejamos el cuerpo con la forma del jugador
	self.circle_fixture = love.physics.newFixture(self.body, self.circle_shape, 1)

	self.circle_fixture:setUserData(self.player_id)

	self.rectangle_fixture = love.physics.newFixture(self.body, self.rectangle_shape, 1)
	self.rectangle_fixture:setUserData(self.player_id)
	self.rectangle_fixture:setFriction(0.5)

	self.circle_fixture:setFilterData(1, 65535, Constants.PLAYER_GROUP)
	self.rectangle_fixture:setFilterData(1, 65535, Constants.PLAYER_GROUP)

	-- Variables de su velocidad, fuerza de salto, masa, y estado
	self.x_speed = 700
	self.jump_power = 500
	self.max_speed = 500
	self.body:setMass(1)
	self.mode = "jumping"
	self.previous_mode = self.mode


	-- orientación y animación
	self.orientation = 1


	self.animations = {}

	self.sprite_width = 128
	self.sprite_height = 128
	self.animations.idle = newAnimation(sprite_sheet, 0, self.sprite_width, self.sprite_height, 1)
	self.animations.walk = newAnimation(sprite_sheet, 128, self.sprite_width, self.sprite_height, 1)
	self.animations.jump = newAnimation(sprite_sheet, 256, self.sprite_width, self.sprite_height, 1)
	--self.animations.attack = newAnimation(sprite_sheet, 384, self.sprite_width, self.sprite_height, 1)
	self.animations.dead = newAnimation(sprite_sheet, 512, self.sprite_width, self.sprite_height, 1)


	self.current_animation = self.animations.idle

	self.remaining_jumps = 1

	self.has_died = false

	self.time_to_finish_animation = 0

	self.sound_manager:addSource("music/jump.ogg", "static", false, "jump")
	self.sound_manager:addSource("music/land.ogg", "static", false, "land")
	self.sound_manager:addSource("music/dead.ogg", "static", false, "dead")

	local sfx_level = config:getSFXVolume() * config:getSFXVolume()
	self.sound_manager:setVolume("jump", sfx_level)
	self.sound_manager:setVolume("land", sfx_level)
	self.sound_manager:setVolume("dead", sfx_level)


end

function Player:getScore()
	return self.score
end

-- función para mover al jugador en el eje x
-- Se necesitan valores en x, que será -1 o 1, y se escalara con respecto al valor
-- de x_speed del jugador

function Player:move(dir_x)
	if self.mode ~= "dying" then

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

	end

end

-- función para que el jugador salte
function Player:jump()
	if self.mode ~= "dying" then
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
end

-- cambiar el estado de un jugador
function Player:setMode(mode)

	if self.mode ~= "dying" then

		self.previous_mode = self.mode
		self.mode = mode

		if mode == "grounded" then
			self.remaining_jumps = 1
		end

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

-- Función para que el jugador muera
function Player:kill()
	self:setMode("dying")
	self.circle_fixture:setSensor(true)
	self.rectangle_fixture:setSensor(true)
	self.sound_manager:playSource("dead")
	self.score = self.score + 1
end

-- Función para gestionar que animación es necesaria utilizar en ese momento
function Player:handleAnimations(dt)

	if self.previous_mode ~= self.mode and self.mode == "dying" then
		self.current_animation = self.animations.dead
		self.time_to_finish_animation = 1
		self.previous_mode = self.mode
		self.current_animation.currentTime = 0
	end

	-- Si tenemos una animación a medias, no cambiamos de animación
	if self.time_to_finish_animation <= 0 and self.mode ~= "dying" then

		-- Seleccionamos la animación adecuada en función del estado del jugador
		if self.mode == "grounded" then
			self.current_animation = self.animations.idle
		elseif self.mode == "walking" then
			self.current_animation = self.animations.walk
		elseif self.mode == "jumping" then
			self.current_animation = self.animations.jump
			self.current_animation.currentTime = 0
			self.time_to_finish_animation = 1
		end
	elseif self.time_to_finish_animation <= 0 and self.mode == "dying"  then
		self.has_died = true
	end





end

function Player:respawn(pos_x, pos_y)
	self.has_died = false
	self.mode = "jumping"
	self.body:setPosition(pos_x, pos_y)
	self.body:setLinearVelocity(0, 0)
	self.circle_fixture:setSensor(false)
	self.rectangle_fixture:setSensor(false)
	self.body:setAwake(true)
	self.time_to_finish_animation = 0
end

-- Función para actualizar en cada frame el jugador
-- Recibe el tiempo transcurrido desde el ultimo update
function Player:update(dt)

	-- No permitimos que el jugador se gire
	self.body:setAngle(0)

	self:handleAnimations(dt)
	self:animate(dt)

end

-- Función para animar al jugador

function Player:animate(dt)
	-- Animamos el jugador

	-- si estamos saltando
	if self:getMode() == "jumping" then
		-- paramos la animación en el punto de salto, hasta que toque el suelo
		self.current_animation.currentTime = math.min(self.current_animation.currentTime + dt, 0.5)
		self.time_to_finish_animation =  math.max(self.time_to_finish_animation - dt, 0.5)
	else
		-- con cualquier otra animacion, simplemente la continuamos
		self.current_animation.currentTime = (self.current_animation.currentTime + dt) % self.current_animation.duration
		self.time_to_finish_animation = self.time_to_finish_animation - dt
	end

end

function Player:getCurrentQuad()
	-- calculamos que sprite se tiene que dibujar
	return math.floor(self.current_animation.currentTime / self.current_animation.duration * #self.animations.idle.quads) + 1

end

-- Función para dibujar el jugador
function Player:draw()

	if not self.has_died then
		-- limpiamos la brocha de dibujado
		love.graphics.reset()

		-- Dibujamos el sprite, dependiendo de la orientación establecemos el ancho para
		-- dibujarlo al reves
		local width = self.body:getX() + (self.orientation * (self.sprite_width / 2 - 1)) * self.scale
		local height = self.body:getY() - (self.sprite_height / 2) * self.scale

		local num_quad = self:getCurrentQuad()

		if self.current_animation == self.animations.jump and num_quad < 8 and num_quad > 2 then
			height = height + num_quad
		end

		love.graphics.draw(self.current_animation.spriteSheet, self.current_animation.quads[num_quad], width , height, 0, -self.orientation * self.scale, self.scale )

		if Constants.SHOW_HITBOX then
			love.graphics.setLineWidth( 1 )
			love.graphics.setColor(1, 0, 0) -- set the drawing color to red for the hitbox
			love.graphics.circle("line", self.body:getX(), self.body:getY(), self.circle_shape:getRadius())
			love.graphics.polygon("line", self.body:getWorldPoints(self.rectangle_shape:getPoints()))
		end

	end
end


function Player:keyPressed(k)
	if k == config.config[self.player_id].JUMP_KEY then
		self:jump()
	end
end


function Player:keyReleased(k)
	if k == config.config[self.player_id].LEFT_KEY or k == config.config[self.player_id].RIGHT_KEY then
		self:stopWalking()
	end
end

function Player:handleKeyboard(dt)
	if love.keyboard.isDown(config.config[self.player_id].LEFT_KEY) then
		self:move(-1)
	elseif love.keyboard.isDown(config.config[self.player_id].RIGHT_KEY) then
		self:move(1)
	end
end

function Player:destroy()
	self.body:destroy()
end
