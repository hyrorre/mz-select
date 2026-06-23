local parts = {}

local function load()

	local pos = {x = 333, y = 198}
	local font1_id = "font-default-commonparts-m_select1"
	local font2_id = "font-default-commonparts-mgenplus-1c-bold"
	
	parts.source = {
		{id = "src-default_rivaldata_rivaldata_bg", path = "customize/advanced/default_rivaldata/rivaldata_bg.png"},
	}
	
	parts.image = {
		{id = "default_rivaldata_rivaldata_bg",	src = "src-default_rivaldata_rivaldata_bg",	x = 0, y = 0, w = -1, h = 120},
		{id = "default_rivaldata_rivaldata_bg_select",	src = "src-default_rivaldata_rivaldata_bg",	x = 0, y = 120, w = 330, h = 50, act = 79, click = 2},
		{id = "default_rivaldata_rivaldata_bg_select_rect",	src = "src-default_rivaldata_rivaldata_bg",	x = 0, y = 254, w = 330, h = 50},
	}
	
	parts.value = {
		{id = "default_rivaldata_score_count",	src = "src-default-commonparts-system", x = 0, y = 817, w = 220, h = 21, divx = 11, digit = 4, ref = 271},
		{id = "default_rivaldata_miss_count",	src = "src-default-commonparts-system", x = 0, y = 817, w = 220, h = 21, divx = 11, digit = 4, value = function()
			local v1 = main_state.number(283)
			local v2 = main_state.number(284)
			if v1 >= 0 and v2 >= 0 then
				return v1 + v2
			else
				return 0
			end
		end},
		{id = "default_rivaldata_diff_score_count",	src = "src-default_rivaldata_rivaldata_bg", x = 0, y = 170, w = 240, h = 42, divx = 12, divy = 2, digit = 5, value = function()
			local v1 = main_state.number(71)
			local v2 = main_state.number(271)
			if v1 < 0 then v1 = 0 end
			if v2 < 0 then v2 = 0 end
			return v1 - v2
		end},
		{id = "default_rivaldata_diff_miss_count",	src = "src-default_rivaldata_rivaldata_bg", x = 0, y = 212, w = 240, h = 42, divx = 12, divy = 2, digit = 5, value = function()
			local v1 = main_state.number(76)
			local v2 = main_state.number(283)
			local v3 = main_state.number(284)
			local v4 = main_state.number(271)
			if v1 < 0 then 
				if v4 <= 0 then
					v1 = 0
				else
					v1 = main_state.number(74)
				end
			end
			if v2 < 0 then v2 = 0 end
			if v3 < 0 then v3 = 0 end
			return v1 - (v2 + v3)
		end}
	}
	
	parts.text = {
		{id = "default_rivaldata_rivalname",	font = font2_id, size = 18, align = 1, ref = 1, overflow = 1},
		{id = "default_rivaldata_rivalselect",	font = font2_id, size = 18, align = 1, constantText = "ライバル選択"},
		{id = "default_rivaldata_rivaldata",	font = font1_id, size = 21, align = 0, constantText = "rival data"},
		{id = "default_rivaldata_win",			font = font1_id, size = 21, align = 0, constantText = "YOU WIN"},
		{id = "default_rivaldata_lose",			font = font1_id, size = 21, align = 0, constantText = "YOU LOSE"},
		{id = "default_rivaldata_draw",			font = font1_id, size = 21, align = 0, constantText = "DRAW"},
		{id = "default_rivaldata_score",		font = font1_id, size = 21, align = 0, constantText = "SCORE"},
		{id = "default_rivaldata_miss",			font = font1_id, size = 21, align = 0, constantText = "MISS"},
	}
	
	parts.destination = {
		{id = "default_rivaldata_rivaldata_bg_select",	op = {51}, dst = {{x = 1485, y = 930, w = 330, h = 50}}},
		{id = "default_rivaldata_rivaldata_bg_select_rect",	op = {51}, dst = {{x = 1485, y = 930, w = 330, h = 50}}, mouseRect = {x = 0, y = 0, w = 330, h = 50}},
		{id = "default_rivaldata_rivalname",			filter = 1, op = {51, 625}, dst = {{x = 1650, y = 946, w = 290, h = 18}}},
		{id = "default_rivaldata_rivalselect",			filter = 1, op = {51, -625}, dst = {{x = 1650, y = 946, w = 290, h = 18}}},
		
		{id = "default_rivaldata_rivaldata_bg",		op = {51, 2},	dst = {{x = pos.x - 9, y = pos.y - 4, w = 337, h = 120}}},
		{id = "default_rivaldata_rivaldata",		op = {51, 2},	dst = {{x = pos.x + 18, y = pos.y + 88, w = 20, h = 21}}},
		{id = "default_rivaldata_win",				op = {625, 2, 352},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, r = 102, g = 102}}},
		{id = "default_rivaldata_lose",				op = {625, 2, 353},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, g = 102, b = 102}}},
		{id = "default_rivaldata_draw",				op = {625, 2, 354},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, r = 102, g = 102, b = 102}}},
		{id = "default_rivaldata_score",			op = {625, 2},	dst = {{x = pos.x + 24, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_miss",				op = {625, 2},	dst = {{x = pos.x + 24, y = pos.y + 8, w = 20, h = 21}}},
		{id = "default_rivaldata_score_count",		op = {625, 2},	dst = {{x = pos.x + 134, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_miss_count",		op = {625, 2},	dst = {{x = pos.x + 134, y = pos.y + 8, w = 20, h = 21}}},
		{id = "default_rivaldata_diff_score_count",	op = {625, 2},	dst = {{x = pos.x + 214, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_diff_miss_count",	op = {625, 2},	dst = {{x = pos.x + 214, y = pos.y + 8, w = 20, h = 21}}},
		--[[
		{id = "default_rivaldata_rivaldata_bg",		op = {625, 3},	dst = {{x = pos.x - 9, y = pos.y - 4, w = 337, h = 120}}},
		{id = "default_rivaldata_rivaldata",		op = {625, 3},	dst = {{x = pos.x + 18, y = pos.y + 88, w = 20, h = 21}}},
		{id = "default_rivaldata_win",				op = {625, 3, 352},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, r = 102, g = 102}}},
		{id = "default_rivaldata_lose",				op = {625, 3, 353},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, g = 102, b = 102}}},
		{id = "default_rivaldata_draw",				op = {625, 3, 354},	dst = {{x = pos.x + 24, y = pos.y + 56, w = 20, h = 21, r = 102, g = 102, b = 102}}},
		{id = "default_rivaldata_score",			op = {625, 3},	dst = {{x = pos.x + 24, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_miss",				op = {625, 3},	dst = {{x = pos.x + 24, y = pos.y + 8, w = 20, h = 21}}},
		{id = "default_rivaldata_score_count",		op = {625, 3},	dst = {{x = pos.x + 134, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_miss_count",		op = {625, 3},	dst = {{x = pos.x + 134, y = pos.y + 8, w = 20, h = 21}}},
		{id = "default_rivaldata_diff_score_count",	op = {625, 3},	dst = {{x = pos.x + 214, y = pos.y + 32, w = 20, h = 21}}},
		{id = "default_rivaldata_diff_miss_count",	op = {625, 3},	dst = {{x = pos.x + 214, y = pos.y + 8, w = 20, h = 21}}}
		--]]
	}
	
	return parts
end

return {
	parts = parts,
	load = load
}