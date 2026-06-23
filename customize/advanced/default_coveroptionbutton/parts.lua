local parts = {}

local function load()
	parts.source = {
			{id = "src-default-coveroptionbutton-parts", path = "customize/advanced/default_coveroptionbutton/parts.png"},
		}
		
	parts.image = {
		{id = "default_lanecover_button",	src = "src-default-coveroptionbutton-parts", x = 100, y = 0, w = 100, h = 50, divy = 2, len = 2, ref = 330, act = 330},
		{id = "default_liftcover_button",	src = "src-default-coveroptionbutton-parts", x = 0, y = 0, w = 100, h = 50, divy = 2, len = 2, ref = 331, act = 331},
		{id = "default_hidden_button",		src = "src-default-coveroptionbutton-parts", x = 200, y = 0, w = 100, h = 50, divy = 2, len = 2, ref = 332, act = 332},
		{id = "default_hsadjust_button",	src = "src-default-coveroptionbutton-parts", x = 300, y = 0, w = 100, h = 50, divy = 2, len = 2, ref = 342, act = 342},
		{id = "default_coveroption_button_rect",	src = "src-default-coveroptionbutton-parts", x = 100, y = 50, w = 100, h = 25}
	}	
	
	local lanebutton_x = 650
	local lanebutton_y = 955
	local liftbutton_x = 760
	local liftbutton_y = 955
	local hidbutton_x = 870
	local hidbutton_y = 955
	local adjustbutton_x = 980
	local adjustbutton_y = 955
	
	parts.destination = {
		{id = "default_lanecover_button",			dst = {{x = lanebutton_x, y = lanebutton_y, w = 100, h = 25}}},
		{id = "default_coveroption_button_rect",	dst = {{x = lanebutton_x, y = lanebutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_liftcover_button",			dst = {{x = liftbutton_x, y = liftbutton_y, w = 100, h = 25}}},
		{id = "default_coveroption_button_rect",	dst = {{x = liftbutton_x, y = liftbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_hidden_button",				dst = {{x = hidbutton_x, y = hidbutton_y, w = 100, h = 25}}},
		{id = "default_coveroption_button_rect",	dst = {{x = hidbutton_x, y = hidbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_hsadjust_button",			dst = {{x = adjustbutton_x, y = adjustbutton_y, w = 100, h = 25}}},
		{id = "default_coveroption_button_rect",	dst = {{x = adjustbutton_x, y = adjustbutton_y, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
	}	
	
	return parts	
end

return {
	parts = parts,
	load = load
}