require("src/minigames/menus/menu")

local class = require "lib/middleclass"
local suit = require("lib/SUIT")

CreditsMenu = Menu:subclass('CreditsMenu')

function CreditsMenu:initialize(num_players)
	Menu.initialize(self, "level_credits", num_players)

	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	self.title = TextBox:new(language.CREDITS, 412, 80, 450, 75, 40, 1, text_color, box_color)

	self.background_box = {390, 70, 500, 625}
	self.config_background = TextBox:new("", self.background_box[1], self.background_box[2], self.background_box[3], self.background_box[4], 40, 0.9, text_color, box_color)

	local up_box = {self.background_box[1] + self.background_box[3]/2 - 200, 170, 400, 60}
	local down_box = {self.background_box[1] + self.background_box[3]/2 - 200, 350, 400, 60}

	self.made_by = TextBox:new(language.MADE_BY, up_box[1], up_box[2], up_box[3], up_box[4], 35, 0.9, text_color, box_color)
	self.author_1 = TextBox:new("Guillermo Sandoval", self.background_box[1] , 250, self.background_box[3], 30, 35, 0, text_color, box_color)
	self.author_2 = TextBox:new("Antonio D. Villegas", self.background_box[1], 300, self.background_box[3], 30, 35, 0, text_color, box_color)

	self.special_thanks = TextBox:new(language.THANKS, down_box[1], down_box[2], down_box[3], down_box[4], 35, 0.9, text_color, box_color)
	self.thanks = {}

	local names = {"Calciumtrice","PixelFrog","Khrinx","Monplaisir","Brian Kent"}

	for i=1, 5, 1 do
		self.thanks[i] = TextBox:new(names[i], self.background_box[1] , 430 + 50*(i-1), self.background_box[3], 30, 35, 0, text_color, box_color)
	end

	self.active_page = 1
	self.NUM_PAGES = 2
end


function CreditsMenu:update(dt)

	Menu.update(self, dt)
	local buttons_position = {self.background_box[1] + self.background_box[3]/2 , 630}

	if suit.Button("<-", {align = "center"}, buttons_position[1] - 35 - 100, buttons_position[2] , 70,30).hit then
		self.active_page = self.active_page - 1
		if self.active_page < 1 then
			self.active_page = self.active_page + self.NUM_PAGES
		end

	end

	if suit.Button("->", {align = "center"}, buttons_position[1] - 35 + 100, buttons_position[2], 70,30).hit then
		self.active_page = self.active_page + 1
		if self.active_page > self.NUM_PAGES then
			self.active_page = self.active_page - self.NUM_PAGES
		end
	end

end


function CreditsMenu:draw()
	love.graphics.reset()
	Menu.draw(self)

	self.config_background:draw()
	self.title:draw()

	if self.active_page == 1 then
		self.made_by:draw()
		self.author_1:draw()
		self.author_2:draw()

	elseif self.active_page == 2 then
		self.special_thanks:draw()
		for i=1, 5, 1 do
			self.thanks[i]:draw()
		end

	end






	local buttons_position = {self.background_box[1] + self.background_box[3]/2 , 630}
	local text_color = {1, 1, 1}
	local box_color = {0, 0, 0}
	local contador = TextBox:new(self.active_page .. "/" .. self.NUM_PAGES, buttons_position[1] - 50, buttons_position[2] - 10, 100, 50, 30, 0, text_color, box_color)

	contador:draw()

	suit.draw()

end

function CreditsMenu:handleEvent(object, event)
	Menu.handleEvent(self, object, event)
end


function CreditsMenu:handleEventBetweenObjects(object_a, object_b, event)

	Menu.handleEventBetweenObjects(self, object_a, object_b, event)

end
