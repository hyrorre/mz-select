local parts = {}

local OP_GRAPH_OFF		= get_property_op()
local OP_GRAPH_ON		= get_property_op()

parts.property = {
	{name = "ノーツ・BPMグラフを使用する", item = {
		{name = "OFF",	op = OP_GRAPH_OFF},
		{name = "ON",	op = OP_GRAPH_ON}
	},def = "ON"},
}

local function load()

	parts.source = {
		{id = "src-default-info_parts", path = "customize/advanced/default_info2/parts.png"},
	}

	parts.font = {
		{id = "font-default-info-2", path = "customize/advanced/default_info2/fnt/title_course.fnt", type = 0}
	}
	
	parts.text = {
		{id = "default_info_genre",		font = "font-default-commonparts-sub",		size = 24, align = 2, ref = 13, overflow = 1},
		{id = "default_info_title",		font = "font-default-commonparts-title",	size = 72, align = 2, ref = 10, overflow = 1},
		{id = "default_info_subtitle",	font = "font-default-commonparts-sub",		size = 24, align = 2, ref = 11, overflow = 1},
		{id = "default_info_artist",	font = "font-default-commonparts-sub",		size = 24, align = 2, ref = 16, overflow = 1},
		{id = "default_info_course1",	font = "font-default-info-2",				size = 30, align = 2, ref = 150, overflow = 1},
		{id = "default_info_course2",	font = "font-default-info-2",				size = 30, align = 2, ref = 151, overflow = 1},
		{id = "default_info_course3",	font = "font-default-info-2",				size = 30, align = 2, ref = 152, overflow = 1},
		{id = "default_info_course4",	font = "font-default-info-2",				size = 30, align = 2, ref = 153, overflow = 1},
		{id = "default_info_directory",	font = "font-default-commonparts-sub",		size = 24, align = 2, ref = 1000, overflow = 1},
		
		{id = "default_info_const_gauge_gaugetype",	font = "font-default-commonparts-m_select1", size = 12, align = 0, constantText = "course gauge type"},
		{id = "default_info_const_gauge_lr2",		font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "LR2"},
		{id = "default_info_const_gauge_5keys",		font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "5KEYS"},
		{id = "default_info_const_gauge_7keys",		font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "7KEYS"},
		{id = "default_info_const_gauge_9keys",		font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "9KEYS"},
		{id = "default_info_const_gauge_24keys",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "24KEYS"},
		
		{id = "default_info_const_option",	font = "font-default-commonparts-m_select1", size = 12, align = 0, constantText = "options applied"},
		{id = "default_info_const_mirror",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "MIRROR OK"},
		{id = "default_info_const_random",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "RANDOM OK"},
		{id = "default_info_const_nospeed",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "NORMAL SPEED"},
		{id = "default_info_const_nogood",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "NO GOOD"},
		{id = "default_info_const_nogreat",	font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = "NO GREAT"}
	}

	parts.image = {
		{id = "default_info_songs",				src = "src-default-commonparts-system", x = 904, y = 832, w = 120, h = 24},
		{id = "default_info_total",				src = "src-default-commonparts-system", x = 904, y = 880, w = 120, h = 24},
		{id = "default_info_time_song",			src = "src-default-commonparts-system", x = 942, y = 856, w = 82, h = 24},
		{id = "default_info_time_song_dot",		src = "src-default-commonparts-system", x = 396, y = 880, w = 36, h = 36},
		{id = "default_info_judge_veryeasy",	src = "src-default-commonparts-system", x = 820, y = 904, w = 204, h = 24},
		{id = "default_info_judge_easy",		src = "src-default-commonparts-system", x = 820, y = 928, w = 204, h = 24},
		{id = "default_info_judge_normal",		src = "src-default-commonparts-system", x = 820, y = 952, w = 204, h = 24},
		{id = "default_info_judge_hard",		src = "src-default-commonparts-system", x = 820, y = 976, w = 204, h = 24},
		{id = "default_info_judge_veryhard",	src = "src-default-commonparts-system", x = 820, y = 1000, w = 204, h = 24},
		{id = "default_info_s_5keys",			src = "src-default-commonparts-system", x = 460, y = 72, w = 180, h = 36},
		{id = "default_info_s_7keys",			src = "src-default-commonparts-system", x = 460, y = 108, w = 180, h = 36},
		{id = "default_info_s_9keys",			src = "src-default-commonparts-system", x = 460, y = 144, w = 180, h = 36},
		{id = "default_info_s_10keys",			src = "src-default-commonparts-system", x = 460, y = 180, w = 180, h = 36},
		{id = "default_info_s_14keys",			src = "src-default-commonparts-system", x = 460, y = 216, w = 180, h = 36},
		{id = "default_info_s_24keys",			src = "src-default-commonparts-system", x = 460, y = 252, w = 180, h = 36},
		{id = "default_info_s_24keysDP",		src = "src-default-commonparts-system", x = 460, y = 288, w = 180, h = 36},
		{id = "default_info_bpm",				src = "src-default-commonparts-system", x = 460, y = 0, w = 108, h = 36},
		{id = "default_info_-",					src = "src-default-commonparts-system", x = 568, y = 0, w = 36, h = 36},
		{id = "default_info_mainbpm",			src = "src-default-commonparts-system", x = 0, y = 399, w = 60, h = 21},
		{id = "default_info_notes",				src = "src-default-commonparts-system", x = 0, y = 84, w = 100, h = 21},	
		{id = "default_info_random",			src = "src-default-info_parts", x = 0, y = 0, w = 512, h = 105},	
	}

	parts.value = {
		{id = "default_info_songs_count",		src = "src-default-commonparts-system", x = 0, y = 880, w = 360, h = 36, divx = 10, digit = 6, ref = 300},
		{id = "default_info_minbpm",			src = "src-default-commonparts-system", x = 0, y = 916, w = 360, h = 36, divx = 10, digit = 4, align = 2, ref = 91},
		{id = "default_info_maxbpm",			src = "src-default-commonparts-system", x = 0, y = 916, w = 360, h = 36, divx = 10, digit = 4, align = 2, ref = 90},
		{id = "default_info_songtotal_count",	src = "src-default-commonparts-system", x = 0, y = 880, w = 360, h = 36, divx = 10, digit = 4, ref = 368},
		{id = "default_info_songtime_mm_count",	src = "src-default-commonparts-system", x = 0, y = 880, w = 360, h = 36, divx = 10, digit = 2, ref = 1163},
		{id = "default_info_songtime_ss_count",	src = "src-default-commonparts-system", x = 0, y = 880, w = 396, h = 36, divx = 11, digit = 2, ref = 1164},
		{id = "default_info_judgerank",			src = "src-default-commonparts-system", x = 0, y = 880, w = 360, h = 36, divx = 10, digit = 3, zeropadding = 2, ref = 400},
		{id = "default_info_mainbpm-num",		src = "src-default-commonparts-system", x = 0, y = 796, w = 200, h = 21, divx = 10, divy = 1, digit = 7, ref = 92},
		{id = "default_info_notes_count",		src = "src-default-commonparts-system", x = 0, y = 817, w = 200, h = 21, divx = 10, digit = 5, ref = 74},
	}
		
	parts.destination = {}
	
	if skin_config.option["ノーツ・BPMグラフを使用する"] == OP_GRAPH_ON then
		parts.judgegraph = {{
			id = "default_info_notes_graph",
			type = 0,
			backTexOff = 0,
			delay = 500,
			orderReverse = 0,
			noGap = 0,
		}}
		parts.bpmgraph = {{id = "default_info_bpmgraph"}}
		local dst_graph = {
			{id = -110,							op = {2},	dst = {{x = 378, y = 467, w = 702, h = 100, a = 153}}},
			{id = "default_info_notes_graph",	op = {2},	dst = {{x = 480, y = 467, w = 600, h = 100, a = 153}}},
			{id = "default_info_bpmgraph",		op = {2},	dst = {{x = 480, y = 467, w = 600, h = 100}}},
			{id = "default_info_mainbpm",		op = {2},	dst = {{x = 420, y = 542, w = 60, h = 21}}},
			{id = "default_info_mainbpm-num",	op = {2},	dst = {{x = 340, y = 521, w = 20, h = 21}}},
			{id = "default_info_notes",			op = {2},	dst = {{x = 380, y = 492, w = 100, h = 21}}},
			{id = "default_info_notes_count",	op = {2},	dst = {{x = 380, y = 471, w = 20, h = 21}}},
		}
		append_all(parts.destination, dst_graph)
	end
		
	local dst_info = {
	
		-- フォルダ選択時
		{id = "default_info_songs",			op = {1}, dst = {{x = 826, y = 573, w = 120, h = 24}}},
		{id = "default_info_songs_count",	op = {1}, dst = {{x = 936, y = 573, w = 24, h = 24}}},
		
		-- 曲選択時
		{id = -102, stretch = 1, filter = 1, timer = 11, loop = 250,	dst = {{time = 0, x = 780, y = 747, w = 300, h = 80, acc = 2, a = 0},{time = 250, a = 255}}},
		
		{id = "default_info_genre",		filter = 1, timer = 11, loop = 300, op = {192},	dst = {{time = 0, x = 1040, y = 747, w = 724, h = 24, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_genre",		filter = 1, timer = 11, loop = 300, op = {193},	dst = {{time = 0, x = 720, y = 747, w = 404, h = 24, acc = 2, a = 0},{time = 300, x = 760, a = 255}}},
		{id = "default_info_title",		filter = 1, timer = 11, loop = 300,				dst = {{time = 0, x = 1120, y = 663, w = 724, h = 72, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_subtitle",	filter = 1, timer = 11, loop = 300,				dst = {{time = 0, x = 1120, y = 663, w = 724, h = 24, g = 153, a = 153, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_artist",	filter = 1, timer = 11, loop = 300,				dst = {{time = 0, x = 1080, y = 663, w = 724, h = 24, acc = 2, a = 0},{time = 300, y = 633, a = 255}}},
		
		{id = "default_info_bpm",	op = {2},	dst = {{x = 1008, y = 603, w = 72, h = 24}}},
		{id = "default_info_-",		op = {2},	dst = {{x = 876, y = 603, w = 24, h = 24}}},
		{id = "default_info_minbpm",			dst = {{x = 780, y = 603, w = 24, h = 24}}},
		{id = "default_info_maxbpm",			dst = {{x = 900, y = 603, w = 24, h = 24}}},

		{id = "default_info_total",				op = {2}, dst = {{x = 378, y = 603, w = 120, h = 24}}},
		{id = "default_info_songtotal_count",	op = {2}, dst = {{x = 510, y = 603, w = 24, h = 24}}},
		{id = "default_info_time_song",			op = {2}, dst = {{x = 416, y = 573, w = 82, h = 24}}},
		{id = "default_info_songtime_mm_count",	op = {2}, dst = {{x = 510, y = 573, w = 24, h = 24}}},
		{id = "default_info_time_song_dot",		op = {2}, dst = {{x = 558, y = 573, w = 24, h = 24}}},			
		{id = "default_info_songtime_ss_count",	op = {2}, dst = {{x = 582, y = 573, w = 24, h = 24}}},
		
		{id = "default_info_judge_veryeasy",	op = {184},	dst = {{x = 744 - 72, y = 573, w = 204, h = 24}}},
		{id = "default_info_judge_easy",		op = {183},	dst = {{x = 744 - 72, y = 573, w = 204, h = 24}}},
		{id = "default_info_judge_normal",		op = {182},	dst = {{x = 744 - 72, y = 573, w = 204, h = 24}}},
		{id = "default_info_judge_hard",		op = {181},	dst = {{x = 744 - 72, y = 573, w = 204, h = 24}}},
		{id = "default_info_judge_veryhard",	op = {180},	dst = {{x = 744 - 72, y = 573, w = 204, h = 24}}},
		
		{id = "default_info_judgerank",			op = {2},	dst = {{x = 744 + 144, y = 573, w = 24, h = 24}}},
		
		{id = "default_info_s_7keys",		op = {160},		dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_14keys",		op = {162},		dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_9keys",		op = {164},		dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_5keys",		op = {161},		dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_10keys",		op = {163},		dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_24keys",		op = {1160},	dst = {{x = 960, y = 573, w = 120, h = 24}}},
		{id = "default_info_s_24keysDP",	op = {1161},	dst = {{x = 960, y = 573, w = 120, h = 24}}},
		
		-- コース選択時
		{id = -110, op = {3}, dst = {{x = 378, y = 467, w = 702, h = 100, a = 127}}},
		
		{id = "default_info_const_gauge_gaugetype",	op = {3}, dst = {{x = 396, y = 542, w = 260, h = 21}}},
		{id = "default_info_const_gauge_lr2",		op = {3}, dst = {{x = 402, y = 475, w = 260, h = 21, a = 95}}},
		{id = "default_info_const_gauge_5keys",		op = {3}, dst = {{x = 402, y = 523, w = 260, h = 21, a = 95}}},
		{id = "default_info_const_gauge_7keys",		op = {3}, dst = {{x = 402, y = 499, w = 260, h = 21, a = 95}}},
		{id = "default_info_const_gauge_9keys",		op = {3}, dst = {{x = 522, y = 523, w = 260, h = 21, a = 95}}},
		{id = "default_info_const_gauge_24keys",	op = {3}, dst = {{x = 522, y = 499, w = 260, h = 21, a = 95}}},
		{id = "default_info_const_option",	op = {3}, dst = {{x = 710, y = 542, w = 260, h = 21}}},
		{id = "default_info_const_mirror",	op = {3}, dst = {{x = 716, y = 523, w = 260, h = 21, a = 95, r = 102}}},
		{id = "default_info_const_random",	op = {3}, dst = {{x = 716, y = 499, w = 260, h = 21, a = 95, b = 102}}},
		{id = "default_info_const_nospeed",	op = {3}, dst = {{x = 716, y = 475, w = 260, h = 21, a = 95, g = 102, b = 102}}},
		{id = "default_info_const_nogood",	op = {3}, dst = {{x = 905, y = 523, w = 260, h = 21, a = 95, g = 102, b = 204}}},
		{id = "default_info_const_nogreat",	op = {3}, dst = {{x = 905, y = 499, w = 260, h = 21, a = 95, g = 204, b = 102}}},
		
		{id = "default_info_const_gauge_lr2",		op = {1010}, dst = {{x = 402, y = 475, w = 260, h = 21}}},
		{id = "default_info_const_gauge_5keys",		op = {1011}, dst = {{x = 402, y = 523, w = 260, h = 21}}},
		{id = "default_info_const_gauge_7keys",		op = {1012}, dst = {{x = 402, y = 499, w = 260, h = 21}}},
		{id = "default_info_const_gauge_9keys",		op = {1013}, dst = {{x = 522, y = 523, w = 260, h = 21}}},
		{id = "default_info_const_gauge_24keys",	op = {1014}, dst = {{x = 522, y = 499, w = 260, h = 21}}},
		{id = "default_info_const_mirror",	op = {1003}, dst = {{x = 716, y = 523, w = 260, h = 21, r = 102}}},
		{id = "default_info_const_random",	op = {1004}, dst = {{x = 716, y = 499, w = 260, h = 21, b = 102}}},
		{id = "default_info_const_nospeed",	op = {1005}, dst = {{x = 716, y = 475, w = 260, h = 21, g = 102, b = 102}}},
		{id = "default_info_const_nogood",	op = {1006}, dst = {{x = 905, y = 523, w = 260, h = 21, g = 102, b = 204}}},
		{id = "default_info_const_nogreat",	op = {1007}, dst = {{x = 905, y = 499, w = 260, h = 21, g = 204, b = 102}}},
		
		{id = "default_info_course1", filter = 1, timer = 11, loop = 300, dst = {{time = 0, x = 1120, y = 723, w = 980, h = 30, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_course2", filter = 1, timer = 11, loop = 300, dst = {{time = 0, x = 1120, y = 683, w = 980, h = 30, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_course3", filter = 1, timer = 11, loop = 300, dst = {{time = 0, x = 1120, y = 643, w = 980, h = 30, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		{id = "default_info_course4", filter = 1, timer = 11, loop = 300, dst = {{time = 0, x = 1120, y = 603, w = 980, h = 30, acc = 2, a = 0},{time = 300, x = 1080, a = 255}}},
		
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {1,192},	dst = {{time = 0, x = 1080, y = 812, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 782, a = 255}}},
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {1,193},	dst = {{time = 0, x = 1080, y = 865, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 835, a = 255}}},
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {2,192},	dst = {{time = 0, x = 1080, y = 812, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 782, a = 255}}},
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {2,193},	dst = {{time = 0, x = 1080, y = 865, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 835, a = 255}}},
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {3,192},	dst = {{time = 0, x = 1080, y = 812, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 782, a = 255}}},
		{id = "default_info_directory",	filter = 1, timer = 11, loop = 300, op = {3,193},	dst = {{time = 0, x = 1080, y = 865, w = 544, h = 24, b = 153, a = 153, acc = 2, a = 0},{time = 300, y = 835, a = 255}}},
	
		-- ランダムセレクト
		{id = "default_info_random",	filter = 1, timer = 11, loop = 300, op = {1030},	dst = {{time = 0, x = 608, y = 635, w = 512, h = 105, acc = 2, a = 0},{time = 300, x = 568, a = 255}}},
	}
	append_all(parts.destination, dst_info)
	
	return parts	
end

return {
	parts = parts,
	load = load
}