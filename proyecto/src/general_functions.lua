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

function table_size(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end


function readKey()

	local name, a,b,c,d,e,f = love.event.wait()

	while (name ~= "keyreleased")
	do
		name, a,b,c,d,e,f = love.event.wait()
	end

	return a
end

function vector_length(x, y)
	return math.sqrt(x*x + y*y)
end

function normalized(x, y)
	local len = vector_length(x, y)
	return x / len, y / len
end

function vector_dot(x1, y1, x2, y2)
	return (x1 * x2) + (y1 * y2)
end


function changeLanguage(val)
	if val == "spanish" then
		language = Spanish
	elseif val == "english" then
		language = English
	elseif val == "german" then
		language = German
	end
end
