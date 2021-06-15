local class = require "lib/middleclass"

SoundManager = class("SoundManager")

SoundManager.static.menu_music = love.audio.newSource("music/menu.ogg", "stream")
SoundManager.static.menu_music:setLooping(true)

function SoundManager:initialize()
	self.sounds = {}
end

function SoundManager:addSource(path, type, loop, id)
	self.sounds[id] = love.audio.newSource(path, type)
	self.sounds[id]:setLooping(loop)
end

function SoundManager:playSource(id)
	if not self.sounds[id]:isPlaying() then
		self.sounds[id]:play()
	end
end

function SoundManager:stopSource(id)
	self.sounds[id]:stop()
end

function SoundManager:setVolume(id, value)
	self.sounds[id]:setVolume(value)
end

function SoundManager:isPlaying(id)
	return self.sounds[id]:isPlaying()
end
