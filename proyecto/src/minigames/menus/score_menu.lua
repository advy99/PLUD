require("src/minigames/menus/menu")

local class = require "lib/middleclass"
local LIP = require "lib/LIP"


ScoreMenu = Menu:subclass('ScoreMenu')

function ScoreMenu:initialize(num_players)
	Menu.initialize(self, "level_score", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new(language.HIGHSCORE, 412, 80, 450, 75, 40, 1, text_color, box_color)

	self.background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)

	self.scores_file = LIP.load("config/highscore.ini")


	-- for k,v in pairs(self.scores_file.highscore) do
	-- 	self.scores_file.highscore[k] = tonumber(v)
	-- 	print(v)
	-- end

	local ordered_scores = {}

	local j = 1
	for k,v in spairs(self.scores_file.highscore, function(t,a,b) return t[b] < t[a] end) do
		ordered_scores[j] = {k, v}
		j = j + 1
	end


	self.bests = {}

	for i=1, 10, 1 do
		if ordered_scores[i] ~= nil then
			local score = tostring(ordered_scores[i][2])

			while #score < 3 do
				score = "0" .. score
			end

			self.bests[i] = TextBox:new(score .. "\t" .. string.upper(ordered_scores[i][1]), self.background_box[1] , 170 + 50*(i-1), self.background_box[3], 30, 35, 0, text_color, box_color)
		else
			self.bests[i] = TextBox:new("000\t---", self.background_box[1] , 170 + 50*(i-1), self.background_box[3], 30, 35, 0, text_color, box_color)
		end
		self.bests[i]:setFont("fonts/RobotoMono-Bold.ttf")
	end



end


function ScoreMenu:update(dt)

	Menu.update(self, dt)
end


function ScoreMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()

	for _, object in pairs(self.bests) do
		object:draw()
	end
end

function ScoreMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ScoreMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
