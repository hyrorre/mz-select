main_state = require("main_state")

function append_all(list, t)
	if t then
		for i, v in pairs(t) do
			table.insert(list, v)
		end
	end
end

local function file_exists(path)
	local status, parts = pcall(function() return loadfile(path) end)
	if status and parts then
		return true
	else
		return false
	end
end

local function isNaN(num)
	return num ~= num
end

local PROPERTY_OP = 899
local function get_property_op()
	PROPERTY_OP = PROPERTY_OP + 1
	return PROPERTY_OP
end
local op = {
	RESULT_L		= get_property_op(),
	RESULT_R		= get_property_op(),
	GRAPH_OFF		= get_property_op(),
	GRAPH_ON		= get_property_op(),
	STAGEFILE_OFF	= get_property_op(),
	STAGEFILE_ON	= get_property_op(),
	SHUTTER_DEF		= get_property_op(),
	SHUTTER_MC		= get_property_op()
}

local property = {
	{name = "リザルトの配置", item = {
		{name = "-", op = op.RESULT_L},				
		--{name = "左", op = op.RESULT_L},				
		--{name = "右", op = op.RESULT_R}
	}},
	--[[
	{name = "ジャッジ・ゲージグラフを表示する", item = {
		{name = "OFF",	op = op.GRAPH_OFF},				
		{name = "ON",	op = op.GRAPH_ON}
	},def = "ON"},
	--]]
	{name = "背景にステージファイルを使用する", item = {
		{name = "OFF",	op = op.STAGEFILE_OFF},
		{name = "ON",	op = op.STAGEFILE_ON}				
	}},
	{name = "使用するシャッターの設定", item = {
		{name = "-",		op = op.SHUTTER_DEF},
		--{name = "m-select",		op = op.SHUTTER_DEF},
		--{name = "ModernChic",	op = op.SHUTTER_MC}				
	}},
}

local filepath = {
	{name = "リザルト背景(CLEAR AAA) resultbg clear AAA",	path = "customize/resultbg/aaa/*.png"},
	{name = "リザルト背景(CLEAR AA) resultbg clear AA",		path = "customize/resultbg/aa/*.png"},
	{name = "リザルト背景(CLEAR A) resultbg clear A",		path = "customize/resultbg/a/*.png"},
	{name = "リザルト背景(CLEAR) resultbg clear",			path = "customize/resultbg/clear/*.png"},
	{name = "リザルト背景(FAILED) resultbg failed",			path = "customize/resultbg/failed/*.png"},
}

local header = {
	type = SKINTYPE,
	name = "m-select-result(lua)",
	w = 1920,
	h = 1080,
	scene = 3600000,
	input = 500,
	fadeout = 500,
	property = property,
	filepath = filepath
}

local function main()

	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end
	
	skin.source = {
		{id = "system",	path = "system.png"},
		{id = "scroll",	path = "scroll.png"},
		{id = "bg_aaa",	path = "customize/resultbg/aaa/*.png"},
		{id = "bg_aa",	path = "customize/resultbg/aa/*.png"},
		{id = "bg_a",	path = "customize/resultbg/a/*.png"},
		{id = "bg_c",	path = "customize/resultbg/clear/*.png"},
		{id = "bg_f",	path = "customize/resultbg/failed/*.png"},
		{id = "shutter",	path = "shutter.png"}
	}
	
	skin.font = {
		{id = 0, path = "font/sub.fnt"},
		{id = 1, path = "font/timing.fnt"},
		{id = 2, path = "font/m_select_system.fnt"},
		{id = 3, path = "font/ranking.fnt"}
	}

	skin.image = {
		{id = "bg_c",		src = "bg_c",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_aaa",		src = "bg_aaa",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_aa",		src = "bg_aa",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_a",		src = "bg_a",	x = 0, y = 0, w = -1, h = -1},
		{id = "bg_f",		src = "bg_f",	x = 0, y = 0, w = -1, h = -1},
		{id = "result_bg",	src = "system", x = 0, y = 0, w = 1024, h = 100},
		{id = "result_i",	src = "system", x = 618, y = 651, w = 406, h = 373},
		{id = "result_i2",	src = "system", x = 626, y = 354, w = 398, h = 259},
		
		{id = "logo_stage",		src = "system", x = 0, y = 100, w = 260, h = 54},
		{id = "logo_course",	src = "system", x = 0, y = 154, w = 260, h = 54},
		{id = "infomation",		src = "system", x = 0, y = 834, w = 385, h = 139},
		
		{id = "win",		src = "system", x = 0, y = 212, w = 75, h = 29},
		{id = "lose",		src = "system", x = 0, y = 241, w = 75, h = 29},
		{id = "draw",		src = "system", x = 0, y = 270, w = 75, h = 29},
		
		{id = "no_ir",		src = "system", x = 104, y = 319, w = 190, h = 21},
		{id = "ir",			src = "system", x = 104, y = 340, w = 180, h = 21},

		{id = "clear",		src = "system", x = 104, y = 361, w = 190, h = 231, divy = 11, len = 11, ref = 370},
		
		{id = "aaa",		src = "system", x = 0, y = 561, w = 84, h = 31},
		{id = "aa",			src = "system", x = 0, y = 530, w = 84, h = 31},
		{id = "a",			src = "system", x = 0, y = 499, w = 84, h = 31},
		{id = "b",			src = "system", x = 0, y = 468, w = 84, h = 31},
		{id = "c",			src = "system", x = 0, y = 437, w = 84, h = 31},
		{id = "d",			src = "system", x = 0, y = 406, w = 84, h = 31},
		{id = "e",			src = "system", x = 0, y = 375, w = 84, h = 31},
		{id = "f",			src = "system", x = 0, y = 344, w = 84, h = 31},
		
		{id = "unknown",	src = "system", x = 84, y = 466, w = 20, h = 21},
		{id = "beginner",	src = "system", x = 84, y = 487, w = 20, h = 21},
		{id = "normal",		src = "system", x = 84, y = 508, w = 20, h = 21},
		{id = "hyper",		src = "system", x = 84, y = 529, w = 20, h = 21},
		{id = "another",	src = "system", x = 84, y = 550, w = 20, h = 21},
		{id = "insane",		src = "system", x = 84, y = 571, w = 20, h = 21},
		
		{id = "graph_r",	src = "system", x = 84, y = 453, w = 13, h = 13},
		{id = "graph_b",	src = "system", x = 84, y = 427, w = 13, h = 13},
		{id = "graph_y",	src = "system", x = 84, y = 440, w = 13, h = 13},
		
		{id = "replay_1",	src = "system", x = 308, y = 562, w = 28, h = 31, act = 19},
		{id = "replay_2",	src = "system", x = 308, y = 593, w = 28, h = 31, act = 316},
		{id = "replay_3",	src = "system", x = 308, y = 624, w = 28, h = 31, act = 317},
		{id = "replay_4",	src = "system", x = 308, y = 655, w = 28, h = 31, act = 318},
		
		{id = "shutter", src = "shutter", x = 0, y = 0, w = 2560, h = 1080},
	}
	
	-- クリア更新表記
	local clear = {
		current	= main_state.number(370),
		best	= main_state.number(371),
		pos		= 0
	}
	do
		-- print(clear.current .. " - " .. clear.best)
		if header.type == 7 then
			if clear.current > clear.best then
				table.insert(skin.image, {id = "clear_state", src = "system", x = 0, y = 813, w = 25, h = 21})
			elseif clear.current == clear.best then
				table.insert(skin.image, {id = "clear_state", src = "system", x = 50, y = 813, w = 25, h = 21})
			elseif clear.current < clear.best then
				table.insert(skin.image, {id = "clear_state", src = "system", x = 25, y = 813, w = 25, h = 21})
			end
		else -- TODO: コースリザルト時ベストランプがおかしい
			table.insert(skin.image, {id = "clear_state", src = "system", x = 75, y = 813, w = 25, h = 21})
		end
		
		-- 座標調整
		if		clear.current == 0	then clear.pos = 27
		elseif	clear.current == 1	then clear.pos = 31
		elseif	clear.current == 2	then clear.pos = 31
		elseif	clear.current == 3	then clear.pos = 13
		elseif	clear.current == 4	then clear.pos = 49
		elseif	clear.current == 5	then clear.pos = 40
		elseif	clear.current == 6	then clear.pos = 49
		elseif	clear.current == 7	then clear.pos = 22
		elseif	clear.current == 8	then clear.pos = 0
		elseif	clear.current == 9	then clear.pos = 22
		elseif	clear.current == 10	then clear.pos = 58
		end
	end
	
	skin.value = {
		{id = "ir_rank",	src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 5, ref = 179},
		{id = "ir_total",	src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 5, ref = 180},
		
		{id = "rate",		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, ref = 102},
		{id = "rate_ad",	src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 2, ref = 103},
		--{id = "rate_best",		src = "system", x = 0, y = 623, w = 220, h = 21, divx = 11, digit = 3, ref = 183},
		--{id = "rate_ad_best",	src = "system", x = 0, y = 623, w = 220, h = 21, divx = 11, digit = 2, ref = 184},
		{id = "level",		src = "system", x = 0, y = 623, w = 220, h = 21, divx = 11, digit = 2, ref = 96},		

		{id = "score",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 71},
		{id = "diffscore",	src = "system", x = 0, y = 745, w = 180, h = 34, divx = 12, divy = 2, digit = 5, ref = 152},
		{id = "target",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 121},
		{id = "difftarget",	src = "system", x = 0, y = 745, w = 180, h = 34, divx = 12, divy = 2, digit = 5, align = 2, ref = 153},
		{id = "combo",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 75},
		{id = "diffcombo",	src = "system", x = 0, y = 745, w = 180, h = 34, divx = 12, divy = 2, digit = 5, ref = 175},
		{id = "miss",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 76},
		{id = "diffmiss",	src = "system", x = 0, y = 779, w = 180, h = 34, divx = 12, divy = 2, digit = 5, ref = 178},

		{id = "pg_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 110},
		{id = "gr_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 111},
		{id = "gd_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 112},
		{id = "bd_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 113},
		{id = "pr_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 114},
		{id = "ms_t",		src = "system", x = 0, y = 623, w = 209, h = 21, divx = 11, digit = 4, ref = 420},
		
		{id = "fast_t",		src = "system", x = 0, y = 745, w = 165, h = 17, divx = 11, digit = 4, ref = 423},
		{id = "slow_t",		src = "system", x = 0, y = 762, w = 165, h = 17, divx = 11, digit = 4, ref = 424},
	}
	
	skin.text = {}
	do
		local ave_timing	= main_state.number(374) + (main_state.number(375) * 0.01)
		local tmg_str		= nil
		if ave_timing < 0 then
			ave_timing = ave_timing * -1
			tmg_str = "平均" .. ave_timing .. "ms遅い"
		else
			tmg_str = "平均" .. ave_timing .. "ms速い"
		end
		
		-- コースリザルト時タイミング表示できないため
		if header.type == 15 then tmg_str = " " end
		
		local title_str = main_state.text(1002) .. " " .. main_state.text(1001)
		if title_str then title_str = title_str .. " " end
		title_str = title_str .. main_state.text(12)
		table.insert(skin.text, {id = "timing",	font = 1, size = 14, constantText = tmg_str})
		table.insert(skin.text, {id = "title",	font = 0, size = 24, align = 1, constantText = title_str})
		table.insert(skin.text, {id = "arrange_f_random", font = 2, size = 18, align = 0, constantText = "F-RANDOM"})
		table.insert(skin.text, {id = "arrange_mf_random", font = 2, size = 18, align = 0, constantText = "MF-RANDOM"})
		table.insert(skin.text, {id = "arrange_f_random_2p", font = 2, size = 18, align = 0, constantText = "2P F-RANDOM"})
		table.insert(skin.text, {id = "arrange_mf_random_2p", font = 2, size = 18, align = 0, constantText = "2P MF-RANDOM"})
	end
	
	skin.slider = {}
	
	if header.type == 7 then
		skin.gaugegraph = {{
			id = "gaugegraph",
			assistClearBGColor = "000000";
			assistAndEasyFailBGColor = "000000";
			grooveFailBGColor = "000000";
			grooveClearAndHardBGColor = "000000";
			exHardBGColor = "000000";
			hazardBGColor = "000000";
			assistClearLineColor = "ff00ff";
			assistAndEasyFailLineColor = "00ffff";
			grooveFailLineColor = "00ff00";
			grooveClearAndHardLineColor = "ff0000";
			exHardLineColor = "ffff00";
			hazardLineColor = "cccccc";
			borderlineColor = "ff0000";
			borderColor = "000000";	
		}}
	else
		skin.gaugegraph = {
			{id = "gaugegraph"}
		}
	end
	
	skin.judgegraph = {
		{id = "judgegraph_n", type = 0},
		{id = "judgegraph_j", type = 1},
		{id = "judgegraph_el", type = 2}
	}
	skin.bpmgraph = {
		{id = "bpmgraph"}
	}
	skin.timingdistributiongraph = {
		{
			id = "timingdistributiongraph",
			averageColor = "ffffff88",
			devColor = "ffffff88",
			averageColor = "ffffff88",
			GDColor = "00000088",
			BDColor = "00000088",
			PRColor = "00000088"
		}
	}
	--]]
	
	local result_origin = {24, 24}
	if skin_config.option["リザルトの配置"] == op.RESULT_R then result_origin[1] = 1490 end
	
	local pos = {
		info		= {30,									855},
		logo		= {20,									1000},
		time		= {290,									1006},
		tgt			= {result_origin[1] + 102,				result_origin[2] + 244},
		replay_1	= {result_origin[1] + 13 + 187,			result_origin[2] + 266},
		replay_2	= {result_origin[1] + 53 + 187,			result_origin[2] + 266},
		replay_3	= {result_origin[1] + 93 + 187,			result_origin[2] + 266},
		replay_4	= {result_origin[1] + 133 + 187,		result_origin[2] + 266},
		ir			= {result_origin[1] + 105 - 92,			result_origin[2] + 316},
		ir_rank		= {result_origin[1] + 105 - 36,			result_origin[2] + 316},
		ir_total	= {result_origin[1] + 189,				result_origin[2] + 316},
		rate		= {result_origin[1] + 13,				result_origin[2] + 244},
		rate_ad		= {result_origin[1] + 13 + 52,			result_origin[2] + 244},
		clear		= {result_origin[1] + 13,				result_origin[2] + 220},
		clear_state	= {result_origin[1] - 12 + clear.pos,	result_origin[2] + 220},
		rank		= {result_origin[1] + 13,				result_origin[2] + 266},
		diff		= {result_origin[1] + 333,				result_origin[2] + 281},
		level		= {result_origin[1] + 353,				result_origin[2] + 281},
		score		= {result_origin[1] + 309,				result_origin[2] + 220},
		diffscore	= {result_origin[1] + 309,				result_origin[2] + 220 + 21},
		combo		= {result_origin[1] + 309,				result_origin[2] + 175},
		diffcombo	= {result_origin[1] + 309,				result_origin[2] + 175 + 21},
		miss		= {result_origin[1] + 105,				result_origin[2] + 175},
		diffmiss	= {result_origin[1] + 105,				result_origin[2] + 175 + 21},
		fast		= {result_origin[1] + 315,				result_origin[2] + 36},
		slow		= {result_origin[1] + 195,				result_origin[2] + 36},
		timing		= {result_origin[1] + 270,				result_origin[2] + 135}
	}
		
	local jg_pos = {x = result_origin[1] + 69, y = {}}
	jg_pos.y[1] = result_origin[2] + 133
	for i = 2, 6, 1 do
		jg_pos.y[i] = jg_pos.y[i - 1] - 24
	end
	
	
	local graph_l = {}
	local graph_max = 0
	local notes_t = main_state.number(74)
	local num = {422, 419, 417, 415, 413, 411, 410, 412, 414, 416, 418, 421}
	for i, v in ipairs(num) do
		graph_l[i] = main_state.number(v) / notes_t * 100
		if graph_max < graph_l[i] then graph_max = graph_l[i] end
	end
	for i, v in ipairs(graph_l) do
		graph_l[i] = v / graph_max * 100
	end
	local graph_pos = {x = {}, y = result_origin[2] + 31}
	graph_pos.x[1] = result_origin[1] + 185
	for i = 2, 12, 1 do
		graph_pos.x[i] = graph_pos.x[i - 1] + 17
	end
	
	local dt = {0, 500, 1000, 1300}
	
	skin.destination = {
	
		{id = "bg_c",	filter = 1, stretch = 3, op = {90},							dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_aaa",	filter = 1, stretch = 3, op = {90,300},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_aa",	filter = 1, stretch = 3, op = {90,301},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = "bg_a",	filter = 1, stretch = 3, op = {90,302},						dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		{id = -110,								 op = {90, op.STAGEFILE_ON, 191},	dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- CLEAR
		{id = -100,		filter = 1, stretch = 3, op = {90, op.STAGEFILE_ON},		dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- CLEAR
		{id = "bg_f",	filter = 1, stretch = 3, op = {91},							dst = {{x = 0, y = 0, w = 1920, h = 1080}}},-- BG
		
		{id = "result_bg", loop = dt[2], op = {op.RESULT_L}, dst = {{time = dt[1], x = -1920, y = result_origin[2] - 6, w = 1920, h = 362, acc = 2, a = 255},{time = dt[2], x = 0, a = 255}}},
		{id = "result_bg", loop = dt[2], op = {op.RESULT_R}, dst = {{time = dt[1], x = 2432, y = result_origin[2] - 6, w = -1920, h = 362, acc = 2, a = 255},{time = dt[2], x = 1920, a = 255}}},
		{id = "result_i", loop = dt[2],	dst = {{time = dt[1], x = result_origin[1] - 12, y = result_origin[2] - 12, w = 430, h = 397, acc = 2, a = 0},{time = dt[2], x = result_origin[1], y = result_origin[2], w = 406, h = 373, a = 255}}},
		
		{id = "no_ir",		loop = dt[3],	op = {50},	dst = {{time = dt[1], x = pos.ir[1],		y = pos.ir[2],			w = 190, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "ir",			loop = dt[3],	op = {51},	dst = {{time = dt[1], x = pos.ir[1],		y = pos.ir[2],			w = 180, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "ir_rank",	loop = dt[3],	op = {51},	dst = {{time = dt[1], x = pos.ir_rank[1],	y = pos.ir_rank[2],		w = 20, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "ir_total",	loop = dt[3],	op = {51},	dst = {{time = dt[1], x = pos.ir_total[1],	y = pos.ir_total[2],	w = 20, h = 21, a = 0},{time = dt[3], a = 255}}},
		
		{id = "rate",			loop = dt[3],	dst = {{time = dt[1], x = pos.rate[1],			y = pos.rate[2],		w = 15, h = 17, a = 0},{time = dt[3], a = 255}}},
		{id = "rate_ad",		loop = dt[3],	dst = {{time = dt[1], x = pos.rate_ad[1],		y = pos.rate_ad[2],		w = 15, h = 17, a = 0},{time = dt[3], a = 255}}},
		{id = "clear",			loop = dt[3],	dst = {{time = dt[1], x = pos.clear[1],			y = pos.clear[2],		w = 190, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "clear_state",	loop = dt[3],	dst = {{time = dt[1], x = pos.clear_state[1],	y = pos.clear_state[2],	w = 25, h = 21, a = 128},{time = dt[3], a = 255}}},
		
		{id = "aaa",	loop = dt[3], op = {300}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "aa",		loop = dt[3], op = {301}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "a",		loop = dt[3], op = {302}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "b",		loop = dt[3], op = {303}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "c",		loop = dt[3], op = {304}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "d",		loop = dt[3], op = {305}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "e",		loop = dt[3], op = {306}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		{id = "f",		loop = dt[3], op = {307}, dst = {{time = dt[1], x = pos.rank[1], y = pos.rank[2],	w = 84, h = 31, a = 0},{time = dt[3], a = 255}}},
		
		---
		{id = "score",		loop = dt[3], dst = {{time = dt[1], x = pos.score[1],		y = pos.score[2],		w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "diffscore",	loop = dt[3], dst = {{time = dt[1], x = pos.diffscore[1],	y = pos.diffscore[2],	w = 15, h = 17, a = 0},{time = dt[3], a = 255}}},
		{id = "combo",		loop = dt[3], dst = {{time = dt[1], x = pos.combo[1],		y = pos.combo[2],		w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "diffcombo",	loop = dt[3], dst = {{time = dt[1], x = pos.diffcombo[1],	y = pos.diffcombo[2],	w = 15, h = 17, a = 0},{time = dt[3], a = 255}}},
		{id = "miss",		loop = dt[3], dst = {{time = dt[1], x = pos.miss[1],		y = pos.miss[2],		w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "diffmiss",	loop = dt[3], dst = {{time = dt[1], x = pos.diffmiss[1],	y = pos.diffmiss[2],	w = 15, h = 17, a = 0},{time = dt[3], a = 255}}},

		{id = "pg_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[1], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "gr_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[2], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "gd_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[3], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "bd_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[4], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "pr_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[5], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		{id = "ms_t", loop = dt[3], dst = {{time = dt[1], x = jg_pos.x, y = jg_pos.y[6], w = 19, h = 21, a = 0},{time = dt[3], a = 255}}},
		
		{id = "timing", loop = dt[3], dst = {{time = dt[2], x = pos.timing[1] + 12, y = pos.timing[2], w = 14, h = 14, r = 255, g = 255, b = 255, a = 0},{time = dt[3], x = pos.timing[1], a = 255}}},
		
		{id = "graph_r", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[1],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[1]}}},
		{id = "graph_r", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[2],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[2]}}},
		{id = "graph_r", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[3],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[3]}}},
		{id = "graph_r", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[4],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[4]}}},
		{id = "graph_y", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[5],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[5]}}},
		{id = "graph_y", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[6],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[6]}}},
		{id = "graph_y", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[7],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[7]}}},
		{id = "graph_y", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[8],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[8]}}},
		{id = "graph_b", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[9],  y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[9]}}},
		{id = "graph_b", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[10], y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[10]}}},
		{id = "graph_b", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[11], y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[11]}}},
		{id = "graph_b", loop = dt[4], dst = {{time = dt[1], x = graph_pos.x[12], y = graph_pos.y, w = 13, h = 0, a = 0, acc = 2},{time = dt[3], a = 255},{time = dt[4], h = graph_l[12]}}},
		
		{id = "fast_t", loop = dt[3], dst = {{time = dt[1], x = pos.fast[1], y = pos.fast[2], w = 15, h = 17, a = 0},{time = dt[3], a = 128}}},
		{id = "slow_t", loop = dt[3], dst = {{time = dt[1], x = pos.slow[1], y = pos.slow[2], w = 15, h = 17, a = 0},{time = dt[3], a = 128}}},

		--[[
		{id = "judgegraph_n",	op = {op.GRAPH_ON},	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}},
		{id = "bpmgraph",		op = {op.GRAPH_ON},	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}},
		{id = "judgegraph_el",	op = {op.GRAPH_ON}, loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}},
		{id = "gaugegraph",		op = {op.GRAPH_ON}, loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}},
		{id = "judgegraph_j",	op = {op.GRAPH_ON},	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}},
		{id = "gaugegraph",		op = {op.GRAPH_ON}, loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}},
		{id = "result_i2",		op = {op.GRAPH_ON}, loop = dt[2],				dst = {{time = dt[1], x = 460 - 12, y = result_origin[2] + 78 - 12, w = 422, h = 283, acc = 2, a = 0},{time = dt[2], x = 460, y = result_origin[2] + 78, w = 398, h = 259, a = 128}}},
		--]]
		
		--{id = -110,		dst = {{x = 0, y = 18, w = 1920, h = 36, a = 127}}},

		{id = "replay_1", op = {196, -198},			dst = {{			x = pos.replay_1[1], y = pos.replay_1[2], w = 28, h = 31, a = 64}}},
		{id = "replay_1", op = {197, -198},			dst = {{			x = pos.replay_1[1], y = pos.replay_1[2], w = 28, h = 31}}},
		{id = "replay_1", op = {198}, loop = 0,		dst = {{time = 0,	x = pos.replay_1[1], y = pos.replay_1[2], w = 28, h = 31},{time = 500, a = 0},{time = 1000, a = 255}}},
		{id = "replay_2", op = {1196, -1198},		dst = {{			x = pos.replay_2[1], y = pos.replay_2[2], w = 28, h = 31, a = 64}}},
		{id = "replay_2", op = {1197, -1198},		dst = {{			x = pos.replay_2[1], y = pos.replay_2[2], w = 28, h = 31}}},
		{id = "replay_2", op = {1198}, loop = 0,	dst = {{time = 0,	x = pos.replay_2[1], y = pos.replay_2[2], w = 28, h = 31},{time = 500, a = 0},{time = 1000, a = 255}}},
		{id = "replay_3", op = {1199, -1201},		dst = {{			x = pos.replay_3[1], y = pos.replay_3[2], w = 28, h = 31, a = 64}}},
		{id = "replay_3", op = {1200, -1201},		dst = {{			x = pos.replay_3[1], y = pos.replay_3[2], w = 28, h = 31}}},
		{id = "replay_3", op = {1201}, loop = 0,	dst = {{time = 0,	x = pos.replay_3[1], y = pos.replay_3[2], w = 28, h = 31},{time = 500, a = 0},{time = 1000, a = 255}}},
		{id = "replay_4", op = {1202, -1204},		dst = {{			x = pos.replay_4[1], y = pos.replay_4[2], w = 28, h = 31, a = 64}}},
		{id = "replay_4", op = {1203, -1204},		dst = {{			x = pos.replay_4[1], y = pos.replay_4[2], w = 28, h = 31}}},
		{id = "replay_4", op = {1204}, loop = 0,	dst = {{time = 0,	x = pos.replay_4[1], y = pos.replay_4[2], w = 28, h = 31},{time = 500, a = 0},{time = 1000, a = 255}}},

		{id = "title", dst = {{x = 960, y = 1012, w = 24, h = 24}}},
	}
	
	-- グラフの表示
	if header.type == 7 then -- 通常リザルト
		table.insert(skin.destination, {id = "judgegraph_n",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
		table.insert(skin.destination, {id = "bpmgraph",		loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
		table.insert(skin.destination, {id = "judgegraph_el",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
		table.insert(skin.destination, {id = "gaugegraph",		loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}})
		table.insert(skin.destination, {id = "judgegraph_j",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
		table.insert(skin.destination, {id = "gaugegraph",		loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}})
		table.insert(skin.destination, {id = "result_i2",		loop = dt[2],				dst = {{time = dt[1], x = 460 - 12, y = result_origin[2] + 78 - 12, w = 422, h = 283, acc = 2, a = 0},{time = dt[2], x = 460, y = result_origin[2] + 78, w = 398, h = 259, a = 128}}})
	else -- コースリザルト
		table.insert(skin.destination, {id = "gaugegraph",		loop = dt[2], dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 340, a = 0},{time = dt[2], a = 192}}})
	end
	
	-- 左上の表示
	do
		-- ロゴの表示
		if header.type == 7 then
			table.insert(skin.destination, {id = "logo_stage",	loop = dt[3], dst = {{time = dt[1], x = pos.logo[1], y = pos.logo[2], w = 260, h = 54, a = 0},{time = dt[3], a = 255}}})
		else	
			table.insert(skin.destination, {id = "logo_course", loop = dt[3], dst = {{time = dt[1], x = pos.logo[1], y = pos.logo[2], w = 260, h = 54, a = 0},{time = dt[3], a = 255}}})
		end
		-- 時刻の表示
		--table.insert(skin.text, {id = "timestamp", font = 3, size = 18, constantText = os.date()})
		--table.insert(skin.destination, {id = "timestamp", loop = dt[3], dst = {{time = dt[1], x = pos.time[1], y = pos.time[2], w = 18, h = 18, a = 0},{time = dt[3], a = 255}}})
		table.insert(skin.text, {id = "timestamp", font = 3, size = 18,align = 1, constantText = os.date()})
		table.insert(skin.destination, {id = "timestamp", loop = dt[3], dst = {{time = dt[1], x = 960, y = 1044, w = 18, h = 18, a = 0},{time = dt[3], a = 255}}})
		-- infomationの表示
		local playmode = {
			keys_7	= main_state.option(160),
			keys_5	= main_state.option(161),
			keys_14	= main_state.option(162),
			keys_10	= main_state.option(163),
			keys_9	= main_state.option(164),
			keys_24	= main_state.option(1160),
			keys_48	= main_state.option(1161)
		}
		-- TODO: 5鍵/10鍵プレイ時67が反応しないので非表示中
		if playmode.keys_5 or playmode.keys_10 then
			-- 何もしない
		else
			table.insert(skin.destination, {id = "infomation", loop = dt[3], dst = {{time = dt[1], x = pos.info[1], y = pos.info[2], w = 385, h = 139, a = 0},{time = dt[3], a = 255}}})
		end
		if header.type == 7 then
			-- ref 42 では F/MF-RANDOM が RANDOM と同じ index のため、拡張 ref 344 で区別する。
			table.insert(skin.destination, {id = "arrange_f_random", draw = function() return main_state.event_index(344) == 10 end, loop = dt[3], dst = {{time = dt[1], x = pos.info[1], y = pos.info[2] - 20, w = 180, h = 18, a = 0},{time = dt[3], a = 255}}})
			table.insert(skin.destination, {id = "arrange_mf_random", draw = function() return main_state.event_index(344) == 11 end, loop = dt[3], dst = {{time = dt[1], x = pos.info[1], y = pos.info[2] - 20, w = 180, h = 18, a = 0},{time = dt[3], a = 255}}})
			table.insert(skin.destination, {id = "arrange_f_random_2p", draw = function() return main_state.event_index(345) == 10 end, loop = dt[3], dst = {{time = dt[1], x = pos.info[1], y = pos.info[2] - 40, w = 220, h = 18, a = 0},{time = dt[3], a = 255}}})
			table.insert(skin.destination, {id = "arrange_mf_random_2p", draw = function() return main_state.event_index(345) == 11 end, loop = dt[3], dst = {{time = dt[1], x = pos.info[1], y = pos.info[2] - 40, w = 220, h = 18, a = 0},{time = dt[3], a = 255}}})
		end
	end
	
	-- ターゲット表示
	-- TODO: コースリザルト時ターゲットスコアを取得できない
	if header.type == 7 then
		local diff_target_score = main_state.number(153)
		-- TODO: refで指定するとユーザー名が表示されない
		-- local target_name = "TARGET: " .. main_state.text(1)
		-- table.insert(skin.text, {id = "targetname",	font = 3, size = 18, constantText = target_name})
		table.insert(skin.destination, {id = "difftarget",	loop = dt[4], dst = {{time = dt[1], x = pos.tgt[1], y = pos.tgt[2] - 5, w = 15, h = 17, a = 0, acc = 2},{time = dt[2]},{time = dt[4], y = pos.tgt[2], a = 255}}})
		-- table.insert(skin.destination, {id = "targetname",	loop = dt[3], dst = {{time = dt[1], x = pos.tgt[1], y = pos.tgt[2] + 32, w = 18, h = 18, a = 0, acc = 2},{time = dt[2]},{time = dt[3], a = 255}}})
		if diff_target_score > 0 then
			table.insert(skin.destination, {id = "win",		loop = dt[4], dst = {{time = dt[1], x = pos.tgt[1], y = pos.tgt[2] + 12, w = 75, h = 29, a = 0, acc = 2},{time = dt[2]},{time = dt[4], y = pos.tgt[2] + 20, a = 255}}})
		elseif diff_target_score == 0 then
			table.insert(skin.destination, {id = "draw",	loop = dt[4], dst = {{time = dt[1], x = pos.tgt[1], y = pos.tgt[2] + 12, w = 75, h = 29, a = 0, acc = 2},{time = dt[2]},{time = dt[4], y = pos.tgt[2] + 20, a = 255}}})
		elseif diff_target_score < 0 then
			table.insert(skin.destination, {id = "lose",	loop = dt[4], dst = {{time = dt[1], x = pos.tgt[1], y = pos.tgt[2] + 12, w = 75, h = 29, a = 0, acc = 2},{time = dt[2]},{time = dt[4], y = pos.tgt[2] + 20, a = 255}}})
		end
	end
	
	---[[
	if main_state.option(51) then -- <IR関連ここから>
	
		local ir = {}
		
		ir.image		= {}
		ir.text			= {}
		ir.value		= {}
		ir.slider		= {}
		ir.destination	= {}
		ir.pos			= {}
		
		-- 全体の座標
		ir.pos.x = 1490 + 24
		if skin_config.option["リザルトの配置"] == op.RESULT_R then ir.pos.x = 48 end
		ir.pos.y = result_origin[2]
		
		-- 各要素のx座標
		ir.pos.rank_x	= ir.pos.x
		ir.pos.score_x	= ir.pos.x + 105
		ir.pos.name_x	= ir.pos.x + 190
		ir.pos.scroll_x	= ir.pos.x - 24
		
		-- 各要素のy座標調整用
		ir.pos.rank_offset_y	= 2
		ir.pos.score_offset_y	= 2
		ir.pos.name_offset_y	= 0
		
		-- 行の高さ
		ir.pos.line_h = 30
		
		-- slider	type	8			ランキングスクロールバー
		-- value	ref		390 ~ 399	順位
		-- value	ref		380 ~ 389	EXスコア
		-- text		ref		120 ~ 129	名前
		do
			local v = ir.pos.y + (ir.pos.line_h * 10)
			table.insert(ir.image, {id = "ir_scrollbar",			src = "scroll", x = 0, y = 0, w = 16, h = 287})
			table.insert(ir.slider, {id = "ir_scroll",				src = "scroll", x = 16, y = 0, w = 64, h = 64, type = 8, range = 225, angle = 2, changeable = false})
			table.insert(ir.slider, {id = "ir_scroll_collision",	src = "scroll", x = 80, y = 0, w = 64, h = 64, type = 8, range = 247, angle = 2, changeable = true})
			table.insert(ir.destination, {id = "ir_scrollbar",						dst = {{x = ir.pos.scroll_x, y = ir.pos.y + 428 - 396, w = 16, h = 287}}})
			table.insert(ir.destination, {id = "ir_scroll", loop = 0, blend = 2,	dst = {{time = 0, x = ir.pos.scroll_x - 24, y = ir.pos.y + 652 - 396, w = 64, h = 64, a = 255}, {time = 200, a = 162}}})
			table.insert(ir.destination, {id = "ir_scroll_collision",				dst = {{x = ir.pos.scroll_x - 24, y = ir.pos.y + 695 - 396, w = 64, h = 64}}})
			for i = 1, 10 do
				table.insert(ir.value,	{id = "ir_rank" .. i,	src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 5, ref = 389 + i})
				table.insert(ir.value,	{id = "ir_score" .. i,	src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 4, ref = 379 + i})
				table.insert(ir.text,	{id = "ir_name" .. i,	font = 3, size = 18, align = 0, overflow = 1, ref = 119 + i})
				table.insert(ir.destination, {id = "ir_rank" .. i,	dst = {{x = ir.pos.rank_x,	y = v + ir.pos.rank_offset_y,	w = 15, h = 17}}})
				table.insert(ir.destination, {id = "ir_score" .. i,	dst = {{x = ir.pos.score_x,	y = v + ir.pos.score_offset_y,	w = 15, h = 17}}})
				table.insert(ir.destination, {id = "ir_name" .. i,	dst = {{x = ir.pos.name_x,	y = v + ir.pos.name_offset_y,	w = 180, h = 18}}})
				v = v - ir.pos.line_h
			end
		end
		
		-- スキンに追加する
		append_all(skin.image, ir.image)
		append_all(skin.value, ir.value)
		append_all(skin.text, ir.text)
		append_all(skin.slider, ir.slider)
		append_all(skin.destination, ir.destination)
		
	end -- <IR関連ここまで>
	--]]
	
	if header.type == 7 then -- <打鍵詳細ここから>
		
		-- ランダムパターン表示条件
		local function isDisplayRandomPattern()
			local index = main_state.event_index(42)
			if index == 2 or index == 3 or index == 8 then
				return true
			end
			return false
		end
		
		local function add_default_graph()
			table.insert(skin.destination, {id = "judgegraph_n",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
			table.insert(skin.destination, {id = "bpmgraph",		loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 240, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
			table.insert(skin.destination, {id = "judgegraph_el",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
			table.insert(skin.destination, {id = "gaugegraph",		loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2] + 120, w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}})
			table.insert(skin.destination, {id = "judgegraph_j",	loop = dt[2],				dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 192}}})
			table.insert(skin.destination, {id = "gaugegraph",		loop = dt[2], blend = 2,	dst = {{time = dt[1], x = 454, y = result_origin[2], w = 1012, h = 100, a = 0},{time = dt[2], a = 255}}})
			table.insert(skin.destination, {id = "result_i2",		loop = dt[2],				dst = {{time = dt[1], x = 460 - 12, y = result_origin[2] + 78 - 12, w = 422, h = 283, acc = 2, a = 0},{time = dt[2], x = 460, y = result_origin[2] + 78, w = 398, h = 259, a = 128}}})
		end
	
		local path_log = {
			hub			= "skin/Hub/extension/log/log.lua",
			m_select	= "skin/m_select/play/antique/system/ex/log/log.lua",
			del			= ""
		}
		local play_log = nil
		-- TODO: antiqueログ読込暫定対応 hubを経由せず他スキンで使いたいときどうするか
		if file_exists(path_log.hub) then play_log, path_log.del = dofile(path_log.hub), path_log.hub end
		if not play_log or type(play_log) ~= "table" then
			if file_exists(path_log.m_select) then play_log, path_log.del = dofile(path_log.m_select), path_log.m_select end
		end
		if play_log and type(play_log) == "table" then
		
			local adjust_timing	= 0
			for i = 1, #play_log.section_timing do
				adjust_timing = adjust_timing + play_log.section_timing[i]
			end
			adjust_timing = math.floor(adjust_timing / #play_log.section_timing)
			local adjust_str_ave = "平均" .. adjust_timing .. "ms"
			table.insert(skin.text, {id = "adjust-ave", font = 1, size = 14, constantText = adjust_str_ave})
			
			local function add_1p(pos)
				table.insert(skin.source, {id = "keys1", path = "keys1p.png"})
				table.insert(skin.image, {id = "exkeys1", src = "keys1", x = 0, y = 0, w = 745, h = -1})
				table.insert(skin.value, {id = "exinput1", src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 4, value = function() return play_log.input_total end})
				table.insert(skin.value, {id = "exnotes1", src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 4, ref = 74})
				table.insert(skin.destination, {id = "exkeys1", dst = {{x = pos[1], y = pos[2], w = 745, h = 210}}})
				table.insert(skin.destination, {id = "exinput1", dst = {{x = pos[1] + 55, y = pos[2] + 108, w = 15, h = 17}}})
				table.insert(skin.destination, {id = "exnotes1", dst = {{x = pos[1] + 55, y = pos[2] + 88, w = 15, h = 17}}})
				for i = 1, 10 do
					local total = play_log.just[i] + play_log.fast[i] + play_log.slow[i] + play_log.blank[i]
					if total ~= 0 then
						local graph = {}
						graph.just_rate = play_log.just[i] / (play_log.just[i] + play_log.fast[i] + play_log.slow[i]) * 100
						graph.total = play_log.fast[i] + play_log.slow[i]
						graph.fast = play_log.fast[i] / graph.total * 100
						graph.slow = play_log.slow[i] / graph.total * 100
						local random1p = 448 + i
						if i == 1 then random1p = 459 end
						table.insert(skin.destination, {id = "graph_r", loop = 1300, dst = {{time = 0, x = pos[1] + 118 + ((i - 1) * 63) + 5, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.slow}}})
						table.insert(skin.destination, {id = "graph_b", loop = 1300, dst = {{time = 0, x = pos[1] + 118 + ((i - 1) * 63) + 25, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.fast}}})
						table.insert(skin.value, {id = "exjustrate1" .. i,	src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return graph.just_rate end})
						-- ランダムパターン 450~469: SkinPropertyではNUMBERになっているが実際はVALUE
						table.insert(skin.value, {id = "random1" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 1, value = function() return main_state.event_index(random1p) end})
						table.insert(skin.value, {id = "exjust1" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.just[i] end})
						table.insert(skin.value, {id = "exfast1" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.fast[i] end})
						table.insert(skin.value, {id = "exslow1" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.slow[i] end})
						table.insert(skin.value, {id = "exblank1" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.blank[i] end})
						table.insert(skin.destination, {id = "exjustrate1" .. i,	dst = {{x = pos[1] + 118 + ((i - 1) * 63), y = pos[2] + 189, w = 15, h = 17}}})
						if isDisplayRandomPattern() then
							table.insert(skin.destination, {id = "random1" .. i,		dst = {{x = pos[1] + 133 + ((i - 1) * 63), y = pos[2] + 165, w = 15, h = 17}}})
						end
						table.insert(skin.destination, {id = "exjust1" .. i,		dst = {{x = pos[1] + 118 + ((i - 1) * 63), y = pos[2] + 6, w = 15, h = 17, b = 204}}})
						table.insert(skin.destination, {id = "exfast1" .. i,		dst = {{x = pos[1] + 118 + ((i - 1) * 63), y = pos[2] + 26, w = 15, h = 17, r = 153, g = 204}}})
						table.insert(skin.destination, {id = "exslow1" .. i,		dst = {{x = pos[1] + 118 + ((i - 1) * 63), y = pos[2] + 46, w = 15, h = 17, g = 153, b = 153}}})
						table.insert(skin.destination, {id = "exblank1" .. i,		dst = {{x = pos[1] + 118 + ((i - 1) * 63), y = pos[2] + 88, w = 15, h = 17, r = 192, g = 192, b = 192, a = 153}}})
					end
				end
			end
			
			local function add_2p(pos)
				table.insert(skin.source, {id = "keys2", path = "keys2p.png"})
				table.insert(skin.image, {id = "exkeys2", src = "keys2", x = 0, y = 0, w = 745, h = -1})
				table.insert(skin.destination, {id = "exkeys2", dst = {{x = pos[1], y = pos[2], w = 745, h = 210}}})
				local offset = 12
				if play_log.skin_type == 2 then offset = 10
				elseif play_log.skin_type == 3 then offset = 8
				end
				for i = 11, 20 do
					local total = play_log.just[i] + play_log.fast[i] + play_log.slow[i] + play_log.blank[i]
					if total ~= 0 then
						local graph = {}
						graph.just_rate = play_log.just[i] / (play_log.just[i] + play_log.fast[i] + play_log.slow[i]) * 100
						graph.total = play_log.fast[i] + play_log.slow[i]
						graph.fast = play_log.fast[i] / graph.total * 100
						graph.slow = play_log.slow[i] / graph.total * 100
						local random2p = 448 + i
						if i == 11 then random1p = 469 end
						table.insert(skin.value, {id = "exjustrate2" .. i,	src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return graph.just_rate end})
						table.insert(skin.value, {id = "random2" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 1, value = function() return main_state.event_index(random2p) end})
						table.insert(skin.value, {id = "exjust2" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.just[i] end})
						table.insert(skin.value, {id = "exfast2" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.fast[i] end})
						table.insert(skin.value, {id = "exslow2" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.slow[i] end})
						table.insert(skin.value, {id = "exblank2" .. i,		src = "system", x = 0, y = 728, w = 165, h = 17, divx = 11, digit = 3, value = function() return play_log.blank[i] end})
						if i == 11 then
							table.insert(skin.destination, {id = "graph_r", loop = 1300, dst = {{time = 0, x = pos[1] + 15 + (9 * 63) + 5, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.slow}}})
							table.insert(skin.destination, {id = "graph_b", loop = 1300, dst = {{time = 0, x = pos[1] + 15 + (9 * 63) + 25, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.fast}}})
							table.insert(skin.destination, {id = "exjustrate2" .. i,	dst = {{x = pos[1] + 15 + (9 * 63), y = pos[2] + 189, w = 15, h = 17}}})
							if isDisplayRandomPattern() then
								table.insert(skin.destination, {id = "random2" .. i,		dst = {{x = pos[1] + 30 + (9 * 63), y = pos[2] + 165, w = 15, h = 17}}})
							end
							table.insert(skin.destination, {id = "exjust2" .. i,		dst = {{x = pos[1] + 15 + (9 * 63), y = pos[2] + 6, w = 15, h = 17, b = 204}}})
							table.insert(skin.destination, {id = "exfast2" .. i,		dst = {{x = pos[1] + 15 + (9 * 63), y = pos[2] + 26, w = 15, h = 17, r = 153, g = 204}}})
							table.insert(skin.destination, {id = "exslow2" .. i,		dst = {{x = pos[1] + 15 + (9 * 63), y = pos[2] + 46, w = 15, h = 17, g = 153, b = 153}}})
							table.insert(skin.destination, {id = "exblank2" .. i,		dst = {{x = pos[1] + 15 + (9 * 63), y = pos[2] + 88, w = 15, h = 17, r = 192, g = 192, b = 192, a = 153}}})
						else
							table.insert(skin.destination, {id = "graph_r", loop = 1300, dst = {{time = 0, x = pos[1] + 15 + ((i - offset) * 63) + 5, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.slow}}})
							table.insert(skin.destination, {id = "graph_b", loop = 1300, dst = {{time = 0, x = pos[1] + 15 + ((i - offset) * 63) + 25, y = pos[2] + 85, w = 15, h = 0, acc = 2},{time = 1000},{time = 1300, h = graph.fast}}})
							table.insert(skin.destination, {id = "exjustrate2" .. i,	dst = {{x = pos[1] + 15 + ((i - offset) * 63), y = pos[2] + 189, w = 15, h = 17}}})
							if isDisplayRandomPattern() then
								table.insert(skin.destination, {id = "random2" .. i,		dst = {{x = pos[1] + 30 + ((i - offset) * 63), y = pos[2] + 165, w = 15, h = 17}}})
							end
							table.insert(skin.destination, {id = "exjust2" .. i,		dst = {{x = pos[1] + 15 + ((i - offset) * 63), y = pos[2] + 6, w = 15, h = 17, b = 204}}})
							table.insert(skin.destination, {id = "exfast2" .. i,		dst = {{x = pos[1] + 15 + ((i - offset) * 63), y = pos[2] + 26, w = 15, h = 17, r = 153, g = 204}}})
							table.insert(skin.destination, {id = "exslow2" .. i,		dst = {{x = pos[1] + 15 + ((i - offset) * 63), y = pos[2] + 46, w = 15, h = 17, g = 153, b = 153}}})
							table.insert(skin.destination, {id = "exblank2" .. i,		dst = {{x = pos[1] + 15 + ((i - offset) * 63), y = pos[2] + 88, w = 15, h = 17, r = 192, g = 192, b = 192, a = 153}}})
						end
					end
				end
			end
			
			local function fsgraph_scal()
				local var1, var2 = 0, 0
				for i = 1, #play_log.section_1p.just do
					var2 = play_log.section_1p.just[i] + play_log.section_1p.fast[i] + play_log.section_1p.slow[i] + play_log.section_1p.blank[i]
					if var2 > var1 then var1 = var2 end
				end
				for i = 1, #play_log.section_2p.just do
					var2 = play_log.section_2p.just[i] + play_log.section_2p.fast[i] + play_log.section_2p.slow[i] + play_log.section_2p.blank[i]
					if var2 > var1 then var1 = var2 end
				end
				return 100 / var1
			end
			
			local function add_1p_fsgraph(pos)
				local scal = fsgraph_scal()
				local offset_x = (745 - (#play_log.section_1p.just * 6)) / 2
				if play_log.skin_type == 0
				or play_log.skin_type == 1
				or play_log.skin_type == 4
				then
					if #play_log.section_1p.just <= 110 then offset_x = 42 end
				end
				table.insert(skin.destination, {id = -110, loop = 1000, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2], w = #play_log.section_1p.just * 6 + 1, h = 100, a = 0, acc = 2},{time = 1000, a = 128}}})
				for i = 1, #play_log.section_1p.just do
					local height = {
						blank = (play_log.section_1p.just[i] + play_log.section_1p.fast[i] + play_log.section_1p.slow[i] + play_log.section_1p.blank[i]) * scal,
						slow  = (play_log.section_1p.just[i] + play_log.section_1p.fast[i] + play_log.section_1p.slow[i]) * scal,
						fast  = (play_log.section_1p.just[i] + play_log.section_1p.fast[i]) * scal,
						just  = (play_log.section_1p.just[i]) * scal
					}
					table.insert(skin.destination, {id = -110,		loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, a = 128, acc = 2},{time = 1000},{time = 1300, h = height.blank}}})
					table.insert(skin.destination, {id = "graph_r", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.slow}}})
					table.insert(skin.destination, {id = "graph_b", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.fast}}})
					table.insert(skin.destination, {id = "graph_y", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.just}}})
				end
			end
			
			local function add_2p_fsgraph(pos)
				local scal = fsgraph_scal()
				local offset_x = (745 - (#play_log.section_2p.just * 6)) / 2
				table.insert(skin.destination, {id = -110, loop = 1000, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2], w = #play_log.section_2p.just * 6 + 1, h = 100, a = 0, acc = 2},{time = 1000, a = 128}}})
				for i = 1, #play_log.section_2p.just do
					local height = {
						blank = (play_log.section_2p.just[i] + play_log.section_2p.fast[i] + play_log.section_2p.slow[i] + play_log.section_2p.blank[i]) * scal,
						slow  = (play_log.section_2p.just[i] + play_log.section_2p.fast[i] + play_log.section_2p.slow[i]) * scal,
						fast  = (play_log.section_2p.just[i] + play_log.section_2p.fast[i]) * scal,
						just  = (play_log.section_2p.just[i]) * scal
					}
					table.insert(skin.destination, {id = -110,		loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, a = 128, acc = 2},{time = 1000},{time = 1300, h = height.blank}}})
					table.insert(skin.destination, {id = "graph_r", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.slow}}})
					table.insert(skin.destination, {id = "graph_b", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.fast}}})
					table.insert(skin.destination, {id = "graph_y", loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6), y = pos[2], w = 4, h = 0, acc = 2},{time = 1000},{time = 1300, h = height.just}}})
				end
			end
			
			local function add_timing_adjust_graph(pos)
				local offset_x = (745 - (#play_log.section_1p.just * 6)) / 2
				if play_log.skin_type == 0
				or play_log.skin_type == 1
				or play_log.skin_type == 4
				then
					if #play_log.section_1p.just <= 110 then offset_x = 42 end
				end
				table.insert(skin.destination, {id = -110, loop = 1000, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2], w = #play_log.section_1p.just * 6 + 1, h = 100, a = 0, acc = 2},{time = 1000, a = 128}}})
				for i = 1, #play_log.section_2p.just do
					table.insert(skin.destination, {id = -111, loop = 1300, dst = {{time = 0, x = pos[1] + offset_x + ((i - 1) * 6) - 1, y = pos[2] + 49 + play_log.section_timing[i], w = 6, h = 2, a = 0, r = 0, b = 0, acc = 2},{time = 1000},{time = 1300, a = 192}}})
				end
				table.insert(skin.destination, {id = -111, loop = 1300, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2] + 49, w = #play_log.section_1p.just * 6 + 1, h = 2, a = 0, acc = 2},{time = 1000},{time = 1300, a = 128}}})
				table.insert(skin.destination, {id = -111, loop = 1300, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2] + 49 + adjust_timing, w = #play_log.section_1p.just * 6 + 1, h = 2, a = 0, g = 0, b = 0, acc = 2},{time = 1000},{time = 1300, a = 128}}})
				table.insert(skin.destination, {id = "adjust-ave", loop = 1000, dst = {{time = 0, x = pos[1] + offset_x + 6, y = pos[2] + 80, w = 14, h = 14, a = 0, acc = 2},{time = 1000, a = 255}}})
			end
			
			local function add_timing_distribution_graph(pos)
				local offset_x = (745 - (#play_log.section_1p.just * 6)) / 2
				if play_log.skin_type == 0
				or play_log.skin_type == 1
				or play_log.skin_type == 4
				then
					if #play_log.section_1p.just <= 110 then offset_x = 42 end
				end
				table.insert(skin.destination, {id = "timingdistributiongraph",	loop = 1000, dst = {{time = 0, x = pos[1] + offset_x - 1, y = pos[2], w = #play_log.section_1p.just * 6 + 1, h = 100, a = 0, acc = 2},{time = 1000, a = 255}}})
			end
			
			-- TODO: 整合性チェックの追加
			-- 一時対策: ログ保存時間から1分以上経過しているとき表示しない 
			local log_time = os.clock() - play_log.clock
			if	0 < log_time
			and	log_time <= 60 then
				--[[
				add_1p({200 + 150 - 63, result_origin[2] + 626 - 34})
				add_1p_fsgraph({200 + 150, result_origin[2] + 516 - 34})
				add_2p({975 + 150 - 63, result_origin[2] + 626 - 34})
				add_2p_fsgraph({975 + 150, result_origin[2] + 516 - 34})
				add_timing_adjust_graph({200 + 150, result_origin[2] + 406 - 34})
				add_timing_distribution_graph({975 + 150, result_origin[2] + 406 - 34})
				--]]
				-- table.insert(skin.destination, {id = "result_bg", loop = dt[2], op = {op.RESULT_R}, dst = {{time = dt[1], x = 2432, y = result_origin[2] + 356 + 16, w = -1920, h = 446, acc = 2, a = 255},{time = dt[2], x = 1920, a = 255}}})
				if play_log.skin_type == 2 or play_log.skin_type == 3 then
					table.insert(skin.destination, {id = "result_bg", loop = dt[2], op = {op.RESULT_L}, dst = {{time = dt[1], x = -1920, y = result_origin[2] + 356 + 16, w = 1920, h = 446, acc = 2, a = 255},{time = dt[2], x = 0, a = 255}}})
					add_1p({32, result_origin[2] + 626 - 28})
					add_1p_fsgraph({32, result_origin[2] + 516 - 28})
					add_2p({807, result_origin[2] + 626 - 28})
					add_2p_fsgraph({807, result_origin[2] + 516 - 28})
					add_timing_distribution_graph({807, result_origin[2] + 406 - 28})
					add_timing_adjust_graph({32, result_origin[2] + 406 - 28})
				else
					table.insert(skin.destination, {id = "result_bg", loop = dt[2], op = {op.RESULT_L}, dst = {{time = dt[1], x = -1920, y = result_origin[2] + 356 + 16, w = 1920, h = 222, acc = 2, a = 255},{time = dt[2], x = 0, a = 255}}})
					add_1p({32, result_origin[2] + 406 - 28})
					add_1p_fsgraph({807, result_origin[2] + 516 - 28})
					add_timing_distribution_graph({807, result_origin[2] + 406 - 28})
					add_timing_adjust_graph({807, result_origin[2] + 406 - 28})
				end
			end
			-- 一時対策: ログの消去
			local del_log = io.open(path_log.del, "w")
			del_log:close()
		end
	end -- <打鍵詳細ここまで>

	
	-- シャッター
	-- m-selectシャッター
	if skin_config.option["使用するシャッターの設定"] == op.SHUTTER_DEF then
		local shutter = {dst = {}}
		shutter.dst = {{id = "shutter", loop = 400, timer = 2,	dst = {{time = 0, x = -2560, y = 0, w = 2560, h = 1080, acc = 2},{time = 400, x = 0}}}}
		append_all(skin.destination, shutter.dst)
	-- ModernChicシャッター
	--[[
	elseif skin_config.option["使用するシャッターの設定"] == op.SHUTTER_MC then
		local mc_shutter = {}
		mc_shutter.source = {
			{id = "mc_system", path = "../../ModernChic/Result/parts/system.png"},
		}
		mc_shutter.image = {
			-- フェードアウト時の文字
			{id = "finishClear", src = "mc_system", x = 0, y = 1808, w = 1200, h = 50},
			{id = "finishFailed", src = "mc_system", x = 0, y = 1858, w = 1200, h = 50},
		}
		mc_shutter.dst = {
			-- ボタンが押されたら発動
			{id = -110, timer = 2, loop = 500, dst = {{time = 0, x = 0, y = 540, w = 1920, h = 0},{time = 250, y = 0, h = 1080},{time = 500}}},
			{id = "finishClear", timer = 2, op = {90}, loop = -1, dst = {{time = 150, x =  375, y = 513, w = 1200, h = 50, a = 0},{time = 300, a = 255},{time = 500}}},
			{id = "finishFailed", timer = 2, op = {91}, loop = -1, dst = {{time = 150, x =  375, y = 513, w = 1200, h = 50, a = 0},{time = 300, a = 255},{time = 500}}}
		}
		append_all(skin.source, mc_shutter.source)
		append_all(skin.image, mc_shutter.image)
		append_all(skin.destination, mc_shutter.dst)
		--]]
	end
	
	return skin
end

return {
	header = header,
	main = main
}
