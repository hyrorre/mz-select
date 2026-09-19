local parts = {}

local function load()

	local parts_position = {x = 1305, y = 990}
	
	parts.source = {{id = "src-default_modechange_parts", path = "customize/advanced/default_modechange2/parts.png"}}

	parts.image = {
		{id = "default_modechange_modeset",		src = "src-default_modechange_parts", x = 0, y = 0, w = 150, h = 400, divy = 8, len = 8, ref = 11, act = 11, click = 2},
		-- TODO: 312 表示が反映されない
		-- {id = "default_modechange_sortset",		src = "src-default_modechange_parts", x = 150, y = 0, w = 150, h = 600, divy = 12, len = 12, ref = 312, act = 312, click = 2},
		{id = "default_modechange_sortset",		src = "src-default_modechange_parts", x = 150, y = 0, w = 150, h = 400, divy = 8, len = 8, ref = 12, act = 12, click = 2},
		{id = "default_modechange_lnmodeset",	src = "src-default_modechange_parts", x = 300, y = 0, w = 150, h = 150, divy = 3, len = 3, ref = 308, act = 308, click = 2},
		{id = "default_modechange_rect",		src = "src-default_modechange_parts", x = 300, y = 150, w = 150, h = 50}
	}

	parts.text = {
		{id = "bmz_ln_force_badge", font = "font-default-commonparts-mplus-1c-bold", size = 14, align = 1, constantText = "FORCE"}
	}

	parts.destination = {
		{id = "bmz_ln_force_badge", op = {19168}, clickable = false, dst = {{x = parts_position.x + 435, y = parts_position.y + 52, w = 150, h = 14, r = 255, g = 170, b = 64}}},
		{id = "default_modechange_modeset",		dst = {{x = parts_position.x, y = parts_position.y, w = 150, h = 50}}},
		{id = "default_modechange_sortset",		dst = {{x = parts_position.x + 180, y = parts_position.y, w = 150, h = 50}}},
		{id = "default_modechange_lnmodeset",	dst = {{x = parts_position.x + 360, y = parts_position.y, w = 150, h = 50}}},
		{id = "default_modechange_rect",		dst = {{x = parts_position.x, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}},
		{id = "default_modechange_rect",		dst = {{x = parts_position.x + 180, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}},
		{id = "default_modechange_rect",		dst = {{x = parts_position.x + 360, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}}
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}
