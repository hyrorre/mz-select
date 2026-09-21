local parts = {}

local function load()

	local parts_position = {x = 1305, y = 990}
	
	parts.source = {
		{id = "src-default_modechange_parts", path = "customize/advanced/default_modechange2/parts.png"},
		{id = "src-default_modechange_frame", path = "customize/advanced/default_modechange2/modechange_frame.png"}
	}

	parts.image = {
		{id = "default_modechange_frame", src = "src-default_modechange_frame", x = 0, y = 0, w = 150, h = 50},
		-- TODO: 312 表示が反映されない
		-- {id = "default_modechange_sortset",		src = "src-default_modechange_parts", x = 150, y = 0, w = 150, h = 600, divy = 12, len = 12, ref = 312, act = 312, click = 2},
		{id = "default_modechange_sortset",		src = "src-default_modechange_parts", x = 150, y = 0, w = 150, h = 400, divy = 8, len = 8, ref = 12, act = 12, click = 2},
		{id = "default_modechange_lnmodeset",	src = "src-default_modechange_parts", x = 300, y = 0, w = 150, h = 150, divy = 3, len = 3, ref = 308, act = 308, click = 2},
		{id = "default_modechange_rect",		src = "src-default_modechange_parts", x = 300, y = 150, w = 150, h = 50}
	}

	parts.text = {
		{id = "bmz_select_mode", font = "font-default-commonparts-mplus-1c-bold", size = 26, align = 1, overflow = 1},
		{id = "bmz_ln_force_badge", font = "font-default-commonparts-mplus-1c-bold", size = 14, align = 2, constantText = "FORCE"}
	}

	parts.destination = {
		{id = "default_modechange_frame", dst = {{x = parts_position.x, y = parts_position.y, w = 150, h = 50}}},
		{id = "bmz_select_mode", dst = {{x = parts_position.x + 75, y = parts_position.y + 12, w = 150, h = 26}}},
		{id = "default_modechange_sortset",		dst = {{x = parts_position.x + 180, y = parts_position.y, w = 150, h = 50}}},
		{id = "default_modechange_lnmodeset",	dst = {{x = parts_position.x + 360, y = parts_position.y, w = 150, h = 50}}},
		{id = "default_modechange_rect",	act = 11, click = 2, dst = {{x = parts_position.x, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}},
		{id = "default_modechange_rect",		dst = {{x = parts_position.x + 180, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}},
		{id = "default_modechange_rect",		dst = {{x = parts_position.x + 360, y = parts_position.y, w = 150, h = 50}}, mouseRect = {x = 0, y = 0, w = 150, h = 50}},
		{id = "bmz_ln_force_badge", op = {19168}, clickable = false, dst = {{x = parts_position.x + 502, y = parts_position.y + 31, w = 60, h = 14, r = 255, g = 255, b = 255}}}
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}
