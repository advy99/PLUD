local class = require "lib/middleclass"

TextBox = class("TextBox")

function TextBox:initialize(text, posX, posY, sizeW, sizeH, textSize, opacity, text_color, box_color)

	self.text = text
	self.posX = posX
	self.posY = posY
	self.sizeW = sizeW
	self.sizeH = sizeH
	self.textSize = textSize
	self.opacity = opacity
	self.text_color = text_color
	self.box_color = box_color

end

function TextBox:draw()

	love.graphics.setColor(self.box_color[1], self.box_color[2], self.box_color[3], self.opacity)
	love.graphics.rectangle( "fill", self.posX, self.posY, self.sizeW, self.sizeH, self.sizeW / 10)

	love.graphics.setColor(self.text_color[1], self.text_color[2], self.text_color[3])
	local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
	love.graphics.setFont(font)
	love.graphics.printf(self.text, self.posX,  self.posY + self.sizeH / 4, self.sizeW, "center")
end

function TextBox:updateText(text)
	self.text = text
end
