local parts = {}

local function load()

	local pos = {
		button1 = {430, 955},
		button2 = {430, 920},
		button3 = {540, 955}
	}
	
	parts.source = {
			{id = "src-default-exoption-parts", path = "customize/advanced/default_exoption/parts.png"},
		}
		
	parts.image = {
		{id = "default_exnote_button",		src = "src-default-exoption-parts", x = 0, y = 0, w = 100, h = 100, divy = 4, len = 4, ref = 350, act = 350},
		{id = "default_lnmod_button",		src = "src-default-exoption-parts", x = 100, y = 0, w = 100, h = 150, divy = 6, len = 6, ref = 353, act = 353},
		{id = "default_constant_button",	src = "src-default-exoption-parts", x = 200, y = 0, w = 100, h = 50, divy = 2, len = 2, ref = 400, act = 400},
		{id = "default_exoption_rect",		src = "src-default-exoption-parts", x = 100, y = 150, w = 100, h = 25}
	}
	
	parts.destination = {
		{id = "default_exnote_button",		dst = {{x = pos.button1[1], y = pos.button1[2], w = 100, h = 25}}},
		{id = "default_lnmod_button",		dst = {{x = pos.button2[1], y = pos.button2[2], w = 100, h = 25}}},
		{id = "default_constant_button",	dst = {{x = pos.button3[1], y = pos.button3[2], w = 100, h = 25}}}, -- 表示に反映されない ボタンとしては機能している
		{id = "default_exoption_rect",		dst = {{x = pos.button1[1], y = pos.button1[2], w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_exoption_rect",		dst = {{x = pos.button2[1], y = pos.button2[2], w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
		{id = "default_exoption_rect",		dst = {{x = pos.button3[1], y = pos.button3[2], w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}}
	}	
	
	return parts	
end

return {
	parts = parts,
	load = load
}