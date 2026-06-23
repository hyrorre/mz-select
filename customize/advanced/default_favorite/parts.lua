local parts = {}

local function load()
	parts.source = {
			{id = "src-default-favorite-parts", path = "customize/advanced/default_favorite/parts.png"},
		}
		
	parts.image = {
		{id = "default_favoritesong_button",	src = "src-default-favorite-parts", x = 100, y = 0, w = 100, h = 75, divy = 3, len = 3, ref = 89, act = 89},
		{id = "default_favoritechart_button",	src = "src-default-favorite-parts", x = 0, y = 0, w = 100, h = 75, divy = 3, len = 3, ref = 90, act = 90},
		{id = "default_favorite_button_rect",	src = "src-default-favorite-parts", x = 100, y = 75, w = 100, h = 25}
	}	
	
	local fsbutton_x = 980
	local fsbutton_y = 920
	local fcbutton_x = 870
	local fcbutton_y = 920
	
	--楽曲のお気に入りが正しく動きません
	parts.destination = {
		{id = "default_favoritesong_button",	dst = {{x = fsbutton_x, y = fsbutton_y, w = 100, h = 25}}},
		{id = "default_favorite_button_rect",	dst = {{x = fsbutton_x, y = fsbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_favoritechart_button",	dst = {{x = fcbutton_x, y = fcbutton_y, w = 100, h = 25}}},
		{id = "default_favorite_button_rect",	dst = {{x = fcbutton_x, y = fcbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		--{id = "default_favoritechart_button",	dst = {{x = fsbutton_x, y = fcbutton_y, w = 100, h = 25}}},
		--{id = "default_favorite_button_rect",	dst = {{x = fsbutton_x, y = fcbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}}	
	}	
	
	return parts	
end

return {
	parts = parts,
	load = load
}