local parts = {}

local function load()
	
	local src1_id = "src-default-stateplayoption-parts"
	local parts_position = {x = 462, y = 6}
	
	parts.source = {
		{id = src1_id, path = "customize/advanced/default_stateplayoption/parts.png"},
	}

	parts.image = {
		{id = "default_stateplayoption_bg",	src = src1_id, x = 0, y = 269, w = 996, h = 50},
		{id = "default_stateplayoption_item_name",	src = src1_id, x = 0, y = 190, w = 996, h = 60},
		-- random
		{id = "default_stateplayoption_random_1",	src = src1_id, x = 0, y = 0, w = 166, h = 19},
		{id = "default_stateplayoption_random_2",	src = src1_id, x = 0, y = 19, w = 166, h = 19},
		{id = "default_stateplayoption_random_3",	src = src1_id, x = 0, y = 38, w = 166, h = 19},
		{id = "default_stateplayoption_random_4",	src = src1_id, x = 0, y = 57, w = 166, h = 19},
		{id = "default_stateplayoption_random_5",	src = src1_id, x = 0, y = 76, w = 166, h = 19},
		{id = "default_stateplayoption_random_6",	src = src1_id, x = 0, y = 95, w = 166, h = 19},
		{id = "default_stateplayoption_random_7",	src = src1_id, x = 0, y = 114, w = 166, h = 19},
		{id = "default_stateplayoption_random_8",	src = src1_id, x = 0, y = 133, w = 166, h = 19},
		{id = "default_stateplayoption_random_9",	src = src1_id, x = 0, y = 152, w = 166, h = 19},
		{id = "default_stateplayoption_random_10",	src = src1_id, x = 0, y = 171, w = 166, h = 19},
		
		-- gauge
		{id = "default_stateplayoption_gauge_1",	src = src1_id, x = 166, y = 0, w = 166, h = 19},
		{id = "default_stateplayoption_gauge_2",	src = src1_id, x = 166, y = 19, w = 166, h = 19},
		{id = "default_stateplayoption_gauge_3",	src = src1_id, x = 166, y = 38, w = 166, h = 19},
		{id = "default_stateplayoption_gauge_4",	src = src1_id, x = 166, y = 57, w = 166, h = 19},
		{id = "default_stateplayoption_gauge_5",	src = src1_id, x = 166, y = 76, w = 166, h = 19},
		{id = "default_stateplayoption_gauge_6",	src = src1_id, x = 166, y = 95, w = 166, h = 19},

		-- dp
		{id = "default_stateplayoption_dp_1",		src = src1_id, x = 332, y = 0, w = 166, h = 19},
		{id = "default_stateplayoption_dp_2",		src = src1_id, x = 332, y = 19, w = 166, h = 19},
		{id = "default_stateplayoption_dp_3",		src = src1_id, x = 332, y = 38, w = 166, h = 19},
		{id = "default_stateplayoption_dp_4",		src = src1_id, x = 332, y = 57, w = 166, h = 19},
		
		-- speed
		{id = "default_stateplayoption_speed_1",	src = src1_id, x = 498, y = 0, w = 166, h = 19},
		{id = "default_stateplayoption_speed_2",	src = src1_id, x = 498, y = 19, w = 166, h = 19},
		{id = "default_stateplayoption_speed_3",	src = src1_id, x = 498, y = 38, w = 166, h = 19},
		{id = "default_stateplayoption_speed_4",	src = src1_id, x = 498, y = 57, w = 166, h = 19},
		{id = "default_stateplayoption_speed_5",	src = src1_id, x = 498, y = 76, w = 166, h = 19}
	}

	parts.imageset = {}

	parts.value = {
		--{id = "default_stateplayoption_duration",		src = src1_id, x = 0, y = 250, w = 200, h = 19, align = 2, divx = 10, digit = 4, ref = 312},
		{id = "default_stateplayoption_duration_green",	src = src1_id, x = 0, y = 250, w = 200, h = 19, align = 2, divx = 10, digit = 4, ref = 313}
	}

	parts.text = {
		{id = "bmz_select_arrange", font = "font-default-commonparts-m_select1", size = 18, align = 1, overflow = 1},
		{id = "bmz_select_gauge", font = "font-default-commonparts-m_select1", size = 18, align = 1, overflow = 1},
		{id = "bmz_select_double_option", font = "font-default-commonparts-m_select1", size = 18, align = 1, overflow = 1},
		{id = "bmz_select_hs_fix", font = "font-default-commonparts-m_select1", size = 18, align = 1, overflow = 1},
		{id = "bmz_select_arrange_2p", font = "font-default-commonparts-m_select1", size = 18, align = 1, overflow = 1}
	}

	parts.panel = {
		{id = "bmz_select_option_hit", color = "00000000"}
	}

	parts.destination = {
		{id = "default_stateplayoption_bg",				dst = {{x = parts_position.x, y = parts_position.y, w = 996, h = 50}}},
		{id = "default_stateplayoption_item_name",		dst = {{x = parts_position.x, y = parts_position.y + 23, w = 996, h = 60}}},

		--{id = "default_stateplayoption_duration",		dst = {{x = parts_position.x + 0, y = parts_position.y + 5, w = 20, h = 19}}},
		{id = "default_stateplayoption_duration_green",	dst = {{x = parts_position.x + 873, y = parts_position.y + 5, w = 20, h = 19}}}
	}

	local function append_option(id, act, x, w)
		table.insert(parts.destination, {id = id, dst = {{x = x + w / 2, y = parts_position.y + 5, w = w, h = 19}}})
		table.insert(parts.destination, {id = "bmz_select_option_hit", act = act, dst = {{x = x, y = parts_position.y + 5, w = w, h = 19}}})
	end
	append_option("bmz_select_arrange", 42, parts_position.x, 166)
	append_option("bmz_select_gauge", 40, parts_position.x + 166, 166)
	append_option("bmz_select_double_option", 54, parts_position.x + 332, 166)
	append_option("bmz_select_hs_fix", 55, parts_position.x + 498, 166)
	append_option("bmz_select_arrange_2p", 43, parts_position.x + 664, 166)

	return parts
end

return {
	parts = parts,
	load = load
}
