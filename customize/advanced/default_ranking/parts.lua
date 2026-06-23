local parts = {}

local function load()

	parts.source = {
		{id = "src-default_ranking_ranking_bg", path = "customize/advanced/default_ranking/ranking_bg.png"},
		{id = "src-default_ranking_num", path = "customize/advanced/default_ranking/num.png"},
	}
	
	parts.font = {
		{id = "font-default-ranking-ranking",	path = "customize/advanced/default_ranking/fnt/ranking.fnt"},
	}
	
	parts.image = {
		{id = "default_ranking_ranking_bg",	src = "src-default_ranking_ranking_bg",	x = 0, y = 0, w = -1, h = -1},
	}
	
	parts.value = {
		{id = "default_ranking_score_count_1", src = "src-default_ranking_num", x = 0, y = 0, w = 120, h = 16, divx = 10, digit = 4, align = 1, ref = 380},
		{id = "default_ranking_score_count_2", src = "src-default_ranking_num", x = 0, y = 0, w = 120, h = 16, divx = 10, digit = 4, align = 1, ref = 381},
		{id = "default_ranking_score_count_3", src = "src-default_ranking_num", x = 0, y = 0, w = 120, h = 16, divx = 10, digit = 4, align = 1, ref = 382},
		{id = "default_ranking_score_count_4", src = "src-default_ranking_num", x = 0, y = 0, w = 120, h = 16, divx = 10, digit = 4, align = 1, ref = 383},
		{id = "default_ranking_score_count_5", src = "src-default_ranking_num", x = 0, y = 0, w = 120, h = 16, divx = 10, digit = 4, align = 1, ref = 384}
	}
	
	parts.text = {
		{id = "default_ranking_name_1",		font = "font-default-ranking-ranking", size = 14, align = 0, ref = 120, overflow = 1},
		{id = "default_ranking_name_2",		font = "font-default-ranking-ranking", size = 14, align = 0, ref = 121, overflow = 1},
		{id = "default_ranking_name_3",		font = "font-default-ranking-ranking", size = 14, align = 0, ref = 122, overflow = 1},
		{id = "default_ranking_name_4",		font = "font-default-ranking-ranking", size = 14, align = 0, ref = 123, overflow = 1},
		{id = "default_ranking_name_5",		font = "font-default-ranking-ranking", size = 14, align = 0, ref = 124, overflow = 1}
	}
	
	local pos = {x = 333, y = 317}
	local pos2 = {x = 333, y = 197}
	
	parts.destination = {
		{id = "default_ranking_ranking_bg",				op = {51, 2},	dst = {{x = pos.x - 9, y = pos.y - 4, w = 337, h = 153}}},
		{id = "default_ranking_name_1",					op = {51, 2},	dst = {{x = pos.x + 73, y = pos.y + 101, w = 113, h = 14}}},
		{id = "default_ranking_name_2",					op = {51, 2},	dst = {{x = pos.x + 73, y = pos.y + 77, w = 113, h = 14}}},
		{id = "default_ranking_name_3",					op = {51, 2},	dst = {{x = pos.x + 73, y = pos.y + 53, w = 113, h = 14}}},
		{id = "default_ranking_name_4",					op = {51, 2},	dst = {{x = pos.x + 73, y = pos.y + 29, w = 113, h = 14}}},
		{id = "default_ranking_name_5",					op = {51, 2},	dst = {{x = pos.x + 73, y = pos.y + 5, w = 113, h = 14}}},
		{id = "default_ranking_score_count_1",			op = {51, 2},	dst = {{x = pos.x + 193, y = pos.y + 102, w = 12, h = 16}}},
		{id = "default_ranking_score_count_2",			op = {51, 2},	dst = {{x = pos.x + 193, y = pos.y + 78, w = 12, h = 16}}},
		{id = "default_ranking_score_count_3",			op = {51, 2},	dst = {{x = pos.x + 193, y = pos.y + 54, w = 12, h = 16}}},
		{id = "default_ranking_score_count_4",			op = {51, 2},	dst = {{x = pos.x + 193, y = pos.y + 30, w = 12, h = 16}}},
		{id = "default_ranking_score_count_5",			op = {51, 2},	dst = {{x = pos.x + 193, y = pos.y + 6, w = 12, h = 16}}},
		
		---[[
		{id = "default_ranking_ranking_bg",				op = {51, 3},	dst = {{x = pos2.x - 9, y = pos2.y - 4, w = 337, h = 153}}},
		{id = "default_ranking_name_1",					op = {51, 3},	dst = {{x = pos2.x + 73, y = pos2.y + 102, w = 113, h = 12}}},
		{id = "default_ranking_name_2",					op = {51, 3},	dst = {{x = pos2.x + 73, y = pos2.y + 78, w = 113, h = 12}}},
		{id = "default_ranking_name_3",					op = {51, 3},	dst = {{x = pos2.x + 73, y = pos2.y + 54, w = 113, h = 12}}},
		{id = "default_ranking_name_4",					op = {51, 3},	dst = {{x = pos2.x + 73, y = pos2.y + 30, w = 113, h = 12}}},
		{id = "default_ranking_name_5",					op = {51, 3},	dst = {{x = pos2.x + 73, y = pos2.y + 6, w = 113, h = 12}}},
		{id = "default_ranking_score_count_1",			op = {51, 3},	dst = {{x = pos2.x + 193, y = pos2.y + 102, w = 12, h = 16}}},
		{id = "default_ranking_score_count_2",			op = {51, 3},	dst = {{x = pos2.x + 193, y = pos2.y + 78, w = 12, h = 16}}},
		{id = "default_ranking_score_count_3",			op = {51, 3},	dst = {{x = pos2.x + 193, y = pos2.y + 54, w = 12, h = 16}}},
		{id = "default_ranking_score_count_4",			op = {51, 3},	dst = {{x = pos2.x + 193, y = pos2.y + 30, w = 12, h = 16}}},
		{id = "default_ranking_score_count_5",			op = {51, 3},	dst = {{x = pos2.x + 193, y = pos2.y + 6, w = 12, h = 16}}},
		--]]
	}
	
	return parts
end

return {
	parts = parts,
	load = load
}