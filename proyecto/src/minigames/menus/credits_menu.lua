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
	local down_box_page_1 = {self.background_box[1] + self.background_box[3]/2 - 200, 350, 400, 60}

	self.made_by = TextBox:new(language.MADE_BY, up_box[1], up_box[2], up_box[3], up_box[4], 35, 0.9, text_color, box_color)
	self.author_1 = TextBox:new("Guillermo Sandoval", self.background_box[1] , 250, self.background_box[3], 30, 35, 0, text_color, box_color)
	self.author_2 = TextBox:new("Antonio D. Villegas", self.background_box[1], 300, self.background_box[3], 30, 35, 0, text_color, box_color)

	self.art = TextBox:new(language.ART, down_box_page_1[1], down_box_page_1[2], down_box_page_1[3], down_box_page_1[4], 35, 0.9, text_color, box_color)
	self.artist = {}

	local names_art = {"Calciumtrice","PixelFrog","Khrinx","dbAF23"}

	for i=1, #names_art, 1 do
		self.artist[i] = TextBox:new(names_art[i], self.background_box[1] , 430 + 50*(i-1), self.background_box[3], 30, 35, 0, text_color, box_color)
	end

	self.sound = TextBox:new(language.SOUND, up_box[1], up_box[2], up_box[3], up_box[4], 35, 0.9, text_color, box_color)
	self.musician = {}

	local names_music = {"Monsplaisir", "Zuzek06", "Lukeo135", "Independent.nu", "SomeSine"}

	for i=1, #names_music, 1 do
		self.musician[i] = TextBox:new(names_music[i], self.background_box[1] , 250 + 50*(i-1), self.background_box[3], 30, 35, 0, text_color, box_color)
	end

	local down_box_page_2 = {self.background_box[1] + self.background_box[3]/2 - 200, 500, 400, 60}

	self.font = TextBox:new(language.FONT, down_box_page_2[1], down_box_page_2[2], down_box_page_2[3], down_box_page_2[4], 35, 0.9, text_color, box_color)
	self.author_font = TextBox:new("Brian Kent", self.background_box[1] , 580, self.background_box[3], 30, 35, 0, text_color, box_color)

	self.active_page = 1
	self.NUM_PAGES = 2
end


function CreditsMenu:update(dt)

	Menu.update(self, dt)
	local buttons_position = {self.background_box[1] + self.background_box[3]/2 , 640}

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

		self.art:draw()
		for _, object in pairs(self.artist) do
			object:draw()
		end

	elseif self.active_page == 2 then
		self.sound:draw()
		for _, object in pairs(self.musician) do
			object:draw()
		end

		self.font:draw()
		self.author_font:draw()

	end

	local buttons_position = {self.background_box[1] + self.background_box[3]/2 , 640}
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
