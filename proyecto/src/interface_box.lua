local class = require "lib/middleclass"

InterfaceBox = class("InterfaceBox")

function InterfaceBox:initialize(posX, posY, keys)

	self.show_controls = false

	self.posX = posX
	self.posY = posY

	self.keys = keys

	self.sizeW = 224
	self.sizeH = 96
	self.textSize = 30
	self.opacity = 0.5

	local text_color = {0, 0, 0}
	local box_color = {1, 1, 1}
	local key_size = 28
	self.up = TextBox:new( string.upper(self.keys.JUMP_KEY), self.posX + 3*self.sizeW/5, self.posY + 16, key_size, key_size, 16, 1, text_color, box_color) -- text, posX, posY, sizeW, sizeH, textSize
	self.left = TextBox:new( string.upper(self.keys.LEFT_KEY), self.posX - 17 + 3*self.sizeW/5, self.posY + 48, key_size, key_size, 16, 1, text_color, box_color)
	self.right = TextBox:new( string.upper(self.keys.RIGHT_KEY), self.posX + 17 + 3*self.sizeW/5, self.posY + 48, key_size, key_size, 16, 1, text_color, box_color)

end

function InterfaceBox:draw(player)

	local current_animation = player.current_animation
	local current_quad = player:getCurrentQuad()

	love.graphics.setColor(0, 0, 0, self.opacity)
	love.graphics.rectangle( "fill", self.posX, self.posY, self.sizeW, self.sizeH, self.sizeW / 10)

	love.graphics.reset()
	love.graphics.draw(current_animation.spriteSheet, current_animation.quads[current_quad], self.posX , self.posY, 0, player.scale, player.scale )

	if self.show_controls then
		self.up:draw()
		self.left:draw()
		self.right:draw()
	else
		love.graphics.setColor(1, 1, 1)
		local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
		love.graphics.setFont(font)
		love.graphics.printf("SCORE\n" .. player:getScore(), self.posX + 32,  self.posY + self.sizeH / 4, self.sizeW, "center")
	end
end

function InterfaceBox:switchBetweenControlsAndScore()
	self.show_controls = not self.show_controls
end
