local class = require "lib/middleclass"

TextBox = class("TextBox")

function TextBox:initialize(text, posX, posY, sizeW, sizeH, textSize)

	self.text = text
	self.posX = posX
	self.posY = posY
	self.sizeW = sizeW
	self.sizeH = sizeH
	self.textSize = textSize

end

function TextBox:draw()

	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle( "fill", self.posX, self.posY, self.sizeW, self.sizeH, self.sizeW / 10)

	love.graphics.setColor(1, 1, 1)
	local font = love.graphics.newFont("fonts/kirbyss.ttf", self.textSize)
	love.graphics.setFont(font)
	love.graphics.printf(self.text, self.posX,  self.posY + self.sizeH / 3, self.sizeW, "center")
end

function TextBox:updateText(text)
	self.text = text
end
