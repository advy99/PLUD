local class = require "lib/middleclass"

InterfaceBox = class("InterfaceBox")

function InterfaceBox:initialize(posX, posY, sprite)

	self.posX = posX
	self.posY = posY

	self.player_sprite = sprite

	self.sizeW = 224
	self.sizeH = 96
	self.textSize = 30
	self.opacity = 1

end

function InterfaceBox:draw(player)

	local current_animation = player.current_animation
	local current_quad = player:getCurrentQuad()

	love.graphics.setColor(0, 0, 0, self.opacity)
	love.graphics.rectangle( "fill", self.posX, self.posY, self.sizeW, self.sizeH, self.sizeW / 10)

	love.graphics.reset()
	love.graphics.draw(current_animation.spriteSheet, current_animation.quads[current_quad], 300 , 50, 0, -player.scale, player.scale )

	love.graphics.setColor(1, 1, 1)
	local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
	love.graphics.setFont(font)
	love.graphics.printf("PRUEBA", self.posX,  self.posY + self.sizeH / 3, self.sizeW, "center")
end
