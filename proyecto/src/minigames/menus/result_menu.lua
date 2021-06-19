require("src/minigames/menus/menu")
local suit = require("lib/SUIT")
local LIP = require "lib/LIP"


local class = require "lib/middleclass"

ResultMenu = Menu:subclass('ResultMenu')

function ResultMenu:initialize(num_players)
	Menu.initialize(self, "level_result", num_players)

	self.input_text = {text = ""}

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}

	self.background_box = {Constants.DEFAULT_WIDTH / 2 - 200, Constants.DEFAULT_HEIGHT / 2 + 50, 400, 200}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)

	self.show_suit = true

	self.best_score = -1

end


function ResultMenu:update(dt)
	Menu.update(self, dt)

	if self.show_suit then
		suit.Input(self.input_text, Constants.DEFAULT_WIDTH / 2 , Constants.DEFAULT_HEIGHT / 2 + 75, 80, 40)

		if suit.Button(language.SUBMIT, {align = "center"}, Constants.DEFAULT_WIDTH / 2 - 100, Constants.DEFAULT_HEIGHT / 2 + 150, 200, 40).hit then

			if #self.input_text.text ~= 3 then
				-- TODO: que salga un mensaje de error de minimo tres caracteres

			else
				self.show_suit = false
				local score_file = LIP.load("config/highscore.ini")

				if score_file.highscore[self.input_text.text] == nil or score_file.highscore[self.input_text.text] < self.best_score then
					score_file.highscore[self.input_text.text] = self.best_score
				end

				LIP.save("config/highscore.ini", score_file)
			end

		end
		self.input_text.text = string.upper(string.sub(self.input_text.text, 1, 3))

		suit.Label(language.NAME .. ": ", {align = "left"}, Constants.DEFAULT_WIDTH / 2 - 120, Constants.DEFAULT_HEIGHT / 2 + 75, 200, 40)

	end

end


function ResultMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	if self.show_suit then
		self.config_background:draw()
		suit.draw()
	end
end

function ResultMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function ResultMenu:handleEventBetweenObjects(object_a, object_b, event)
	Menu.handleEventBetweenObjects(self, object_a, object_b, event)
end



function ResultMenu:keyPressed(k)
	Menu.keyPressed(self, k)
	suit.keypressed(k)
end

function ResultMenu:textEdited(text, start, length)
	suit.textedited(text, start, length)

end

function ResultMenu:textInput(t)
	if keyValid(t) then
		suit.textinput(t)
	end
end

function ResultMenu:setBestScore(best)
	self.best_score = best
end
