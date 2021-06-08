local class = require "lib/middleclass"
local LIP = require "lib/LIP"

Configuration = class("Configuration")

function Configuration:initialize()
	self.config = nil
	self.path = "config/config.ini"
	self:loadConfiguration()
end


function Configuration:setVSYNC(mode)
	assert(type(mode) == "boolean", "setVSYNC expects a boolean")

	self.config.screen.vsync = mode
end

function Configuration:getVSYNC()
	return self.config.screen.vsync
end

function Configuration:getTextVSYNC()
	if self.config.screen.vsync then
		return "ON"
	else
		return "OFF"
	end
end

function Configuration:setShowFPS(mode)
	assert(type(mode) == "boolean", "setShowFPS expects a boolean")

	self.config.screen.showFPS = mode

end

function Configuration:getShowFPS()
	return self.config.screen.showFPS
end

function Configuration:setFullscreen(mode)
	assert(type(mode) == "boolean", "setFullscreen expects a boolean")

	self.config.screen.fullscreen = mode
end

function Configuration:getFullscreen()
	return self.config.screen.fullscreen
end

function Configuration:saveConfig()
	LIP.save(self.path, self.config)
end

function Configuration:loadConfiguration()
	self.config = LIP.load(self.path)
end


function Configuration:getMusicVolume()
	return self.config.audio.music
end

function Configuration:getSFXVolume()
	return self.config.audio.sfx
end

function Configuration:setMusicVolume(value)
	self.config.audio.music = value
end

function Configuration:setSFXVolume(value)
	self.config.audio.sfx = value
end


function Configuration:keyAssigned(k)

	for i = 1,4,1 do
		for _, object in pairs(self.config["player" .. i]) do
			if k == object then
				return true
			end
		end
	end

	return false
end
