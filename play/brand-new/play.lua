local main_state = require("main_state")

local OP = 899
local function op_count()
	OP = OP + 1
	return OP
end

local OFFSET = 59
local function offset_count()
	OFFSET = OFFSET + 1
	return OFFSET
end

local SC_SIDE	= "ターンテーブルの位置(SP)"
local SC_LEFT	= op_count()
local SC_RIGHT	= op_count()

local BGA_SIZE		= "BGAの表示サイズ"
local BGA_SD		= op_count()
local BGA_WIDE		= op_count()
local BGA_FULL		= op_count()

local MASCOT_DISP	= "マスコットの表示"
local MASCOT_DANCER = op_count()
local MASCOT_MOVING = op_count()

local LASER_OFFSET	= offset_count()
local LANE_OFFSET	= offset_count()
local FILTER_OFFSET	= offset_count()

local header = {
	--[[
		スキンタイプ
		0:7keys
		1:5keys
		2:14keys
		3:10keys
		4:9keys
		12:7keys_battle
		13:5keys_battle
		14:9keys_battle
		16:24keys
		17:48keys
		18:24keys_battle
	--]]
	type = 0, -- .luaskinで指定する
	name = "brand-new (m-select)",
	w = 1920,
	h = 1080,
	playstart = 1000,
	scene = 3600000,
	input = 500,
	close = 1500,
	fadeout	 = 1000,
	property = {
		{name = SC_SIDE, item = {
			{name = "左", op = SC_LEFT},
			{name = "右", op = SC_RIGHT}
		},def = "右"},
		{name = BGA_SIZE, item = {
			{name = "縦幅に合わせる", op = BGA_SD},
			{name = "横幅に合わせる", op = BGA_WIDE},
			{name = "縦横比を無視する", op = BGA_FULL}
		}},
		{name = MASCOT_DISP, item = {
			{name = "ダンサー", op = MASCOT_DANCER},
			{name = "動くマスコット", op = MASCOT_MOVING}
		}}
	},
	filepath = {
		{name = "背景",				path = "customize/background/*"},
		{name = "キービーム",		path = "customize/ModernChic/laser/*.png"},
		{name = "ノーツ",			path = "customize/ModernChic/notes/*.png"},
		{name = "地雷",				path = "customize/ModernChic/mine/*.png"},
		{name = "判定文字",			path = "customize/ModernChic/judge/*.png"},
		{name = "レーンカバー",		path = "customize/cover/*"},
		{name = "ボム",				path = "customize/ModernChic/bomb/*.png"},
		{name = "汎用BGA-BGI",		path = "customize/bga_bgi/*"},
		{name = "ダンサー",			path = "customize/dance/*"},
		{name = "動くマスコット",	path = "customize/moving_mascot/*.png"}
	},
	offset = {
		{name = "キービーム",		id = LASER_OFFSET, h = true, a = true},
		{name = "レーン",			id = LANE_OFFSET, a = true},
		{name = "画面フィルター",	id = FILTER_OFFSET, a = true}
	}
}

local function main()
	
	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end
	
	local function isLeftSc()		return skin_config.option[SC_SIDE] == SC_LEFT end
	local function isRightSc()		return skin_config.option[SC_SIDE] == SC_RIGHT end
	local function is7keys()		return skin.type == 0 end
	local function is5keys()		return skin.type == 1 end
	local function isDoubleplay()	return skin.type == 2 or skin.type == 3 end
	local function is14keys()		return skin.type == 2 end
	local function is10keys()		return skin.type == 3 end
	local function is7keysLeftSc()	return skin.type == 0 and isLeftSc() end
	local function is7keysRightSc()	return skin.type == 0 and isRightSc() end
	local function is5keysLeftSc()	return skin.type == 1 and isLeftSc() end
	local function is5keysRightSc()	return skin.type == 1 and isRightSc() end
	
	local dancer_path = skin_config.get_path("customize/dance/*") .. "/parts.lua"
	local dancer_settings = dofile(dancer_path)
	
	local geometry = {}
	geometry.lanes_x = 67
	if isLeftSc() then
		geometry.keys_x = 197
		geometry.scratch_x = 67
		geometry.rotate_x = 117
		geometry.lane_x_7 = {197,242,273,328,349,414,425,67}
		geometry.lane_x_5 = {197,245,273,335,349,67}
	elseif isRightSc() then
		geometry.keys_x = 67
		if is5keys() then
			geometry.keys_x = 143
			geometry.lanes_x = 143
		end
		geometry.scratch_x = 369
		geometry.rotate_x = 419
		geometry.lane_x_7 = {67,112,143,198,219,284,295,371}
		geometry.lane_x_5 = {143,191,219,281,295,371}
	end
	
	--[[ TODO
	if isDoubleplay() then
		geometry.lanes_x_1p		= 67
		geometry.lanes_x_2p		= 67
		geometry.keys_x_1p		= 197
		geometry.keys_x_2p		= 197
		geometry.scratch_x_1p	= 67
		geometry.scratch_x_2p	= 67
		geometry.rotate_x_1p	= 117
		geometry.rotate_x_2p	= 117
		geometry.lane_x_14		= {}
		geometry.lane_x_10		= {}
	end
	--]]
	
	geometry.bomb_x_7 = {}
	geometry.bomb_x_5 = {}
	geometry.bomb_x_14 = {}
	geometry.bomb_x_10 = {}
	do
		local bomb_shift_7 = {37,20,37,20,37,20,37,64}
		local bomb_shift_5 = {37,20,37,20,37,64}
		for i, v in ipairs(bomb_shift_7) do
			geometry.bomb_x_7[i]		= geometry.lane_x_7[i] - 200 + v
			--geometry.bomb_x_14[i]		= geometry.lane_x_14[i] - 200 + v
			--geometry.bomb_x_14[i + 8]	= geometry.lane_x_14[i + 8] - 200 + v
		end
		for i, v in ipairs(bomb_shift_5) do
			geometry.bomb_x_5[i] = geometry.lane_x_5[i] - 200 + v
			--geometry.bomb_x_10[i] = geometry.lane_x_10[i] - 200 + v
			--geometry.bomb_x_10[i + 6] = geometry.lane_x_10[i + 6] - 200 + v
		end
	end
	geometry.lanes_width = 432
	if is5keys() then geometry.lanes_width = 356 end
	geometry.judge_x = 169
	if		is5keysLeftSc()	then geometry.judge_x = geometry.judge_x - 39
	elseif	is5keysRightSc()	then geometry.judge_x = geometry.judge_x + 39
	end
	geometry.ready_x = geometry.lanes_x + (geometry.lanes_width / 2) - 115
	
	local function start_flag()
		if main_state.number(101) > 0 then
			return false
		else
			return true
		end
	end
	
	skin.source = {
		{id = "src-bg",			path = "customize/background/*"},
		{id = "src-parts",		path = "parts/parts.png"},
		{id = "src-laser",		path = "customize/ModernChic/laser/*.png"},
		{id = "src-notes",		path = "customize/ModernChic/notes/*.png"},
		{id = "src-mine",		path = "customize/ModernChic/mine/*.png"},
		{id = "src-judge",		path = "customize/ModernChic/judge/*.png"},
		{id = "src-lanecover",	path = "customize/cover/*"},
		{id = "src-bomb",		path = "customize/ModernChic/bomb/*.png"},
		{id = "src-bga",		path = "customize/bga_bgi/*"},
		{id = "src-dance",		path = "customize/dance/*" .. "/" .. dancer_settings.filename},
		{id = "src-moving",		path = "customize/moving_mascot/*.png"},
		{id = "src-filter",		path = "parts/filter.png"}
	}
	
	skin.image = {
		{id = "background",	src = "src-bg", x = 0, y = 0, w = -1, h = -1},
		
		{id = "frame-lane",	src = "src-parts", x = 0, y = 0, w = 502, h = 1080},
		{id = "scratch",	src = "src-parts", x = 0, y = 1096, w = 130, h = 133},		
		{id = "rotate",		src = "src-parts", x = 902, y = 1096, w = 30, h = 30},
		
		{id = "7keys",			src = "src-parts", x = 128, y = 1096, w = 302, h = 133},
		{id = "7keys-on-w1",	src = "src-parts", x = 558, y = 1096, w = 74, h = 133},
		{id = "7keys-on-w3",	src = "src-parts", x = 634, y = 1096, w = 74, h = 133},
		{id = "7keys-on-w5",	src = "src-parts", x = 710, y = 1096, w = 74, h = 133},
		{id = "7keys-on-w7",	src = "src-parts", x = 786, y = 1096, w = 74, h = 133},
		
		{id = "5keys",			src = "src-parts", x = 934, y = 1096, w = 226, h = 133},
		{id = "5keys-on-w1",	src = "src-parts", x = 1160, y = 1096, w = 74, h = 133},
		{id = "5keys-on-w3",	src = "src-parts", x = 1236, y = 1096, w = 74, h = 133},
		{id = "5keys-on-w5",	src = "src-parts", x = 1312, y = 1096, w = 74, h = 133},
		
		{id = "keyon-b",	src = "src-parts", x = 860, y = 1096, w = 40, h = 133},
		{id = "keyon-s",	src = "src-parts", x = 430, y = 1096, w = 130, h = 133},
		
		{id = "judgeline",	src = "src-parts", x = 0, y = 1229, w = 542, h = 36},
		
		{id = "lane1p",		src = "src-parts", x = 0, y = 1080, w = 432, h = 8},
		{id = "lane2p",		src = "src-parts", x = 0, y = 1088, w = 432, h = 8},
		
		{id = "disable-left",	src = "src-parts", x = 1871, y = 0, w = 79, h = 1036},
		{id = "disable-right",	src = "src-parts", x = 1792, y = 0, w = 79, h = 1036},
		
		{id = "laser-w", src = "src-laser", x = 0, y = 0, w = 60, h = 564},
		{id = "laser-b", src = "src-laser", x = 70, y = 0, w = 48, h = 564},
		{id = "laser-s", src = "src-laser", x = 130, y = 0, w = 108, h = 564},
		
		{id = "note-w", src = "src-notes", x = 216, y = 0, w = 60, h = 36},
		{id = "note-b", src = "src-notes", x = 276, y = 0, w = 48, h = 36},
		{id = "note-s", src = "src-notes", x = 108, y = 0, w = 108, h = 36},
		
		{id = "lne-w", src = "src-notes", x = 216, y = 36, w = 60, h = 36},
		{id = "lne-b", src = "src-notes", x = 276, y = 36, w = 48, h = 36},
		{id = "lne-s", src = "src-notes", x = 108, y = 36, w = 108, h = 36},
		
		{id = "lns-w", src = "src-notes", x = 216, y = 72, w = 60, h = 36},
		{id = "lns-b", src = "src-notes", x = 276, y = 72, w = 48, h = 36},
		{id = "lns-s", src = "src-notes", x = 108, y = 72, w = 108, h = 36},
		
		{id = "lnb-w", src = "src-notes", x = 216, y = 144, w = 60, h = 72, divy = 2, cycle = 200},
		{id = "lnb-b", src = "src-notes", x = 276, y = 144, w = 48, h = 72, divy = 2, cycle = 200},
		{id = "lnb-s", src = "src-notes", x = 108, y = 144, w = 108, h = 72, divy = 2, cycle = 200},
		
		{id = "lna-w", src = "src-notes", x = 216, y = 108, w = 60, h = 36},
		{id = "lna-b", src = "src-notes", x = 276, y = 108, w = 48, h = 36},
		{id = "lna-s", src = "src-notes", x = 108, y = 108, w = 108, h = 36},
		
		{id = "hcne-w", src = "src-notes", x = 216, y = 216, w = 60, h = 36},
		{id = "hcne-b", src = "src-notes", x = 276, y = 216, w = 48, h = 36},
		{id = "hcne-s", src = "src-notes", x = 108, y = 216, w = 108, h = 36},
		
		{id = "hcns-w", src = "src-notes", x = 216, y = 252, w = 60, h = 36},
		{id = "hcns-b", src = "src-notes", x = 276, y = 252, w = 48, h = 36},
		{id = "hcns-s", src = "src-notes", x = 108, y = 252, w = 108, h = 36},
		
		{id = "hcnb-w", src = "src-notes", x = 216, y = 288, w = 60, h = 36, divy = 2, cycle = 200},
		{id = "hcnb-b", src = "src-notes", x = 276, y = 288, w = 48, h = 36, divy = 2, cycle = 200},
		{id = "hcnb-s", src = "src-notes", x = 108, y = 288, w = 108, h = 36, divy = 2, cycle = 200},
		
		{id = "hcna-w", src = "src-notes", x = 216, y = 288, w = 60, h = 18},
		{id = "hcna-b", src = "src-notes", x = 276, y = 288, w = 48, h = 18},
		{id = "hcna-s", src = "src-notes", x = 108, y = 288, w = 108, h = 18},
		
		{id = "hcnr-w", src = "src-notes", x = 216, y = 324, w = 60, h = 36, divy = 2, cycle = 200},
		{id = "hcnr-b", src = "src-notes", x = 276, y = 324, w = 48, h = 36, divy = 2, cycle = 200},
		{id = "hcnr-s", src = "src-notes", x = 108, y = 324, w = 108, h = 36, divy = 2, cycle = 200},
		
		{id = "hcnd-w", src = "src-notes", x = 216, y = 288, w = 60, h = 36, divy = 2, cycle = 100},
		{id = "hcnd-b", src = "src-notes", x = 276, y = 288, w = 48, h = 36, divy = 2, cycle = 100},
		{id = "hcnd-s", src = "src-notes", x = 108, y = 288, w = 108, h = 36, divy = 2, cycle = 100},
		
		{id = "mine-w", src = "src-mine", x = 216, y = 0, w = 60, h = 36},
		{id = "mine-b", src = "src-mine", x = 276, y = 0, w = 48, h = 36},
		{id = "mine-s", src = "src-mine", x = 108, y = 0, w = 108, h = 36},
		
		{id = "section-line", src = "src-parts", x = 542, y = 1229, w = 1, h = 1},
		
		{id = "finishcover", src = "src-lanecover", x = 0, y = 0, w = -1, h = -1},
		
		{id = "judgef-pg", src = "src-judge", x = 0, y = 0, w = 227, h = 252, divy = 3, cycle = 120},
		{id = "judgef-gr", src = "src-judge", x = 0, y = 252, w = 227, h = 168, divy = 2, cycle = 80},
		{id = "judgef-gd", src = "src-judge", x = 0, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
		{id = "judgef-bd", src = "src-judge", x = 227, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
		{id = "judgef-pr", src = "src-judge", x = 454, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
		{id = "judgef-ms", src = "src-judge", x = 454, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
		
		{id = "bomb-1", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 51, cycle = 251},
		{id = "bomb-2", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 52, cycle = 251},
		{id = "bomb-3", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 53, cycle = 251},
		{id = "bomb-4", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 54, cycle = 251},
		{id = "bomb-5", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 55, cycle = 251},
		{id = "bomb-6", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 56, cycle = 251},
		{id = "bomb-7", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 57, cycle = 251},
		{id = "bomb-s", src = "src-bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 50, cycle = 251},
		
		{id = "hold-1", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 71, cycle = 160},
		{id = "hold-2", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 72, cycle = 160},
		{id = "hold-3", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 73, cycle = 160},
		{id = "hold-4", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 74, cycle = 160},
		{id = "hold-5", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 75, cycle = 160},
		{id = "hold-6", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 76, cycle = 160},
		{id = "hold-7", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 77, cycle = 160},
		{id = "hold-s", src = "src-bomb", x = 0, y = 0, w = 3200, h = 300, divx = 8, timer = 70, cycle = 160},
		
		{id = "000000", src = "src-parts", x = 550, y = 980, w = 144, h = 24},
		
		{id = "frame-bga", src = "src-parts", x = 502, y = 0, w = 1290, h = 952},
		
		{id = "bga-bgi", src = "src-bga", x = 0, y = 0, w = -1, h = -1},
		
		{id = "gauge-n1", src = "src-parts", x = 502, y = 952, w = 12, h = 26},
		{id = "gauge-n2", src = "src-parts", x = 514, y = 952, w = 12, h = 26},
		{id = "gauge-n3", src = "src-parts", x = 526, y = 952, w = 12, h = 26},
		{id = "gauge-n4", src = "src-parts", x = 538, y = 952, w = 12, h = 26},
		{id = "gauge-e1", src = "src-parts", x = 502, y = 978, w = 12, h = 26},
		{id = "gauge-e2", src = "src-parts", x = 514, y = 978, w = 12, h = 26},
		{id = "gauge-e3", src = "src-parts", x = 526, y = 978, w = 12, h = 26},
		{id = "gauge-e4", src = "src-parts", x = 538, y = 978, w = 12, h = 26},
		
		{id = "dance1",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 11},
		{id = "dance2",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 10},
		{id = "dance3",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 9},
		{id = "dance4",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 8},
		{id = "dance5",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 7},
		{id = "dance6",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 6},
		{id = "dance7",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 5},
		{id = "dance8",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 4},
		{id = "dance9",		src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 3},
		{id = "dance10",	src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min * 2},
		{id = "dance11",	src = "src-dance", x = 0, y = 0, w = -1, h = -1, divx = dancer_settings.divx, divy = dancer_settings.divy, cycle = dancer_settings.cycle_min},
		
		{id = "moving-mascot", src = "src-moving", x = 0, y = 0, w = 1344, h = 271, divx = 8, cycle = 1000},
		
		{id = "ready", src = "src-parts", x = 550, y = 952, w = 230, h = 27},
		
		{id = "filter",	src = "src-filter", x = 0, y = 0, w = -1, h = -1},
	}

	skin.value = {
		{id = "exscore",	src = "src-parts", x = 0, y = 1265, w = 264, h = 24, divx = 11, digit = 6, ref = 71},
		{id = "gaugevalue",	src = "src-parts", x = 0, y = 1289, w = 260, h = 28, divx = 10, digit = 3, ref = 107},
		{id = "nowbpm",		src = "src-parts", x = 0, y = 1317, w = 400, h = 55, divx = 10, digit = 4, align = 2, ref = 160},
		
		--[[
		{id = "judgen-pg", src = "src-judge", x = 227, y = 0, w = 550, h = 252, divx = 10, divy = 3, digit = 6, ref = 75, cycle = 120},
		{id = "judgen-gr", src = "src-judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
		{id = "judgen-gd", src = "src-judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
		{id = "judgen-bd", src = "src-judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
		{id = "judgen-pr", src = "src-judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
		{id = "judgen-ms", src = "src-judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80}
		--]]
		{id = "judgen-dummy", src = "src-judge", x = 2048, y = 2048, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80}
	}
	
	skin.slider = {
		{id = "lanecover", src = "src-lanecover", x = 0, y = 0, w = -1, h = -1, angle = 2, range = 900, type = 4},
		{id = "song-progress", src = "src-parts", x = 502, y = 1060, w = 10, h = 20, angle = 2, range = 780, type = 6}
	}
	
	if is7keys() then
		skin.note = {
			id			= "notes",
			note		= {"note-w", "note-b", "note-w", "note-b", "note-w", "note-b", "note-w", "note-s"},
			lnend		= {"lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s"},
			lnstart		= {"lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s"},
			lnbody		= {"lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s"},
			lnactive	= {"lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s"},
			hcnend		= {"hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s"},
			hcnstart	= {"hcns-w", "hcns-b", "hcns-w", "hcns-b", "hcns-w", "hcns-b", "hcns-w", "hcns-s"},
			hcnbody		= {"hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s"},
			hcnactive	= {"hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s"},
			hcndamage	= {"hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s"},
			hcnreactive	= {"hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s"},
			mine		= {"mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-s"},
			hidden		= {},
			processed	= {},
			dst			= {
				{x = geometry.lane_x_7[1], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_7[2], y = 168, w = 40, h = 912},
				{x = geometry.lane_x_7[3], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_7[4], y = 168, w = 40, h = 912},
				{x = geometry.lane_x_7[5], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_7[6], y = 168, w = 40, h = 912},
				{x = geometry.lane_x_7[7], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_7[8], y = 168, w = 128, h = 912}
			},
			group		= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 1, r = 128,	g = 128, b = 128}}}},
			time		= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 1, r = 64,	g = 192, b = 192}}}},
			bpm			= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 2, r = 0,	g = 192, b = 0}}}},
			stop		= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 2, r = 192,	g = 192, b = 0}}}}
		}
	elseif is5keys() then
		skin.note = {
			id				= "notes",
			note			= {"note-w", "note-b", "note-w", "note-b", "note-w", "note-s"},
			lnend			= {"lne-w", "lne-b", "lne-w", "lne-b", "lne-w", "lne-s"},
			lnstart			= {"lns-w", "lns-b", "lns-w", "lns-b", "lns-w", "lns-s"},
			lnbody			= {"lnb-w", "lnb-b", "lnb-w", "lnb-b", "lnb-w", "lnb-s"},
			lnactive		= {"lna-w", "lna-b", "lna-w", "lna-b", "lna-w", "lna-s"},
			hcnend			= {"hcne-w", "hcne-b", "hcne-w", "hcne-b", "hcne-w", "hcne-s"},
			hcnstart		= {"hcns-w", "hcns-b", "hcns-w", "hcns-b", "hcns-w", "hcns-s"},
			hcnbody			= {"hcnb-w", "hcnb-b", "hcnb-w", "hcnb-b", "hcnb-w", "hcnb-s"},
			hcnactive		= {"hcna-w", "hcna-b", "hcna-w", "hcna-b", "hcna-w", "hcna-s"},
			hcndamage		= {"hcnd-w", "hcnd-b", "hcnd-w", "hcnd-b", "hcnd-w", "hcnd-s"},
			hcnreactive		= {"hcnr-w", "hcnr-b", "hcnr-w", "hcnr-b", "hcnr-w", "hcnr-s"},
			mine			= {"mine-w", "mine-b", "mine-w", "mine-b", "mine-w", "mine-s"},
			hidden			= {},
			processed		= {},
			dst				= {
				{x = geometry.lane_x_5[1], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_5[2], y = 168, w = 40, h = 912},
				{x = geometry.lane_x_5[3], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_5[4], y = 168, w = 40, h = 912},
				{x = geometry.lane_x_5[5], y = 168, w = 74, h = 912},
				{x = geometry.lane_x_5[6], y = 168, w = 128, h = 912}
			},
			--expansionrate	= {120, 120},
			group			= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 1, r = 128,	g = 128, b = 128}}}},
			time			= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 1, r = 64,	g = 192, b = 192}}}},
			bpm				= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 2, r = 0,	g = 192, b = 0}}}},
			stop			= {{id = "section-line", offset = 3, dst = {{x = geometry.lanes_x, y = 180, w = geometry.lanes_width, h = 2, r = 192,	g = 192, b = 0}}}}
		}
	end
	
	skin.gauge = {id = "gauge", nodes = {"gauge-n1","gauge-n2","gauge-n3","gauge-n4","gauge-e1","gauge-e2","gauge-e3","gauge-e4"}, parts = 100}
	
	skin.judge = {{
		id = "judge",
		index = 0,
		images = {
			{id = "judgef-pg", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			--{id = "judgef-gr", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			{id = "judgef-pg", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			{id = "judgef-gd", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			{id = "judgef-bd", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			{id = "judgef-pr", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}},
			{id = "judgef-ms", loop = -1, timer = 46 ,offsets = {3, 32}, dst = {{time = 0, x = geometry.judge_x, y = 260, w = 227, h = 84},{time = 500}}}
		},
		numbers = {
			--[[
			{id = "judgen-pg", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-gr", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-gd", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-bd", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x =-237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-pr", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x =-237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-ms", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}}
			--]]
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x =-237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x =-237, y = 0, w = 55, h = 84},{time = 500}}},
			{id = "judgen-dummy", loop = -1, timer = 46,offsets = {3, 32},  dst = {{time = 0, x = 237, y = 0, w = 55, h = 84},{time = 500}}}
		},
		--shift = true
		shift = false
	}}
	
	skin.bga = {id = "bga"}
	
	skin.judgegraph = {{id = "judgegraph", type = 1, backTexOff = 1}}
	
	skin.bpmgraph = {{id = "bpmgraph"}}
	
	skin.destination = {
		{id = "background", stretch = 3, dst = {{x = 0, y = 0, w = 1920, h = 1080}}},
		
		{id = "frame-lane",	dst = {{x = 32, y = 0, w = 502, h = 1080}}},
		
		{id = "scratch",			dst = {{x = geometry.scratch_x, y = 47, w = 130, h = 133}}},
		{id = "rotate", offset = 1,	dst = {{x = geometry.rotate_x, y = 97, w = 30, h = 30}}},
		
		{id = "7keys",									draw = function() return is7keys() end, dst = {{x = geometry.keys_x, y = 47, w = 302, h = 133}}},
		{id = "7keys-on-w1",	timer = 101, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[1], y = 47, w = 74, h = 133}}},
		{id = "7keys-on-w3",	timer = 103, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[3], y = 47, w = 74, h = 133}}},
		{id = "7keys-on-w5",	timer = 105, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[5], y = 47, w = 74, h = 133}}},
		{id = "7keys-on-w7",	timer = 107, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[7], y = 47, w = 74, h = 133}}},
		{id = "keyon-b",		timer = 102, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[2], y = 47, w = 40, h = 133}}},
		{id = "keyon-b",		timer = 104, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[4], y = 47, w = 40, h = 133}}},
		{id = "keyon-b",		timer = 106, blend = 2,	draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[6], y = 47, w = 40, h = 133}}},
		{id = "keyon-s",		timer = 100, blend = 2,	draw = function() return is7keysLeftSc() end, dst = {{x = geometry.lane_x_7[8], y = 47, w = 130, h = 133}}},
		{id = "keyon-s",		timer = 100, blend = 2,	draw = function() return is7keysRightSc() end, dst = {{x = geometry.lane_x_7[8] - 2, y = 47, w = 130, h = 133}}},
		
		{id = "5keys",									draw = function() return is5keys() end, dst = {{x = geometry.keys_x, y = 47, w = 226, h = 133}}},
		{id = "5keys-on-w1",	timer = 101, blend = 2,	draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[1], y = 47, w = 74, h = 133}}},
		{id = "5keys-on-w3",	timer = 103, blend = 2,	draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[3], y = 47, w = 74, h = 133}}},
		{id = "5keys-on-w5",	timer = 105, blend = 2,	draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[5], y = 47, w = 74, h = 133}}},
		{id = "keyon-b",		timer = 102, blend = 2,	draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[2], y = 47, w = 40, h = 133}}},
		{id = "keyon-b",		timer = 104, blend = 2,	draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[4], y = 47, w = 40, h = 133}}},
		{id = "keyon-s",		timer = 100, blend = 2,	draw = function() return is5keysLeftSc() end, dst = {{x = geometry.lane_x_5[6], y = 47, w = 130, h = 133}}},
		{id = "keyon-s",		timer = 100, blend = 2,	draw = function() return is5keysRightSc() end, dst = {{x = geometry.lane_x_5[6] - 2, y = 47, w = 130, h = 133}}},
		
		{id = "judgeline", offset = 3, dst = {{x = 12, y = 168, w = 542, h = 36}}},
		
		{id = "lane1p", op = {SC_LEFT}, offset = LANE_OFFSET, dst = {{x = 67, y = 180, w = 432, h = 900, a = 64}}},
		{id = "lane2p", op = {SC_RIGHT}, offset = LANE_OFFSET, dst = {{x = 67, y = 180, w = 432, h = 900, a = 64}}},
		
		{id = "disable-left", draw = function() return is5keysRightSc() end, dst = {{x = 64, y = 44, w = 79, h = 1036}}},
		{id = "disable-right", draw = function() return is5keysLeftSc() end, dst = {{x = 423, y = 44, w = 79, h = 1036}}},
		
		{id = "laser-w", timer = 101, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[1], y = 180, w = 74, h = 564}}},
		{id = "laser-w", timer = 103, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[3], y = 180, w = 74, h = 564}}},
		{id = "laser-w", timer = 105, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[5], y = 180, w = 74, h = 564}}},
		{id = "laser-w", timer = 107, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[7], y = 180, w = 74, h = 564}}},
		{id = "laser-b", timer = 102, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[2], y = 180, w = 40, h = 564}}},
		{id = "laser-b", timer = 104, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[4], y = 180, w = 40, h = 564}}},
		{id = "laser-b", timer = 106, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[6], y = 180, w = 40, h = 564}}},
		{id = "laser-s", timer = 100, offsets = {3, LASER_OFFSET}, draw = function() return is7keys() end, dst = {{x = geometry.lane_x_7[8], y = 180, w = 128, h = 564}}},
		
		{id = "laser-w", timer = 101, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[1], y = 180, w = 74, h = 564}}},
		{id = "laser-w", timer = 103, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[3], y = 180, w = 74, h = 564}}},
		{id = "laser-w", timer = 105, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[5], y = 180, w = 74, h = 564}}},
		{id = "laser-b", timer = 102, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[2], y = 180, w = 40, h = 564}}},
		{id = "laser-b", timer = 104, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[4], y = 180, w = 40, h = 564}}},
		{id = "laser-s", timer = 100, offsets = {3, LASER_OFFSET}, draw = function() return is5keys() end, dst = {{x = geometry.lane_x_5[6], y = 180, w = 128, h = 564}}},
		
		{id = "notes"},
		
		{id = "lanecover", filter = 1, stretch = 3, dst = {{x = geometry.lanes_x, y = 1080, w = geometry.lanes_width, h = 900}}},
		--{id = "finishcover", timer = 143, loop = 1000, stretch = 3, dst = {{time = 0, x = geometry.lanes_x, y = 1080, w = geometry.lanes_width, h = 900, acc = 2},{time = 1000, y = 180}}},
		
		{id = "song-progress", dst = {{x = 45, y = 960, w = 10, h = 20}}},
		
		{id = "judge"},
		
		{id = "bomb-1", timer = 51, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[1], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-2", timer = 52, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[2], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-3", timer = 53, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[3], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-4", timer = 54, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[4], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-5", timer = 55, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[5], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-6", timer = 56, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[6], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-7", timer = 57, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[7], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-s", timer = 50, loop = -1, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{time = 0, x = geometry.bomb_x_7[8], y = 36, w = 400, h = 300},{time = 250}}},
		
		{id = "bomb-1", timer = 51, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[1], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-2", timer = 52, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[2], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-3", timer = 53, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[3], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-4", timer = 54, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[4], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-5", timer = 55, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[5], y = 36, w = 400, h = 300},{time = 250}}},
		{id = "bomb-s", timer = 50, loop = -1, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{time = 0, x = geometry.bomb_x_5[6], y = 36, w = 400, h = 300},{time = 250}}},
		
		{id = "hold-1", timer = 71, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[1], y = 36, w = 400, h = 300}}},
		{id = "hold-2", timer = 72, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[2], y = 36, w = 400, h = 300}}},
		{id = "hold-3", timer = 73, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[3], y = 36, w = 400, h = 300}}},
		{id = "hold-4", timer = 74, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[4], y = 36, w = 400, h = 300}}},
		{id = "hold-5", timer = 75, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[5], y = 36, w = 400, h = 300}}},
		{id = "hold-6", timer = 76, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[6], y = 36, w = 400, h = 300}}},
		{id = "hold-7", timer = 77, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[7], y = 36, w = 400, h = 300}}},
		{id = "hold-s", timer = 70, blend = 2, offset = 3, draw = function() return is7keys() end, dst = {{x = geometry.bomb_x_7[8], y = 36, w = 400, h = 300}}},
		
		{id = "hold-1", timer = 71, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[1], y = 36, w = 400, h = 300}}},
		{id = "hold-2", timer = 72, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[2], y = 36, w = 400, h = 300}}},
		{id = "hold-3", timer = 73, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[3], y = 36, w = 400, h = 300}}},
		{id = "hold-4", timer = 74, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[4], y = 36, w = 400, h = 300}}},
		{id = "hold-5", timer = 75, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[5], y = 36, w = 400, h = 300}}},
		{id = "hold-s", timer = 70, blend = 2, offset = 3, draw = function() return is5keys() end, dst = {{x = geometry.bomb_x_5[6], y = 36, w = 400, h = 300}}},
		
		{id = "000000", draw = function() return start_flag() end, dst = {{x = 337, y = 9, w = 144, h = 24}}},
		{id = "exscore", dst = {{x = 337, y = 9, w = 24, h = 24}}},
		
		{id = "frame-bga", dst = {{x = 566, y = 64, w = 1290, h = 952}}},
		
		{id = "bga",		stretch = 3, op = {BGA_SD, 171},				dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		{id = -110,						 op = {BGA_SD, 171},				dst = {{x = 571, y = 232, w = 1280, h = 720, a = 160}}},
		{id = "bga",		stretch = 1, op = {BGA_SD, 171},				dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		{id = "bga-bgi",	stretch = 3, timer = 41, op = {BGA_SD, 170},	dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		{id = -110,						 timer = 41, op = {BGA_SD, 170},	dst = {{x = 571, y = 232, w = 1280, h = 720, a = 160}}},
		{id = "bga-bgi",	stretch = 1, timer = 41, op = {BGA_SD, 170},	dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		
		{id = "bga",		stretch = 3, op = {BGA_WIDE, 171},				dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		{id = "bga-bgi",	stretch = 3, timer = 41, op = {BGA_WIDE, 170},	dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		
		{id = "bga",		stretch = 0, op = {BGA_FULL, 171},				dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		{id = "bga-bgi",	stretch = 0, timer = 41, op = {BGA_FULL, 170},	dst = {{x = 571, y = 232, w = 1280, h = 720}}},
		
		{id = "gaugevalue",	dst = {{x = 571, y = 178, w = 26, h = 28}}},
		{id = "gauge",		dst = {{x = 650, y = 179, w = 1200, h = 26}}},
		
		{id = "nowbpm",		dst = {{x = 711, y = 102, w = 40, h = 55}}},
		
		{id = "judgegraph",	dst = {{x = 903, y = 81, w = 900, h = 80}}},
		{id = "bpmgraph",	dst = {{x = 903, y = 81, w = 900, h = 80}}},
		
		{id = "dance1",		filter = 1, op = {230, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance2",		filter = 1, op = {231, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance3",		filter = 1, op = {232, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance4",		filter = 1, op = {233, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance5",		filter = 1, op = {234, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance6",		filter = 1, op = {235, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance7",		filter = 1, op = {236, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance8",		filter = 1, op = {237, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance9",		filter = 1, op = {238, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance10",	filter = 1, op = {239, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		{id = "dance11",	filter = 1, op = {240, MASCOT_DANCER}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		
		{id = "moving-mascot", filter = 1, op = {MASCOT_MOVING}, dst = {{x = 598, y = 80, w = 86, h = 86}}},
		
		{id = "ready", loop = -1, timer = 40, offset = 3, dst = {{time = 0, x = geometry.ready_x, y = 260, w = 230, h = 27, a = 0},{time = 100, a = 255},{time = 800},{time = 1000, y = 242, a = 0}}},
		
		{id = -110, loop = 500, timer = 3, dst = {{time = 0, x = 0, y = 1080, w = 1920, h = 1080},{time = 500, y = 0}}},
		{id = -110, loop = 500, timer = 2, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 500, a = 255}}},
		
		{id = "filter", blend = 4, offset = FILTER_OFFSET, dst = {{x = 0, y = 0, w = 1920, h = 1080, a = 160}}}
	}
	
	return skin
end

return {
	header = header,
	main = main
}
