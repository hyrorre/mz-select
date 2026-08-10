local parts = {}

local function load()

	-- 長い
	local TOV = main_state.timer_off_value
	
	-- 警告メッセージ表示切り替え用
	local op_timer = {
		assist	= get_customTimer_id(),
		dp		= get_customTimer_id(),
		dop		= get_customTimer_id(),
		ex		= get_customTimer_id()
	}
	
	parts.source = {
		{id = "src-default-optionpanel-panel1", path = "customize/advanced/default_optionpanel4/panel1_bmz.png"},
		{id = "src-default-optionpanel-panel2", path = "customize/advanced/default_optionpanel4/panel2.png"},
		{id = "src-default-optionpanel-panel3", path = "customize/advanced/default_optionpanel4/panel3.png"},
		{id = "src-default-optionpanel-cursor", path = "customize/advanced/default_optionpanel4/cursor.png"},
		{id = "src-default-optionpanel-random-cursor-bmz", path = "customize/advanced/default_optionpanel4/random_cursor_bmz.png"},
		{id = "src-default-optionpanel-message", path = "customize/advanced/default_optionpanel4/op_message.png"},
	}

	parts.image = {
		{id = "default_optionpanel_option_panel1",				src = "src-default-optionpanel-panel1", x = 0, y = 0, w = 1315, h = 1124},
		
		-- 追加 ターゲット 11
		--[[ 0.8.5にて廃止
		{id = "default_optionpanel_option_selector11_1",		src = "src-default-optionpanel-cursor", x = 616, y = 500, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_2",		src = "src-default-optionpanel-cursor", x = 616, y = 450, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_3",		src = "src-default-optionpanel-cursor", x = 616, y = 400, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_4",		src = "src-default-optionpanel-cursor", x = 616, y = 350, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_5",		src = "src-default-optionpanel-cursor", x = 616, y = 300, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_6",		src = "src-default-optionpanel-cursor", x = 616, y = 250, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_7",		src = "src-default-optionpanel-cursor", x = 616, y = 200, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_8",		src = "src-default-optionpanel-cursor", x = 616, y = 150, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_9",		src = "src-default-optionpanel-cursor", x = 616, y = 100, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_10",		src = "src-default-optionpanel-cursor", x = 616, y = 50, w = 170, h = 550},
		{id = "default_optionpanel_option_selector11_11",		src = "src-default-optionpanel-cursor", x = 616, y = 0, w = 170, h = 550},
		--]]
		
		-- random
		{id = "default_optionpanel_option_selector12_1",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 550, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_2",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 500, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_3",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 450, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_4",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 400, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_5",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 350, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_6",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 300, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_7",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 250, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_8",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 200, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_9",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 150, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_10",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 100, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_11",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 50, w = 170, h = 600},
		{id = "default_optionpanel_option_selector12_12",		src = "src-default-optionpanel-random-cursor-bmz", x = 0, y = 0, w = 170, h = 600},
		
		-- gauge
		{id = "default_optionpanel_option_selector13_1",		src = "src-default-optionpanel-cursor", x = 616, y = 500, w = 170, h = 300},
		{id = "default_optionpanel_option_selector13_2",		src = "src-default-optionpanel-cursor", x = 616, y = 450, w = 170, h = 300},
		{id = "default_optionpanel_option_selector13_3",		src = "src-default-optionpanel-cursor", x = 616, y = 400, w = 170, h = 300},
		{id = "default_optionpanel_option_selector13_4",		src = "src-default-optionpanel-cursor", x = 616, y = 350, w = 170, h = 300},
		{id = "default_optionpanel_option_selector13_5",		src = "src-default-optionpanel-cursor", x = 616, y = 300, w = 170, h = 300},
		{id = "default_optionpanel_option_selector13_6",		src = "src-default-optionpanel-cursor", x = 616, y = 250, w = 170, h = 300},

		-- speed
		{id = "default_optionpanel_option_selector14_1",		src = "src-default-optionpanel-cursor", x = 616, y = 500, w = 170, h = 250},
		{id = "default_optionpanel_option_selector14_2",		src = "src-default-optionpanel-cursor", x = 616, y = 450, w = 170, h = 250},
		{id = "default_optionpanel_option_selector14_3",		src = "src-default-optionpanel-cursor", x = 616, y = 400, w = 170, h = 250},
		{id = "default_optionpanel_option_selector14_4",		src = "src-default-optionpanel-cursor", x = 616, y = 350, w = 170, h = 250},
		{id = "default_optionpanel_option_selector14_5",		src = "src-default-optionpanel-cursor", x = 616, y = 300, w = 170, h = 250},

		-- dp
		{id = "default_optionpanel_option_selector15_1",		src = "src-default-optionpanel-cursor", x = 616, y = 500, w = 170, h = 200},
		{id = "default_optionpanel_option_selector15_2",		src = "src-default-optionpanel-cursor", x = 616, y = 450, w = 170, h = 200},
		{id = "default_optionpanel_option_selector15_3",		src = "src-default-optionpanel-cursor", x = 616, y = 400, w = 170, h = 200},
		{id = "default_optionpanel_option_selector15_4",		src = "src-default-optionpanel-cursor", x = 616, y = 350, w = 170, h = 200},
		
		{id = "default_optionpanel_option_panel2",				src = "src-default-optionpanel-panel2", x = 0, y = 0, w = 1024, h = 1024},
		
		-- panel2
		{id = "default_optionpanel_option_selector21_1",		src = "src-default-optionpanel-cursor", x = 616, y = 500, w = 210, h = 100},
		{id = "default_optionpanel_option_selector21_2",		src = "src-default-optionpanel-cursor", x = 616, y = 450, w = 210, h = 100},			

		{id = "default_optionpanel_option_panel3",				src = "src-default-optionpanel-panel3", x = 0, y = 0, w = 1024, h = 1024},
		
		-- 追加 ゲージオートシフト
		{id = "default_optionpanel_option_selector31_1",		src = "src-default-optionpanel-cursor", x = 0, y = 500, w = 406, h = 250},
		{id = "default_optionpanel_option_selector31_2",		src = "src-default-optionpanel-cursor", x = 0, y = 450, w = 406, h = 250},
		{id = "default_optionpanel_option_selector31_3",		src = "src-default-optionpanel-cursor", x = 0, y = 400, w = 406, h = 250},
		{id = "default_optionpanel_option_selector31_4",		src = "src-default-optionpanel-cursor", x = 0, y = 350, w = 406, h = 250},
		{id = "default_optionpanel_option_selector31_5",		src = "src-default-optionpanel-cursor", x = 0, y = 300, w = 406, h = 250},
		
		-- bga
		{id = "default_optionpanel_option_selector32_1",		src = "src-default-optionpanel-cursor", x = 406, y = 500, w = 210, h = 150},
		{id = "default_optionpanel_option_selector32_2",		src = "src-default-optionpanel-cursor", x = 406, y = 450, w = 210, h = 150},
		{id = "default_optionpanel_option_selector32_3",		src = "src-default-optionpanel-cursor", x = 406, y = 400, w = 210, h = 150},
		
		-- auto_adjust
		{id = "default_optionpanel_option_selector33_1",		src = "src-default-optionpanel-cursor", x = 406, y = 500, w = 210, h = 150},
		{id = "default_optionpanel_option_selector33_2",		src = "src-default-optionpanel-cursor", x = 406, y = 450, w = 210, h = 150},
		
		-- 特定オプション警告メッセージ
		{id = "default_optionpanel_option_message_1",			src = "src-default-optionpanel-message", x = 0, y = 0, w = 512, h = 128},
		{id = "default_optionpanel_option_message_2",			src = "src-default-optionpanel-message", x = 0, y = 128, w = 512, h = 128},
		{id = "default_optionpanel_option_message_3",			src = "src-default-optionpanel-message", x = 0, y = 256, w = 512, h = 128},
	}

	parts.imageset = {
		--[[ 0.8.5にて廃止
		{id = "default_optionpanel_option_target", ref = 77, images = {
			"default_optionpanel_option_selector11_1","default_optionpanel_option_selector11_2",
			"default_optionpanel_option_selector11_3","default_optionpanel_option_selector11_4",
			"default_optionpanel_option_selector11_5","default_optionpanel_option_selector11_6",
			"default_optionpanel_option_selector11_7","default_optionpanel_option_selector11_8",
			"default_optionpanel_option_selector11_9","default_optionpanel_option_selector11_10",
			"default_optionpanel_option_selector11_11"
		}},
		--]]
		{id = "default_optionpanel_option_random", ref = 344, images = {
			"default_optionpanel_option_selector12_1","default_optionpanel_option_selector12_2",
			"default_optionpanel_option_selector12_3","default_optionpanel_option_selector12_4",
			"default_optionpanel_option_selector12_5","default_optionpanel_option_selector12_6",
			"default_optionpanel_option_selector12_7","default_optionpanel_option_selector12_8",
			"default_optionpanel_option_selector12_9","default_optionpanel_option_selector12_10",
			"default_optionpanel_option_selector12_11","default_optionpanel_option_selector12_12"
		}},
		{id = "default_optionpanel_option_gauge", ref = 40, images = {
			"default_optionpanel_option_selector13_1","default_optionpanel_option_selector13_2",
			"default_optionpanel_option_selector13_3","default_optionpanel_option_selector13_4",
			"default_optionpanel_option_selector13_5","default_optionpanel_option_selector13_6"
		}},
		{id = "default_optionpanel_option_hsfix", ref = 55, images = {
			"default_optionpanel_option_selector14_1","default_optionpanel_option_selector14_2",
			"default_optionpanel_option_selector14_3","default_optionpanel_option_selector14_4",
			"default_optionpanel_option_selector14_5"
		}},
		{id = "default_optionpanel_option_random2", ref = 345, images = {
			"default_optionpanel_option_selector12_1","default_optionpanel_option_selector12_2",
			"default_optionpanel_option_selector12_3","default_optionpanel_option_selector12_4",
			"default_optionpanel_option_selector12_5","default_optionpanel_option_selector12_6",
			"default_optionpanel_option_selector12_7","default_optionpanel_option_selector12_8",
			"default_optionpanel_option_selector12_9","default_optionpanel_option_selector12_10",
			"default_optionpanel_option_selector12_11","default_optionpanel_option_selector12_12"
		}},
		{id = "default_optionpanel_option_dp", ref = 54, images = {
			"default_optionpanel_option_selector15_1","default_optionpanel_option_selector15_2",
			"default_optionpanel_option_selector15_3","default_optionpanel_option_selector15_4"
		}},
		
		{id = "default_optionpanel_option_exjudge", ref = 301, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_constant", ref = 302, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_judgearea", ref = 303, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_legacy", ref = 304, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_marknote", ref = 305, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_bpmguide", ref = 306, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		{id = "default_optionpanel_option_nomine", ref = 307, images = {
			"default_optionpanel_option_selector21_1","default_optionpanel_option_selector21_2"
		}},
		
		{id = "default_optionpanel_option_gas", ref = 78, images = {
			"default_optionpanel_option_selector31_1","default_optionpanel_option_selector31_2",
			"default_optionpanel_option_selector31_3","default_optionpanel_option_selector31_4",
			"default_optionpanel_option_selector31_5"
		}},
		{id = "default_optionpanel_option_bga", ref = 72, images = {
			"default_optionpanel_option_selector32_1","default_optionpanel_option_selector32_2",
			"default_optionpanel_option_selector32_3"
		}},
		{id = "default_optionpanel_option_adjust", ref = 75, images = {
			"default_optionpanel_option_selector33_1","default_optionpanel_option_selector33_2"
		}},
	}

	parts.value = {
		{id = "default_optionpanel_duration",		src = "src-default-commonparts-system", x = 0, y = 817, w = 200, h = 21, divx = 10, digit = 4, ref = 312},
		{id = "default_optionpanel_duration_green",	src = "src-default-commonparts-system", x = 0, y = 796, w = 200, h = 21, divx = 10, digit = 4, ref = 313},
		{id = "default_optionpanel_judgetiming",	src = "src-default-commonparts-system", x = 240, y = 817, w = 240, h = 42, divx = 12, divy = 2, digit = 3, ref = 12},
	}
	
	parts.text = {
		{id = "default_optionpanel_target_1",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 200},
		{id = "default_optionpanel_target_2",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 201},
		{id = "default_optionpanel_target_3",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 202},
		{id = "default_optionpanel_target_4",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 203},
		{id = "default_optionpanel_target_5",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 204},
		{id = "default_optionpanel_target_6",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 205},
		{id = "default_optionpanel_target_7",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 206},
		{id = "default_optionpanel_target_8",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 207},
		{id = "default_optionpanel_target_9",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 208},
		{id = "default_optionpanel_target_10",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 209},
		{id = "default_optionpanel_target_11",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 3},
		{id = "default_optionpanel_target_12",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 210},
		{id = "default_optionpanel_target_13",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 211},
		{id = "default_optionpanel_target_14",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 212},
		{id = "default_optionpanel_target_15",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 213},
		{id = "default_optionpanel_target_16",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 214},
		{id = "default_optionpanel_target_17",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 215},
		{id = "default_optionpanel_target_18",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 216},
		{id = "default_optionpanel_target_19",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 217},
		{id = "default_optionpanel_target_20",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 218},
		{id = "default_optionpanel_target_21",	font = "font-default-commonparts-mgenplus-1c-bold", size = 18, ref = 219}
	}
	
	local op2_cursor_pos = {x = 20, y = 23, y2 = 88} -- TODO: そのうち直す
	parts.destination = {
		{id = -110, loop = 300, op = {21}, timer = 21,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 168}}},
		{id = -110, loop = 300, op = {-21}, timer = 31,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 168},{time = 300, a = 0}}},
		{id = "default_optionpanel_option_panel1",	loop = 300, op = {21}, timer = 21,	dst = {{time = 0, x = -1024, y = -22, w = 1315, h = 1124, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel1",	loop = 300, op = {-21}, timer = 31,	dst = {{time = 0, x = 0, y = -22, w = 1315, h = 1124, acc = 2},{time = 300, x = -1315}}},
		--{id = "default_optionpanel_option_target",	blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 27, y = 40, w = 170, h = 550}}},
		{id = "default_optionpanel_option_random",	blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 318, y = 40, w = 170, h = 600}}},
		{id = "default_optionpanel_option_gauge",	blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 518, y = 290, w = 170, h = 300}}},
		{id = "default_optionpanel_option_hsfix",	blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 918, y = 340, w = 170, h = 250}}},
		{id = "default_optionpanel_option_random2",	blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 1118, y = 40, w = 170, h = 600}}},
		{id = "default_optionpanel_option_dp",		blend = 2,loop = 300,	op = {21}, timer = 21,	dst = {{time = 300, x = 718, y = 390, w = 170, h = 200}}},

		{id = -110, loop = 300, op = {22}, timer = 22,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 168},}},
		{id = -110, loop = 300, op = {-22}, timer = 32,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 168},{time = 300, a = 0}}},
		{id = "default_optionpanel_option_panel2",		loop = 300,	op = {22}, timer = 22, dst = {{time = 0, x = -1024, y = 28, w = 1024, h = 1024, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel2",		loop = 300,	op = {-22}, timer = 32, dst = {{time = 0, x = 0, y = 28, w = 1024, h = 1024, acc = 2},{time = 300, x = -1024}}},
		{id = "default_optionpanel_option_exjudge",		blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 207 + op2_cursor_pos.x, y = 277 - op2_cursor_pos.y2, w = 210, h = 100}}},
		{id = "default_optionpanel_option_constant",	blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 311 + op2_cursor_pos.x, y = 758 - op2_cursor_pos.y, w = 210, h = 100}}},
		{id = "default_optionpanel_option_judgearea",	blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 407 + op2_cursor_pos.x, y = 277 - op2_cursor_pos.y2, w = 210, h = 100}}},
		{id = "default_optionpanel_option_legacy",		blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 507 + op2_cursor_pos.x, y = 758 - op2_cursor_pos.y, w = 210, h = 100}}},
		{id = "default_optionpanel_option_marknote",	blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 607 + op2_cursor_pos.x, y = 277 - op2_cursor_pos.y2, w = 210, h = 100}}},
		{id = "default_optionpanel_option_bpmguide",	blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 703 + op2_cursor_pos.x, y = 758 - op2_cursor_pos.y, w = 210, h = 100}}},
		{id = "default_optionpanel_option_nomine",		blend = 2,	loop = 300,	op = {22}, timer = 22, dst = {{time = 300, x = 807 + op2_cursor_pos.x, y = 277 - op2_cursor_pos.y2, w = 210, h = 100}}},

		{id = -110, loop = 300, op = {23}, timer = 23,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 300, a = 168},}},
		{id = -110, loop = 300, op = {-23}, timer = 33,	dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 168},{time = 300, a = 0}}},
		{id = "default_optionpanel_option_panel3",	loop = 300, op = {23}, timer = 23,	dst = {{time = 0, x = -1024, y = 56, w = 1024, h = 1024, acc = 2},{time = 300, x = 0}}},
		{id = "default_optionpanel_option_panel3",	loop = 300, op = {-23}, timer = 33,	dst = {{time = 0, x = 0, y = 56, w = 1024, h = 1024, acc = 2},{time = 300, x = -1024}}},
		{id = "default_optionpanel_option_gas",		blend = 2,	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 121, y = 764, w = 406, h = 250}}},
		{id = "default_optionpanel_option_bga",		blend = 2,	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 220, y = 128, w = 210, h = 150}}},
		{id = "default_optionpanel_option_adjust",	blend = 2,	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 460, y = 128, w = 210, h = 150}}},
		{id = "default_optionpanel_duration",		loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 590, y = 779, w = 20, h = 21, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_duration_green",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 690, y = 779, w = 20, h = 21, a = 0},{time = 300, a = 255}}},
		{id = "default_optionpanel_judgetiming",	loop = 300,	op = {23}, timer = 23,	dst = {{time = 300, x = 786, y = 242, w = 20, h = 21, a = 0},{time = 300, a = 255}}},
		
		{id = "default_optionpanel_option_message_1", timer = op_timer.dp,		dst = {{x = 1304, y = 50, w = 512, h = 128, a = 255}}},
		{id = "default_optionpanel_option_message_2", timer = op_timer.assist,	dst = {{x = 1304, y = 50, w = 512, h = 128, a = 255}}},
		{id = "default_optionpanel_option_message_3", timer = op_timer.ex,		dst = {{x = 1304, y = 50, w = 512, h = 128, a = 255}}},
		{id = "default_optionpanel_option_message_1", timer = op_timer.dop,		dst = {{x = 1304, y = 150, w = 512, h = 128, a = 255}}},
	}
	
	for i, v in pairs(parts.text) do
		table.insert(parts.destination, {id = "default_optionpanel_target_" .. i, loop = 300, op = {21}, timer = 21, dst = {{time = 300, x = 36, y = 920 - (41 * (i - 1)), w = 260, h = 18, a = 192}}})
	end
	
	parts.customTimers = {
		{id = op_timer.assist},
		{id = op_timer.dp},
		{id = op_timer.dop},
		{id = op_timer.ex},
		{id = get_customTimer_id(), timer = function()
			-- DPオプションの監視
			if	main_state.event_index(54) == 0
			or	main_state.event_index(54) == 1 then
				main_state.set_timer(op_timer.dp, TOV)
			else
				main_state.set_timer(op_timer.dp, main_state.time())
			end
			-- アシストオプションの監視
			if	main_state.event_index(301) == 0
			and	main_state.event_index(302) == 0
			and	main_state.event_index(303) == 0
			and	main_state.event_index(304) == 0
			and	main_state.event_index(305) == 0
			and	main_state.event_index(306) == 0
			and	main_state.event_index(307) == 0
			then
				main_state.set_timer(op_timer.assist, TOV)
			else
				if main_state.timer(op_timer.ex) == TOV then
					main_state.set_timer(op_timer.assist, main_state.time())
				end
			end
			-- EXオプションの監視
			if	main_state.event_index(350) == 0
			and	(main_state.event_index(351) == 0 or main_state.event_index(351) == 1)
			and	(main_state.event_index(352) == 0 or main_state.event_index(352) == 1)
			and	(main_state.event_index(353) == 0 or main_state.event_index(353) == 1)
			then
				main_state.set_timer(op_timer.ex, TOV)
			else
				main_state.set_timer(op_timer.ex, main_state.time())
			end
			-- 2つONの時
			if (main_state.timer(op_timer.assist)	~= TOV and main_state.timer(op_timer.dp) ~= TOV)
			or (main_state.timer(op_timer.ex)		~= TOV and main_state.timer(op_timer.dp) ~= TOV)
			then
				main_state.set_timer(op_timer.dop, main_state.time())
			else
				main_state.set_timer(op_timer.dop, TOV)
			end
		end}
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}
