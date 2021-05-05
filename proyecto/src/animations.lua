function newAnimation(image, y, width, height, duration)
	local animation = {}
	animation.spriteSheet = image;
	animation.quads = {};

	for x = 0, image:getWidth() - width, width do
		table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
	end

	animation.duration = duration or 1
	animation.currentTime = 0

	return animation
end
