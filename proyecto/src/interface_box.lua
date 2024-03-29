local class = require "lib/middleclass"

InterfaceBox = class("InterfaceBox")

function InterfaceBox:initialize(posX, posY, keys)

	self.show_controls = true

	self.posX = posX
	self.posY = posY

	self.keys = keys

	self.sizeW = 224
	self.sizeH = 96
	self.textSize = 22
	self.opacity = 0.5

	local text_color = {0, 0, 0}
	local box_color = {1, 1, 1}
	local key_size = 28
	self.up = TextBox:new( string.upper(self.keys.JUMP_KEY), self.posX + 3*self.sizeW/5, self.posY + 16, key_size, key_size, 16, 1, text_color, box_color) -- text, posX, posY, sizeW, sizeH, textSize
	self.left = TextBox:new( string.upper(self.keys.LEFT_KEY), self.posX - 17 + 3*self.sizeW/5, self.posY + 48, key_size, key_size, 16, 1, text_color, box_color)
	self.right = TextBox:new( string.upper(self.keys.RIGHT_KEY), self.posX + 17 + 3*self.sizeW/5, self.posY + 48, key_size, key_size, 16, 1, text_color, box_color)
	self.add = TextBox:new( string.upper(Constants.ADD_PLAYER_KEY), self.posX + 4*self.sizeW/5, self.posY + 16, key_size, key_size, 16, 1, text_color, box_color)
	self.remove = TextBox:new( string.upper(Constants.REMOVE_PLAYER_KEY), self.posX + 4*self.sizeW/5, self.posY + 48, key_size, key_size, 16, 1, text_color, box_color)

end

function InterfaceBox:update(keys)
	self.keys = keys
	self.up:updateText(string.upper(self.keys.JUMP_KEY))
	self.left:updateText(string.upper(self.keys.LEFT_KEY))
	self.right:updateText(string.upper(self.keys.RIGHT_KEY))
end

function InterfaceBox:draw(player)

	love.graphics.setColor(0, 0, 0, self.opacity)
	love.graphics.rectangle( "fill", self.posX, self.posY, self.sizeW, self.sizeH, self.sizeW / 10)

	-- Mostrar la interfaz del jugador activo
	if player ~= nil then
		local current_animation = player.current_animation
		local current_quad = player:getCurrentQuad()

		love.graphics.reset()
		love.graphics.draw(current_animation.spriteSheet, current_animation.quads[current_quad], self.posX , self.posY, 0, player.scale, player.scale )

		-- Mostar los controles del jugador activo
		if self.show_controls then
			self.up:draw()
			self.left:draw()
			self.right:draw()
		-- Mostar la puntuación del jugador activo
		else
			love.graphics.setColor(1, 1, 1)
			local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
			love.graphics.setFont(font)
			love.graphics.printf(language.SCORE .. "\n" .. player:getScore(), self.posX + 34,  self.posY + self.sizeH / 4, self.sizeW, "center")
		end
	-- Mostar un cuadro de ayuda para añadir/eliminar jugadores
	else
		self.add:draw()
		self.remove:draw()
		love.graphics.setColor(1, 1, 1)
		local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
		love.graphics.setFont(font)
		love.graphics.printf(language.ADD_PLAYER , self.posX - self.sizeW/10,  self.posY + self.sizeH/5 + 2, self.sizeW, "center")
		love.graphics.printf(language.REMOVE_PLAYER , self.posX - self.sizeW/10 ,  self.posY + 54, self.sizeW, "center")

	end
end

function InterfaceBox:setShow(type)
	self.show_controls = type == "controls"
end
