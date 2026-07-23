main_state = require("main_state")
local header = {
	type = 0,
	name = "antique (m-select)",
	w = 1920,
	h = 1080,
	loadend = 3000,
	playstart = 1000,
	scene = 3600000,
	input = 0,
	close = 1000,
	fadeout = 1000,
	property = {
		{name = "スクラッチ", category = "op1", item = {
			{name = "左", op = 902},
			{name = "右", op = 903}
		}},
		{name = "グラフ反転", category = "op2", item = {
			{name = "OFF", op = 900},
			{name = "ON", op = 901}
		}},
		{name = "BGAフレーム", category = "op3", item = {
			{name = "OFF", op = 920},
			--{name = "DEFAULT", op = 921},
			{name = "GdbG", op = 922}
		}, def = "OFF"},
		{name = "配置", category = "op4", item = {
			{name = "レーン/グラフ/BGA", op = 910},
			{name = "レーン/BGA/グラフ", op = 911},
			{name = "グラフ/レーン/BGA", op = 912},
			{name = "BGA/グラフ/レーン", op = 913},
			{name = "グラフ/BGA/レーン", op = 914},
			{name = "BGA/レーン/グラフ", op = 915}
		}},
		{name = "ゴースト", category = "op5", item = {
			{name = "OFF", op = 904},
			{name = "ベスト", op = 905},
			{name = "ターゲット", op = 906},
			{name = "HIGH", op = 940},
			{name = "LOW", op = 941}
		}},
		{name = "FAST/SLOW", category = "op6", item = {
			{name = "OFF", op = 907},
			{name = "ON", op = 908}
		}},
		{name = "打鍵ログ(同梱リザルト用)", category = "op7", item = {
			{name = "OFF", op = 930},
			{name = "ON", op = 931}
		}, def = "OFF"},
		{name = "メトロノーム", category = "op8", item = {
			{name = "OFF", op = 932},
			{name = "ON", op = 933}
		}, def = "OFF"},
		{name = "打鍵音", category = "op9", item = {
			{name = "OFF", op = 934},
			{name = "ON", op = 935}
		}, def = "OFF"},
		{name = "レーンフレーム", category = "op10", item = {
			{name = "OFF", op = 950},
			{name = "ON", op = 951}
		}, def = "ON"},
		{name = "グラフフレーム", category = "op11", item = {
			{name = "OFF", op = 960},
			{name = "ON", op = 961}
		}, def = "ON"},
		{name = "BGAサイズ", category = "op12", item = {
			{name = "FULL(1080x1080)", op = 970},
			{name = "x4(1024x1024)", op = 971},
			{name = "x3(768x768)", op = 972},
			{name = "x2(512x512)", op = 973},
			{name = "x1(256x256)", op = 974},
			{name = "背景(1920x1080)", op = 975}
		}, def = "FULL(1080x1080)"},
		{name = "常に汎用BGA/BGIを表示する", category = "op13", item = {
			{name = "OFF", op = 980},
			{name = "ON", op = 981}
		}, def = "OFF"},
		{name = "ノーツタイプ", category = "op14", item = {
			{name = "BEAT", op = 990},
			{name = "O2", op = 991},
			{name = "SIXTAR", op = 992},
			{name = "SIXTAR(GateLaneColor-TypeA)", op = 993}
		}, def = "TYPE1(DEFAULT)"},
		{name = "コンボボイス", category = "op15", item = {
			{name = "OFF", op = 1000},
			{name = "VOICEVOX-春日部つむぎ", op = 1001}
		}, def = "OFF"},
		{name = "RANDOM配置表示", category = "op16", item = {
			{name = "OFF", op = 916},
			{name = "ON", op = 917}
		}, def = "ON"}
	},
	filepath = {
		{name = "ノーツ",				category = "file1", path = "../customize/notes/*.png",		def = "default"},
		{name = "地雷",					category = "file2", path = "../customize/mine/*.png",		def = "default"},
		{name = "判定文字",				category = "file3", path = "../customize/judge/*.png",		def = "default"},
		{name = "キービーム",			category = "file4", path = "../customize/keybeam/*.png|1|",	def = "default"},
		{name = "キービーム(PG)",		category = "file5", path = "../customize/keybeam/*.png|2|",	def = "default_pg"},
		{name = "ボム",					category = "file6", path = "../customize/bomb/*.png",		def = "photonring"},
		{name = "レーンカバー",			category = "file7", path = "../customize/cover/*.png|1|",	def = "default"},
		{name = "リフトカバー",			category = "file8", path = "../customize/cover/*.png|2|",	def = "default"},
		{name = "HIDDENカバー",			category = "file9", path = "../customize/cover/*.png|3|",	def = "default"},
		{name = "グラフ背景",			category = "file10", path = "../customize/graph_bg/*.png",	def = "default"},
		{name = "汎用BGA/BGI",			category = "file11", path = "../customize/bga_bgi/*",		def = "default"},
		{name = "判定ライン",			category = "file12", path = "../customize/judgeline/*",		def = "red"},
		{name = "グロー",				category = "file13", path = "../customize/glow/*",			def = "aqua"},
		{name = "キーフラッシュ",		category = "file14", path = "../customize/keyflash/*",		def = "aqua"},
		{name = "プログレス",			category = "file15", path = "../customize/progress/*",		def = "aqua"},
		{name = "スクラッチ",			category = "file16", path = "../customize/scratch/*",		def = "default"},
		{name = "グルーブゲージ",		category = "file17", path = "../customize/gauge/*",			def = "default"},
		{name = "フィニッシュカバー",	category = "file18", path = "../customize/cover/*.png|4|",	def = "default"}
	},
	offset = {
		{name = "レーンの明るさ(-255 ~ 0)",		category = "offset1", id = 50, a = true},
		{name = "グラフ背景の明るさ(-255 ~ 0)",	category = "offset2", id = 51, a = true},
		{name = "キービームの明るさ(-255 ~ 0)",	category = "offset3", id = 52, a = true},
		{name = "キービームの長さ",				category = "offset4", id = 53, h = true},
		{name = "BGAの明るさ(-255 ~ 0)",		category = "offset5", id = 54, a = true},
		{name = "小節線の明るさ(-255 ~ 0)",		category = "offset6", id = 55, a = true},
		{name = "判定文字の表示位置",			category = "offset7", id = 56, x = true, y = true},
		{name = "ゴーストの表示位置",			category = "offset8", id = 57, x = true, y = true},
		{name = "FAST/SLOWの表示位置",			category = "offset9", id = 58, x = true, y = true},
		{name = "レーンの表示位置",				category = "offset10", id = 59, x = true},
		{name = "グラフの表示位置",				category = "offset11", id = 60, x = true},
		{name = "BGAの表示位置",				category = "offset12", id = 61, x = true},
		{name = "ノーツの大きさ",				category = "offset13", id = 62, h = true},
		{name = "[ModernChic規格]-----------",	category = "separate1", id = 63},
		{name = "---------------------------",	category = "separate2", id = 64}
	},
	category = {
		{name = "オプション", item = {
			"op14",
			"op4",
			"op16",
			"op1",
			"op10",
			"offset10",
			"op11",
			"op2",
			"offset11",
			"op3",
			"op12",
			"op13",
			"offset12",
			"offset5",
			"op8",
			"op9",
			"op7",
			"op15"
		}},
		{name = "パーツ", item = {
			"separate1",
			"file1",
			"offset13",
			"file2",
			"file4",
			"file5",
			"offset3",
			"offset4",
			"file6",
			"file3",
			"offset7",
			"separate2",
			"offset1",
			"offset6",
			"file13",
			"file12",
			"op5",
			"offset8",
			"op6",
			"offset9",
			"file7",
			"file8",
			"file9",
			"file18",
			"file14",
			"file16",
			"file17",
			"file15",
			"file10",
			"offset2",
			"file11"
		}}
	}
}

local function main()
	
	local function append_all(t1, t2)
		for i, v in pairs(t2) do
			table.insert(t1, v)
		end
	end
	
	local function isScratchRight()		return skin_config.option["スクラッチ"] == 903 end
	local function isGraphRevers()		return skin_config.option["グラフ反転"] == 901 end
	local function isGdbGBgaFrame()		return skin_config.option["BGAフレーム"] == 922 end
	--local function isDefaultBgaFrame()	return skin_config.option["BGAフレーム"] == 921 end
	local function isType1() return skin_config.option["配置"] == 910 end
	local function isType2() return skin_config.option["配置"] == 911 end
	local function isType3() return skin_config.option["配置"] == 912 end
	local function isType4() return skin_config.option["配置"] == 913 end
	local function isType5() return skin_config.option["配置"] == 914 end
	local function isType6() return skin_config.option["配置"] == 915 end
	
	local function EnableLog()			return skin_config.option["打鍵ログ(同梱リザルト用)"] == 931 end
	local function EnableMetronome()	return skin_config.option["メトロノーム"] == 933 end
	local function EnableStrokeSound()	return skin_config.option["打鍵音"] == 935 end
	
	local function BGA_Full() return skin_config.option["BGAサイズ"] == 970 end
	local function BGA_BG() return skin_config.option["BGAサイズ"] == 975 end
	local function BGA_x4() return skin_config.option["BGAサイズ"] == 971 end
	local function BGA_x3() return skin_config.option["BGAサイズ"] == 972 end
	local function BGA_x2() return skin_config.option["BGAサイズ"] == 973 end
	local function BGA_x1() return skin_config.option["BGAサイズ"] == 974 end
	local function isGenericBGA() return skin_config.option["常に汎用BGA/BGIを表示する"] == 981 end

	local function isO2Notes() return skin_config.option["ノーツタイプ"] == 991 end
	local function isSixtarNotes_Type1() return skin_config.option["ノーツタイプ"] == 992 end
	local function isSixtarNotes_Type2() return skin_config.option["ノーツタイプ"] == 993 end
	
	local function EnableVoice() return skin_config.option["コンボボイス"] == 1001 end
	
	local value_offset = {}
	value_offset.lane = {
		a = skin_config.offset["レーンの明るさ(-255 ~ 0)"].a * -1
	}
	value_offset.graph_bg = {
		a = skin_config.offset["グラフ背景の明るさ(-255 ~ 0)"].a
	}
	value_offset.keybeam = {
		a = skin_config.offset["キービームの明るさ(-255 ~ 0)"].a,
		h = skin_config.offset["キービームの長さ"].h
	}
	value_offset.bga = {
		a = skin_config.offset["BGAの明るさ(-255 ~ 0)"].a * -1,
		x = skin_config.offset["BGAの表示位置"].x
	}
	value_offset.graph = {
		x = skin_config.offset["グラフの表示位置"].x
	}
	value_offset.play = {
		x = skin_config.offset["レーンの表示位置"].x
	}
	value_offset.section = {
		a = skin_config.offset["小節線の明るさ(-255 ~ 0)"].a
	}
	value_offset.judge = {
		x = skin_config.offset["判定文字の表示位置"].x,
		y = skin_config.offset["判定文字の表示位置"].y
	}
	value_offset.ghost = {
		x = skin_config.offset["ゴーストの表示位置"].x,
		y = skin_config.offset["ゴーストの表示位置"].y
	}
	value_offset.fs = {
		x = skin_config.offset["FAST/SLOWの表示位置"].x,
		y = skin_config.offset["FAST/SLOWの表示位置"].y
	}
	value_offset.notes = {
		h = skin_config.offset["ノーツの大きさ"].h
	}
	local note_param = {}
	note_param.size = {}
	for i = 1, 8 do
		table.insert(note_param.size, 36 + value_offset.notes.h)
	end
	note_param.lane_hight_offset = (36 + value_offset.notes.h) / 3
	
	local value_op = {}
	
	value_op.bga = {}	
	if BGA_x4() then		value_op.bga = {w = 1024, h = 1024}
	elseif BGA_x3() then	value_op.bga = {w = 768, h = 768}
	elseif BGA_x2() then	value_op.bga = {w = 512, h = 512}
	elseif BGA_x1() then	value_op.bga = {w = 256, h = 256}
	elseif BGA_BG() then	value_op.bga = {w = 1920, h = 1920}
	else					value_op.bga = {w = 1080, h = 1080}
	end
	
	local geo = {}
	
	--  配置パターン
	geo.bg			= {x = 0, y = 0, w = 1920, h = 1080}
	geo.bga			= {x = 840, y = 0, w = 1080, h = 1080}
	geo.graph		= {x = 588, y = 0, w = 250, h = 1080}
	geo.play		= {x = 6, y = 0, w = 587, h = 1080}
	if isType2() then
		geo.bga.x	= 588
		geo.graph.x	= 1668
		geo.play.x	= 6
	elseif isType3() then
		geo.bga.x	= 840
		geo.graph.x	= 9
		geo.play.x	= 258
	elseif isType4() then
		geo.bga.x	= 0
		geo.graph.x	= 1082
		geo.play.x	= 1330
	elseif isType5() then
		geo.bga.x	= 252
		geo.graph.x	= 0
		geo.play.x	= 1330
	elseif isType6() then
		geo.bga.x	= 0
		geo.graph.x	= 1660
		geo.play.x	= 1078
	end
	if BGA_BG() then
		geo.bga.x	= 0
		geo.bga.y	= -420
		geo.bga.w	= 1920
		geo.bga.h	= 1920
	end
	geo.bga.x	= geo.bga.x + value_offset.bga.x
	geo.graph.x	= geo.graph.x + value_offset.graph.x
	geo.play.x	= geo.play.x + value_offset.play.x
	
	geo.bga_main		= {x = geo.bga.x + (geo.bga.w / 2) - (value_op.bga.w / 2), y = geo.bga.y + (geo.bga.h / 2) - (value_op.bga.h / 2), w = value_op.bga.w, h = value_op.bga.h}
	geo.bga_bg			= {x = geo.bga.x + (geo.bga.w / 2) - (value_op.bga.w / 2), y = geo.bga.y + (geo.bga.h / 2) - (value_op.bga.h / 2), w = value_op.bga.w, h = value_op.bga.h, a = 64}
	if BGA_Full() then geo.backbmp = {x = geo.bga.x + 28, y = geo.bga.y + 28, w = 1024, h = 1024}
	else geo.backbmp = geo.bga_main end
	geo.bga_load		= {x = geo.bga.x + 18, y = 440, w = geo.bga.w, h = 200}
	geo.bga_play		= {x = geo.bga.x + 18, y = 962, w = geo.bga.w, h = 100, a = 0}
	geo.txt_load_scene	= {x = geo.bga.x + 414, y = 594, w = 702, h = 18}
	geo.txt_load_genre	= {x = geo.bga.x + 414, y = 566, w = 702, h = 18}
	geo.txt_load_title	= {x = geo.bga.x + 414, y = 494, w = 702, h = 60}
	geo.txt_load_artist	= {x = geo.bga.x + 414, y = 464, w = 702, h = 18}
	geo.txt_load_genre_def	= {x = geo.bga.x + 540, y = geo.bga_main.y + (value_op.bga.h / 24 * 19), w = value_op.bga.w - 64, h = 24}
	geo.txt_load_title_def	= {x = geo.bga.x + 540, y = geo.bga_main.y + (value_op.bga.h / 24 * 13), w = value_op.bga.w - 64, h = 60}
	geo.txt_load_artist_def	= {x = geo.bga.x + 540, y = geo.bga_main.y + (value_op.bga.h / 24 * 5), w = value_op.bga.w - 64, h = 30}
	geo.txt_play_scene		= {x = geo.bga.x + 267, y = 1040, w = 498, h = 12, a = 0}
	geo.txt_play_genre		= {x = geo.bga.x + 267, y = 1022, w = 498, h = 12, a = 0}
	geo.txt_play_title		= {x = geo.bga.x + 267, y = 991, w = 498, h = 24, a = 0}
	geo.txt_play_artist		= {x = geo.bga.x + 267, y = 971, w = 498, h = 12, a = 0}
	if isScratchRight() then geo.play.x = geo.play.x - 4 end
	geo.lane = {x = geo.play.x + 57, y = 353, w = 513, h = 727}
	if isScratchRight() then geo.lane.x = geo.lane.x - 40 end
	geo.scratch			= {x = geo.play.x + 80, y = 267, w = 34, h = 34}
	geo.num_gauge		= {x = geo.play.x + 432, y = 226, w = 22, h = 24}
	geo.num_gauge_ad	= {x = geo.play.x + 506, y = 226, w = 22, h = 24}
	geo.gauge			= {x = geo.play.x + 55, y = 192, w = 486, h = 32}
	geo.level			= {x = geo.play.x + 286, y = 32, w = 112, h = 112}
	geo.num_level		= {x = geo.play.x + 327, y = 86, w = 15, h = 17}
	geo.num_score		= {x = geo.play.x + 116, y = 32, w = 19, h = 17}
	geo.num_combo		= {x = geo.play.x + 135, y = 117, w = 19, h = 17}
	geo.num_speed		= {x = geo.play.x + 446, y = 117, w = 19, h = 17}
	geo.num_speed_ad	= {x = geo.play.x + 491, y = 117, w = 19, h = 17}
	geo.note_dst		= {
		{x = geo.lane.x + 111, y = geo.lane.y - note_param.lane_hight_offset, w = 60, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 174, y = geo.lane.y - note_param.lane_hight_offset, w = 48, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 225, y = geo.lane.y - note_param.lane_hight_offset, w = 60, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 288, y = geo.lane.y - note_param.lane_hight_offset, w = 48, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 339, y = geo.lane.y - note_param.lane_hight_offset, w = 60, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 402, y = geo.lane.y - note_param.lane_hight_offset, w = 48, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x + 453, y = geo.lane.y - note_param.lane_hight_offset, w = 60, h = geo.lane.h + note_param.lane_hight_offset},
		{x = geo.lane.x, y = geo.lane.y - note_param.lane_hight_offset, w = 108, h = geo.lane.h + note_param.lane_hight_offset}
	}
	if isScratchRight() then
		geo.scratch.x		= geo.scratch.x + 393
		geo.level.x			= geo.level.x - 6
		geo.num_level.x		= geo.num_level.x - 6
		geo.num_score.x		= geo.num_score.x - 6
		geo.num_combo.x		= geo.num_combo.x - 6
		geo.num_speed.x		= geo.num_speed.x - 6
		geo.num_speed_ad.x	= geo.num_speed_ad.x - 6
		geo.note_dst[1].x	= geo.lane.x
		geo.note_dst[2].x	= geo.lane.x + 63
		geo.note_dst[3].x	= geo.lane.x + 114
		geo.note_dst[4].x	= geo.lane.x + 177
		geo.note_dst[5].x	= geo.lane.x + 228
		geo.note_dst[6].x	= geo.lane.x + 291
		geo.note_dst[7].x	= geo.lane.x + 342
		geo.note_dst[8].x	= geo.lane.x + 405
	end
	geo.keyflash		= {
		{x = geo.note_dst[1].x, y = 250, w = geo.note_dst[1].w, h = 100},
		{x = geo.note_dst[2].x, y = 250, w = geo.note_dst[2].w, h = 100},
		{x = geo.note_dst[3].x, y = 250, w = geo.note_dst[3].w, h = 100},
		{x = geo.note_dst[4].x, y = 250, w = geo.note_dst[4].w, h = 100},
		{x = geo.note_dst[5].x, y = 250, w = geo.note_dst[5].w, h = 100},
		{x = geo.note_dst[6].x, y = 250, w = geo.note_dst[6].w, h = 100},
		{x = geo.note_dst[7].x, y = 250, w = geo.note_dst[7].w, h = 100}
	}
	geo.num_random		= {}
	for i = 1, 7 do
		geo.num_random[i] = {
			x = geo.note_dst[i].x + (geo.note_dst[i].w / 2) - 12,
			y = geo.lane.y - 62,
			w = 24,
			h = 28
		}
		if i % 2 == 0 then
			geo.num_random[i].r = 64
			geo.num_random[i].g = 160
			geo.num_random[i].b = 255
		end
	end
	if isSixtarNotes_Type1() or isSixtarNotes_Type2() then
		geo.note_dst[1].x	= geo.note_dst[1].x
		geo.note_dst[2].x	= geo.note_dst[1].x + 25 --
		geo.note_dst[3].x	= geo.note_dst[1].x + 81
		geo.note_dst[4].x	= geo.note_dst[1].x + 162
		geo.note_dst[5].x	= geo.note_dst[1].x + 243
		geo.note_dst[6].x	= geo.note_dst[1].x + 243 + 25 --
		geo.note_dst[7].x	= geo.note_dst[1].x + 324
		geo.note_dst[1].w	= 78
		geo.note_dst[2].w	= 159 - 50 -- MEMO: 視認性が悪すぎるため横幅を減らしてます
		geo.note_dst[3].w	= 78
		geo.note_dst[4].w	= 78
		geo.note_dst[5].w	= 78
		geo.note_dst[6].w	= 159 - 50 --
		geo.note_dst[7].w	= 78
	end
	geo.graph_bg		= {x = geo.graph.x, y = 555, w = 250, h = 495, a = 255 + value_offset.graph_bg.a}
	geo.graph_current	= {x = geo.graph.x + 75, y = 555, w = 30, h = 495}
	geo.graph_mybest	= {x = geo.graph.x + 135, y = 555, w = 30, h = 495}
	geo.graph_target	= {x = geo.graph.x + 195, y = 555, w = 30, h = 495}
	geo.rank			= {x = geo.graph.x + 8, y = 596, w = 84, h = 31}
	if isGraphRevers() then
		geo.graph_current.x	= geo.graph.x + 145
		geo.graph_mybest.x	= geo.graph.x + 85
		geo.graph_target.x	= geo.graph.x + 25
		geo.rank.x			= geo.graph.x + 158
	end
	geo.graph_line = {
		{x = geo.graph.x, y = 885, w = 250, h = 13},
		{x = geo.graph.x, y = 940, w = 250, h = 13},
		{x = geo.graph.x, y = 995, w = 250, h = 13}
	}
	geo.num_exscore		= {x = geo.graph.x + 148, y = 522, w = 19, h = 17}
	geo.num_rate		= {x = geo.graph.x + 21, y = 496, w = 13, h = 13}
	geo.num_rate_ad		= {x = geo.graph.x + 70, y = 496, w = 13, h = 13}
	geo.num_mybest		= {x = geo.graph.x + 148, y = 462, w = 19, h = 17}
	geo.num_diff_mybest	= {x = geo.graph.x + 21, y = 438, w = 13, h = 13}
	geo.num_target		= {x = geo.graph.x + 148, y = 402, w = 19, h = 17}
	geo.num_diff_target	= {x = geo.graph.x + 21, y = 378, w = 13, h = 13}
	geo.num_judgerank	= {x = geo.graph.x + 148, y = 312, w = 19, h = 17}
	geo.judgerank		= {x = geo.graph.x + 20, y = 310, w = 168, h = 21}
	geo.num_judge_count	= {
		n = {
			{x = geo.graph.x + 60, y = 268, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 249, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 230, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 211, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 192, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 173, w = 13, h = 13},
			{x = geo.graph.x + 60, y = 154, w = 13, h = 13}
		},
		f = {
			{x = geo.graph.x + 125, y = 268, w = 13, h = 13},
			{x = geo.graph.x + 125, y = 249, w = 13, h = 13},
			{x = geo.graph.x + 125, y = 230, w = 13, h = 13},
			{x = geo.graph.x + 125, y = 211, w = 13, h = 13},
			{x = geo.graph.x + 125, y = 192, w = 13, h = 13},
			{x = geo.graph.x + 125, y = 173, w = 13, h = 13}
		},
		s = {
			{x = geo.graph.x + 190, y = 268, w = 13, h = 13},
			{x = geo.graph.x + 190, y = 249, w = 13, h = 13},
			{x = geo.graph.x + 190, y = 230, w = 13, h = 13},
			{x = geo.graph.x + 190, y = 211, w = 13, h = 13},
			{x = geo.graph.x + 190, y = 192, w = 13, h = 13},
			{x = geo.graph.x + 190, y = 173, w = 13, h = 13}
		}
	}
	geo.num_bpm_now		= {x = geo.graph.x + 148, y = 102, w = 19, h = 17}
	geo.num_bpm_max		= {x = geo.graph.x + 86, y = 78, w = 13, h = 13}
	geo.num_bpm_min		= {x = geo.graph.x + 21, y = 78, w = 13, h = 13}
	geo.num_timeleft_mm	= {x = geo.graph.x + 160, y = 42, w = 19, h = 17}
	geo.num_timeleft_ss	= {x = geo.graph.x + 205, y = 42, w = 19, h = 17}
	geo.judgeline		= {x = geo.lane.x, y = geo.lane.y, w = geo.lane.w, h = 12}
	geo.cover_lift		= {x = geo.lane.x, y = geo.lane.y - geo.lane.h, w = geo.lane.w, h = geo.lane.h}
	geo.cover_hidden	= {x = geo.lane.x, y = geo.lane.y - geo.lane.h, w = geo.lane.w, h = geo.lane.h}
	geo.cover_lane		= {x = geo.lane.x, y = 1080, w = geo.lane.w, h = geo.lane.h}
	geo.num_cover_lane_white = {x = geo.cover_lane.x + 96, y = geo.cover_lane.y + 8, w = 18, h = 20}
	geo.num_cover_lane_green = {x = geo.cover_lane.x + 349, y = geo.cover_lane.y + 8, w = 18, h = 20}
	geo.num_cover_lift_white = {x = geo.cover_lift.x + 96, y = geo.cover_lift.y + geo.cover_lift.h - 24, w = 18, h = 20}
	geo.num_cover_lift_green = {x = geo.cover_lift.x + 349, y = geo.cover_lift.y + geo.cover_lift.h - 24, w = 18, h = 20}
	geo.img_judge		= {time = 0, x = geo.lane.x + 143 + value_offset.judge.x, y = geo.lane.y + 123 + value_offset.judge.y, w = 227, h = 84}
	geo.num_judge		= {time = 0, x = 237, y = 0, w = 55, h = 84}
	geo.judgedetail		= {x = geo.lane.x + 286 + value_offset.fs.x, y = geo.img_judge.y + geo.img_judge.h + 15 + value_offset.fs.y, w = 72, h = 20}
	geo.num_ghost		= {x = geo.lane.x + 146 + value_offset.ghost.x, y = geo.img_judge.y + geo.img_judge.h + 15 + value_offset.ghost.y, w = 18, h = 20}
	geo.bomb			= {
		{time = 0, x = geo.note_dst[1].x + (geo.note_dst[1].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[2].x + (geo.note_dst[2].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[3].x + (geo.note_dst[3].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[4].x + (geo.note_dst[4].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[5].x + (geo.note_dst[5].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[6].x + (geo.note_dst[6].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[7].x + (geo.note_dst[7].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300},
		{time = 0, x = geo.note_dst[8].x + (geo.note_dst[8].w / 2) - 200, y = geo.lane.y - 144, w = 400, h = 300}
	}
	geo.img_loading = {x = geo.lane.x + 131, y = geo.img_judge.y, w = 251, h = 30}
	geo.num_loading = {x = geo.img_loading.x + 171, y = geo.img_loading.y + 5, w = 19, h = 17}
	geo.grh_loading = {x = geo.img_loading.x + 2, y = geo.img_loading.y + 2, w = 247, h = 26}
	geo.anim			= {
		cover_lane		= {
			{time = 0, x = geo.cover_lane.x, y = 1080 + geo.cover_lane.h, w = geo.cover_lane.w, h = geo.cover_lane.h, acc = 2},
			{time = 500},
			{time = 1000, y = 1080}
		},
		cover_finish	= {
			{time = 0, x = geo.lane.x, y = 1080, w = geo.lane.w, h = geo.lane.h, acc = 2},
			{time = 1000, y = geo.lane.y}
		},
		progress_song_start	= {
			{time = 0, x = geo.play.x + 19, y = 1014 - 617, w = 36, h = 42, a = 0, acc = 2},
			{time = 500, a = 255},
			{time = 1200, y = 1014},
		},
		progress_song_play	= {
			{time = 0, x = geo.play.x + 19, y = 1014, w = 36, h = 42, a = 255},
			{time = 1000, a = 0},
		},
		glow1 = {time = 0, x = geo.lane.x, y = geo.lane.y, w = geo.lane.w, h = 47},
		glow2 = {time = 1000, a = 64},
		keybeam_on = {
			{time = 0, x = geo.note_dst[1].x, y = geo.lane.y, w = geo.note_dst[1].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[2].x, y = geo.lane.y, w = geo.note_dst[2].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[3].x, y = geo.lane.y, w = geo.note_dst[3].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[4].x, y = geo.lane.y, w = geo.note_dst[4].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[5].x, y = geo.lane.y, w = geo.note_dst[5].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[6].x, y = geo.lane.y, w = geo.note_dst[6].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[7].x, y = geo.lane.y, w = geo.note_dst[7].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a},
			{time = 0, x = geo.note_dst[8].x, y = geo.lane.y, w = geo.note_dst[8].w, h = 564 + value_offset.keybeam.h, a = 255 + value_offset.keybeam.a}
		},
		keybeam_off = {
			{time = 100, x = geo.note_dst[1].x + 20, y = geo.lane.y, w = 20, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[2].x + 16, y = geo.lane.y, w = 16, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[3].x + 20, y = geo.lane.y, w = 20, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[4].x + 16, y = geo.lane.y, w = 16, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[5].x + 20, y = geo.lane.y, w = 20, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[6].x + 16, y = geo.lane.y, w = 16, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[7].x + 20, y = geo.lane.y, w = 20, h = 564 + value_offset.keybeam.h, a = 0},
			{time = 100, x = geo.note_dst[8].x + 36, y = geo.lane.y, w = 36, h = 564 + value_offset.keybeam.h, a = 0}
		},
		ready = {
			{time = 0, x = geo.lane.x + 95, y = geo.img_judge.y, w = 324, h = 36, a = 0},
			{time = 100, a = 255},
			{time = 800},
			{time = 1000, y = geo.img_judge.y - 18, a = 0}
		},
		fullcombo_effect = {
			{time = 0, x = geo.lane.x, y = geo.lane.y, w = geo.lane.w, h = geo.lane.h, a = 128},
			{time = 2100, y = geo.lane.y + 100, a = 0}
		},
		fullcombo = {
			{time = 550, x = geo.lane.x + 77, y = geo.img_judge.y, w = 360, h = 36, a = 0},
			{time = 650, a = 255},
			{time = 1600},
			{time = 1800, y = geo.img_judge.y - 18, a = 0}
		}
	}
	if isSixtarNotes_Type1() or isSixtarNotes_Type2() then
		geo.anim.keybeam_on[2].x = geo.anim.keybeam_on[1].x
		geo.anim.keybeam_on[6].x = geo.anim.keybeam_on[5].x
		geo.anim.keybeam_on[2].w = 159
		geo.anim.keybeam_on[6].w = 159
		geo.anim.keybeam_off[1].x = geo.anim.keybeam_on[1].x
		geo.anim.keybeam_off[2].x = geo.anim.keybeam_on[2].x
		geo.anim.keybeam_off[3].x = geo.anim.keybeam_on[3].x
		geo.anim.keybeam_off[4].x = geo.anim.keybeam_on[4].x
		geo.anim.keybeam_off[5].x = geo.anim.keybeam_on[5].x
		geo.anim.keybeam_off[6].x = geo.anim.keybeam_on[6].x
		geo.anim.keybeam_off[7].x = geo.anim.keybeam_on[7].x
		geo.anim.keybeam_off[8].x = geo.anim.keybeam_on[8].x
		geo.anim.keybeam_off[1].w = geo.anim.keybeam_on[1].w
		geo.anim.keybeam_off[2].w = geo.anim.keybeam_on[2].w
		geo.anim.keybeam_off[3].w = geo.anim.keybeam_on[3].w
		geo.anim.keybeam_off[4].w = geo.anim.keybeam_on[4].w
		geo.anim.keybeam_off[5].w = geo.anim.keybeam_on[5].w
		geo.anim.keybeam_off[6].w = geo.anim.keybeam_on[6].w
		geo.anim.keybeam_off[7].w = geo.anim.keybeam_on[7].w
		geo.anim.keybeam_off[8].w = geo.anim.keybeam_on[8].w
	end
	if isScratchRight() then
		geo.anim.progress_song_start[1].x = geo.anim.progress_song_start[1].x + 513
		geo.anim.progress_song_play[1].x = geo.anim.progress_song_play[1].x + 513
	end
	
	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end
	
	skin.source = {
		-- BGA
		{id = "src_bga_bgi",			path = "../customize/bga_bgi/*"},
		{id = "src_frame_bga",			path = "image/frame_bga.png"},
		
		-- PLAY
		{id = "src_frame_play1p",		path = "image/frame_play1p.png"},
		{id = "src_frame_play2p",		path = "image/frame_play2p.png"},
		{id = "src_frame_off_play1p",	path = "image/frame_off_play1p.png"},
		{id = "src_frame_off_play2p",	path = "image/frame_off_play2p.png"},
		{id = "src_frame_laneSixtar",	path = "image/frame_laneSixtar.png"},
		{id = "src_frame_lane1p",		path = "image/frame_lane1p.png"},
		{id = "src_frame_lane2p",		path = "image/frame_lane2p.png"},
		{id = "src_glow",				path = "../customize/glow/*"},
		{id = "src_judgeline",			path = "../customize/judgeline/*"},
		{id = "src_progress_song",		path = "../customize/progress/*"},
		{id = "src_scratch",			path = "../customize/scratch/*"},
		{id = "src_gauge",				path = "../customize/gauge/*"},
		{id = "src_level",				path = "image/level.png"},
		{id = "src_keyflash",			path = "../customize/keyflash/*"},
		{id = "src_keybeam",			path = "../customize/keybeam/*.png|1|"},
		{id = "src_keybeam_pg",			path = "../customize/keybeam/*.png|2|"},
		{id = "src_section",			path = "image/section.png"},
		{id = "src_notes",				path = "../customize/notes/*.png"},
		{id = "src_mine",				path = "../customize/mine/*.png"},
		{id = "src_cover_lane",			path = "../customize/cover/*.png|1|"},
		{id = "src_cover_lift",			path = "../customize/cover/*.png|2|"},
		{id = "src_cover_hidden",		path = "../customize/cover/*.png|3|"},
		{id = "src_cover_finish",		path = "../customize/cover/*.png|4|"},
		{id = "src_judge",				path = "../customize/judge/*.png"},
		{id = "src_judgedetail",		path = "image/judgedetail.png"},
		{id = "src_bomb",				path = "../customize/bomb/*.png"},
		
		-- GRAPH
		{id = "src_graph_bg",			path = "../customize/graph_bg/*.png"},
		{id = "src_frame_graph1p",		path = "image/frame_graph1p.png"},
		{id = "src_frame_graph2p",		path = "image/frame_graph2p.png"},
		{id = "src_frame_off_graph1p",	path = "image/frame_off_graph1p.png"},
		{id = "src_frame_off_graph2p",	path = "image/frame_off_graph2p.png"},
		{id = "src_graph",				path = "image/graph.png"},
		{id = "src_graph_line",			path = "image/graph_line.png"},
		{id = "src_rank",				path = "image/rank.png"},
		{id = "src_judgerank",			path = "image/judgerank.png"},
		
		-- VALUE
		{id = "src_number_gauge",		path = "image/number_gauge.png"},
		{id = "src_number_level",		path = "image/number_level.png"},
		{id = "src_number_common_m",	path = "image/number_common_m.png"},
		{id = "src_number_common_s",	path = "image/number_common_s.png"},
		{id = "src_number_lane",		path = "image/number_lane.png"},
		
		-- EFFECT
		{id = "src_loading",			path = "image/loading.png"},
		{id = "src_ready",				path = "image/ready.png"},
		{id = "src_fceffect",			path = "image/fceffect.png"},
		{id = "src_fullcombo",			path = "image/fullcombo.png"},
		
		{id = "src_VOICEVOX_Tsumugi_Kasukabe",	path = "ex/combocount/tsumugi.png"}
	}
	
	skin.font = {
		{id = "font1", path = "font/ttf/mgenplus-1c-medium.ttf"}
	}
	
	skin.image = {}
	skin.imageset = {}
	skin.value = {}
	skin.text = {}
	skin.slider = {}
	skin.hiddenCover = {}
	skin.liftCover = {}
	skin.graph = {}
	skin.note = {}
	skin.gauge = {}
	skin.judge = {}
	skin.bga = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingvisualizer = {}
	skin.destination = {}
	skin.customTimers = {}
	
	do
		local parts = {
			bg		= {},
			bga		= {},
			graph	= {},
			play	= {},
			start	= {},
			close	= {},
			failed	= {},
			custom	= {}
		}
		
		-- 背景
		parts.bg.destination = {
			{id = -110, dst = {geo.bg}}
		}
		
		append_all(skin.destination, parts.bg.destination)
		--
		
		
		-- BGAエリア
		if BGA_BG() then
			parts.bga.image = {
				{id = "img_bga_bgi", src = "src_bga_bgi", x = 0, y = 0, w = -1, h = -1}
			}
			parts.bga.bga = {id = "bga"}
			parts.bga.destination = {
				{id = "bga", op = {171,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "bga", op = {171,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = -110, loop = 500, dst = {geo.bga, {time = 500, a = value_offset.bga.a, acc = 2}}},
				
				{id = -101, filter = 1, stretch = 1,						op = {80, 195}, dst = {geo.bga_main}}, -- BACKBMP
				{id = -101, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 195}, dst = {geo.bga_main, {time = 500, a = 0}}},
				
				{id = -100, filter = 1, stretch = 1,						op = {80, 191, 194}, dst = {geo.bga_main}}, -- STAGEFILE
				{id = -100, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 191, 194}, dst = {geo.bga_main, {time = 500, a = 0}}},
			}
			skin.bga = parts.bga.bga
			append_all(skin.image, parts.bga.image)
			append_all(skin.destination, parts.bga.destination)
		--
		elseif isGdbGBgaFrame() then
			parts.bga.image = {
				{id = "img_bga_bgi",		src = "src_bga_bgi", x = 0, y = 0, w = -1, h = -1},
				{id = "img_frame_bga",		src = "src_frame_bga", x = 0, y = 0, w = 1080, h = 1080},
				{id = "img_frame_bga_load", src = "src_frame_bga", x = 1080, y = 100, w = 1080, h = 200},
				{id = "img_frame_bga_play", src = "src_frame_bga", x = 1080, y = 0, w = 1080, h = 100}
			}
			
			parts.bga.text = {
				{id = "txt_load_scene",		font = "font1", size = 18, align = 1, constantText = "EXTRA SCENE"},
				{id = "txt_load_genre",		font = "font1", size = 18, align = 1, ref = 13, overflow = 1},
				{id = "txt_load_title",		font = "font1", size = 60, align = 1, ref = 12, overflow = 1},
				{id = "txt_load_artist",	font = "font1", size = 18, align = 1, ref = 16, overflow = 1},
				{id = "txt_play_scene",		font = "font1", size = 12, align = 1, constantText = "EXTRA SCENE"},
				{id = "txt_play_genre",		font = "font1", size = 12, align = 1, ref = 13, overflow = 1},
				{id = "txt_play_title",		font = "font1", size = 24, align = 1, ref = 12, overflow = 1},
				{id = "txt_play_artist",	font = "font1", size = 12, align = 1, ref = 16, overflow = 1},
			}
			
			parts.bga.bga = {id = "bga"}
			
			parts.bga.destination = {
				{id = "bga", op = {171,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "bga", op = {171,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = -110, loop = 500, dst = {geo.bga_main, {time = 500, a = value_offset.bga.a, acc = 2}}},
				
				{id = -101, filter = 1, stretch = 1,						op = {80, 195}, dst = {geo.backbmp}}, -- BACKBMP
				{id = -101, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 195}, dst = {geo.backbmp, {time = 500, a = 0}}},
				
				{id = -100, filter = 1, stretch = 1,						op = {80, 191, 194}, dst = {geo.bga_main}}, -- STAGEFILE
				{id = -100, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 191, 194}, dst = {geo.bga_main, {time = 500, a = 0}}},
				
				{id = "img_frame_bga",		blend = 1,											dst = {geo.bga}},
				{id = "img_frame_bga_load", blend = 1,							op = {80, 194},	dst = {geo.bga_load}},
				{id = "img_frame_bga_load", blend = 1, timer = 40, loop = -1,	op = {81, 194},	dst = {geo.bga_load, {time = 1000}, {time = 2500, a = 0}}},
				{id = "txt_load_scene",		filter = 1,							op = {80, 194},	dst = {geo.txt_load_scene}},
				{id = "txt_load_scene",		filter = 1, timer = 40, loop = -1,	op = {81, 194},	dst = {geo.txt_load_scene, {time = 1000}, {time = 2500, a = 0}}},
				{id = "txt_load_genre",		filter = 1,							op = {80, 194},	dst = {geo.txt_load_genre}},
				{id = "txt_load_genre",		filter = 1, timer = 40, loop = -1,	op = {81, 194},	dst = {geo.txt_load_genre, {time = 1000}, {time = 2500, a = 0}}},
				{id = "txt_load_title",		filter = 1,							op = {80, 194},	dst = {geo.txt_load_title}},
				{id = "txt_load_title",		filter = 1, timer = 40, loop = -1,	op = {81, 194},	dst = {geo.txt_load_title, {time = 1000}, {time = 2500, a = 0}}},
				{id = "txt_load_artist",	filter = 1,							op = {80, 194},	dst = {geo.txt_load_artist}},
				{id = "txt_load_artist",	filter = 1, timer = 40, loop = -1,	op = {81, 194},	dst = {geo.txt_load_artist, {time = 1000}, {time = 2500, a = 0}}},
				
				{id = "img_frame_bga_play",	blend = 1, timer = 40, loop = 4000,		dst = {geo.bga_play, {time = 2500}, {time = 4000, a = 255}}},
				{id = "txt_play_scene",		filter = 1, timer = 40, loop = 4000,	dst = {geo.txt_play_scene, {time = 2500}, {time = 4000, a = 255}}},
				{id = "txt_play_genre",		filter = 1, timer = 40, loop = 4000,	dst = {geo.txt_play_genre, {time = 2500}, {time = 4000, a = 255}}},
				{id = "txt_play_title",		filter = 1, timer = 40, loop = 4000,	dst = {geo.txt_play_title, {time = 2500}, {time = 4000, a = 255}}},
				{id = "txt_play_artist",	filter = 1, timer = 40, loop = 4000,	dst = {geo.txt_play_artist, {time = 2500}, {time = 4000, a = 255}}}
			}
			skin.bga = parts.bga.bga
			append_all(skin.image, parts.bga.image)
			append_all(skin.text, parts.bga.text)
			append_all(skin.destination, parts.bga.destination)
		--
		else
			parts.bga.image = {
				{id = "img_bga_bgi", src = "src_bga_bgi", x = 0, y = 0, w = -1, h = -1}
			}
			
			parts.bga.text = {
				{id = "txt_load_genre",		font = "font1", size = 24, align = 1, ref = 13, overflow = 1},
				{id = "txt_load_title",		font = "font1", size = 60, align = 1, ref = 12, overflow = 1},
				{id = "txt_load_artist",	font = "font1", size = 30, align = 1, ref = 16, overflow = 1}
			}
			
			parts.bga.bga = {id = "bga"}
			
			parts.bga.destination = {
				{id = "bga", op = {171,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "bga", op = {171,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {170,980}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 3, dst = {geo.bga_bg}},
				{id = "img_bga_bgi", timer = 41, loop = 0, op = {981}, filter = 1, stretch = 1, dst = {geo.bga_main}},
				
				{id = -110, loop = 500, dst = {geo.bga, {time = 500, a = value_offset.bga.a, acc = 2}}},
				
				{id = -101, filter = 1, stretch = 1,						op = {80, 195}, dst = {geo.bga_main}}, -- BACKBMP
				{id = -101, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 195}, dst = {geo.bga_main, {time = 500, a = 0}}},
				
				{id = -100, filter = 1, stretch = 1,						op = {80, 191, 194}, dst = {geo.bga_main}}, -- STAGEFILE
				{id = -100, filter = 1, stretch = 1, timer = 40, loop = -1,	op = {81, 191, 194}, dst = {geo.bga_main, {time = 500, a = 0}}},
				
				{id = "txt_load_genre",		filter = 1,							op = {80, 190, 194}, dst = {geo.txt_load_genre_def}},
				{id = "txt_load_genre",		filter = 1, timer = 40, loop = -1,	op = {81, 190, 194}, dst = {geo.txt_load_genre_def, {time = 500, a = 0}}},
				{id = "txt_load_title",		filter = 1,							op = {80, 190, 194}, dst = {geo.txt_load_title_def}},
				{id = "txt_load_title",		filter = 1, timer = 40, loop = -1,	op = {81, 190, 194}, dst = {geo.txt_load_title_def, {time = 500, a = 0}}},
				{id = "txt_load_artist",	filter = 1,							op = {80, 190, 194}, dst = {geo.txt_load_artist_def}},
				{id = "txt_load_artist",	filter = 1, timer = 40, loop = -1,	op = {81, 190, 194}, dst = {geo.txt_load_artist_def, {time = 500, a = 0}}}
			}
			
			skin.bga = parts.bga.bga
			append_all(skin.image, parts.bga.image)
			append_all(skin.text, parts.bga.text)
			append_all(skin.destination, parts.bga.destination)
		end
		--
		
		
		-- グラフエリア
		parts.graph.image = {
			{id = "img_graph_bg",		src = "src_graph_bg", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_graph1p",	src = "src_frame_graph1p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_graph2p",	src = "src_frame_graph2p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_off_graph1p",	src = "src_frame_off_graph1p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_off_graph2p",	src = "src_frame_off_graph2p", x = 0, y = 0, w = -1, h = -1},
			
			{id = "img_graph1p_a",		src = "src_graph_line", x = 0, y = 26, w = -1, h = 13},
			{id = "img_graph1p_aa",		src = "src_graph_line", x = 0, y = 13, w = -1, h = 13},
			{id = "img_graph1p_aaa",	src = "src_graph_line", x = 0, y = 0, w = -1, h = 13},
			{id = "img_graph2p_a",		src = "src_graph_line", x = 0, y = 65, w = -1, h = 13},
			{id = "img_graph2p_aa",		src = "src_graph_line", x = 0, y = 52, w = -1, h = 13},
			{id = "img_graph2p_aaa",	src = "src_graph_line", x = 0, y = 39, w = -1, h = 13},
			
			{id = "img_rank_f",		src = "src_rank", x = 0, y = 0, w = 84, h = 31},
			{id = "img_rank_e",		src = "src_rank", x = 0, y = 31, w = 84, h = 31},
			{id = "img_rank_d",		src = "src_rank", x = 0, y = 62, w = 84, h = 31},
			{id = "img_rank_c",		src = "src_rank", x = 0, y = 93, w = 84, h = 31},
			{id = "img_rank_b",		src = "src_rank", x = 0, y = 124, w = 84, h = 31},
			{id = "img_rank_a",		src = "src_rank", x = 0, y = 155, w = 84, h = 31},
			{id = "img_rank_aa",	src = "src_rank", x = 0, y = 186, w = 84, h = 31},
			{id = "img_rank_aaa",	src = "src_rank", x = 0, y = 217, w = 84, h = 31},
			
			{id = "img_judgerank_veryeasy",	src = "src_judgerank", x = 0, y = 0,  w = 168, h = 21},
			{id = "img_judgerank_easy",		src = "src_judgerank", x = 0, y = 21, w = 168, h = 21},
			{id = "img_judgerank_normal",	src = "src_judgerank", x = 0, y = 42, w = 168, h = 21},
			{id = "img_judgerank_hard",		src = "src_judgerank", x = 0, y = 63, w = 168, h = 21},
			{id = "img_judgerank_veryhard",	src = "src_judgerank", x = 0, y = 84, w = 168, h = 21}
		}
		
		parts.graph.value = {
			{id = "num_exscore",		src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 5, ref = 101},
			{id = "num_rate",			src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 3, ref = 102},
			{id = "num_rate_afterdot",	src = "src_number_common_s", x = 0, y = 0, w = 143, h = 13, divx = 11, digit = 2, ref = 103},
			
			{id = "num_mybest",			src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 5, ref = 150},
			{id = "num_diff_mybest",	src = "src_number_common_s", x = 0, y = 26, w = 156, h = 26, divx = 12, divy = 2, digit = 6, align = 1, ref = 152},
			
			{id = "num_target",			src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 5, ref = 151},
			{id = "num_diff_target",	src = "src_number_common_s", x = 0, y = 26, w = 156, h = 26, divx = 12, divy = 2, digit = 6, align = 1, ref = 153},
			
			{id = "num_judgerank",		src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 5, ref = 400},
			
			{id = "num_count_pg",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 110},
			{id = "num_count_gr",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 111},
			{id = "num_count_gd",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 112},
			{id = "num_count_bd",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 113},
			{id = "num_count_pr",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 114},
			{id = "num_count_fl",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 420},
			{id = "num_count_cb",		src = "src_number_common_s", x = 0, y = 13, w = 143, h = 13, divx = 11, digit = 4, ref = 425},
			
			{id = "num_count_pg_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 410},
			{id = "num_count_gr_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 412},
			{id = "num_count_gd_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 414},
			{id = "num_count_bd_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 416},
			{id = "num_count_pr_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 418},
			{id = "num_count_fl_fast",	src = "src_number_common_s", x = 0, y = 26, w = 143, h = 13, divx = 11, digit = 4, ref = 421},
			
			{id = "num_count_pg_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 411},
			{id = "num_count_gr_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 413},
			{id = "num_count_gd_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 415},
			{id = "num_count_bd_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 417},
			{id = "num_count_pr_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 419},
			{id = "num_count_fl_slow",	src = "src_number_common_s", x = 0, y = 39, w = 143, h = 13, divx = 11, digit = 4, ref = 422},
			
			{id = "num_bpm_now",		src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 5, ref = 160},
			{id = "num_bpm_max",		src = "src_number_common_s", x = 0, y = 0, w = 130, h = 13, divx = 10, digit = 7, align = 1, ref = 90},
			{id = "num_bpm_min",		src = "src_number_common_s", x = 0, y = 0, w = 130, h = 13, divx = 10, digit = 4, ref = 91},
			
			{id = "num_timeleft_mm",	src = "src_number_common_m", x = 0, y = 17, w = 190, h = 17, divx = 10, digit = 2, ref = 163},
			{id = "num_timeleft_ss",	src = "src_number_common_m", x = 0, y = 0, w = 209, h = 17, divx = 11, digit = 2, ref = 164}
		}
		
		parts.graph.graph = {
			{id = "grh_current_now",	src = "src_graph", x = 0, y = 0, w = 30, h = 495, angle = 1, type = 110},
			{id = "grh_current_final",	src = "src_graph", x = 90, y = 0, w = 30, h = 495, angle = 1, type = 111},
			{id = "grh_best_now",		src = "src_graph", x = 30, y = 0, w = 30, h = 495, angle = 1, type = 112},
			{id = "grh_best_final",		src = "src_graph", x = 90, y = 0, w = 30, h = 495, angle = 1, type = 113},
			{id = "grh_target_now",		src = "src_graph", x = 60, y = 0, w = 30, h = 495, angle = 1, type = 114},
			{id = "grh_target_final",	src = "src_graph", x = 90, y = 0, w = 30, h = 495, angle = 1, type = 115}
		}
		
		parts.graph.destination = {
			{id = "img_graph_bg", filter = 1, stretch = 3, dst = {geo.graph_bg}},
			{id = "img_frame_graph1p", op = {900,961}, dst = {geo.graph}},
			{id = "img_frame_graph2p", op = {901,961}, dst = {geo.graph}},
			{id = "img_frame_off_graph1p", op = {900,960}, dst = {geo.graph}},
			{id = "img_frame_off_graph2p", op = {901,960}, dst = {geo.graph}},
			
			{id = "grh_current_final",	dst = {geo.graph_current}},
			{id = "grh_current_now",	dst = {geo.graph_current}},
			{id = "grh_best_final",		dst = {geo.graph_mybest}},
			{id = "grh_best_now",		dst = {geo.graph_mybest}},
			{id = "grh_target_final",	dst = {geo.graph_target}},
			{id = "grh_target_now",		dst = {geo.graph_target}},
			
			{id = "img_graph1p_a",		op = {900,222}, dst = {geo.graph_line[1]}},
			{id = "img_graph1p_aa",		op = {900,221}, dst = {geo.graph_line[2]}},
			{id = "img_graph1p_aaa",	op = {900,220}, dst = {geo.graph_line[3]}},
			{id = "img_graph2p_a",		op = {901,222}, dst = {geo.graph_line[1]}},
			{id = "img_graph2p_aa",		op = {901,221}, dst = {geo.graph_line[2]}},
			{id = "img_graph2p_aaa",	op = {901,220}, dst = {geo.graph_line[3]}},
			
			{id = "img_rank_f",		op = {207}, dst = {geo.rank}},
			{id = "img_rank_e",		op = {206}, dst = {geo.rank}},
			{id = "img_rank_d",		op = {205}, dst = {geo.rank}},
			{id = "img_rank_c",		op = {204}, dst = {geo.rank}},
			{id = "img_rank_b",		op = {203}, dst = {geo.rank}},
			{id = "img_rank_a",		op = {202}, dst = {geo.rank}},
			{id = "img_rank_aa",	op = {201}, dst = {geo.rank}},
			{id = "img_rank_aaa",	op = {200}, dst = {geo.rank}},
			
			{id = "num_exscore",		dst = {geo.num_exscore}},
			{id = "num_rate",			dst = {geo.num_rate}},
			{id = "num_rate_afterdot",	dst = {geo.num_rate_ad}},
			{id = "num_mybest",			dst = {geo.num_mybest}},
			{id = "num_diff_mybest",	dst = {geo.num_diff_mybest}},
			{id = "num_target",			dst = {geo.num_target}},
			{id = "num_diff_target",	dst = {geo.num_diff_target}},
			
			{id = "img_judgerank_veryeasy",	op = {184}, dst = {geo.judgerank}},
			{id = "img_judgerank_easy",		op = {183}, dst = {geo.judgerank}},
			{id = "img_judgerank_normal",	op = {182}, dst = {geo.judgerank}},
			{id = "img_judgerank_hard",		op = {181}, dst = {geo.judgerank}},
			{id = "img_judgerank_veryhard",	op = {180}, dst = {geo.judgerank}},
			
			{id = "num_judgerank",		dst = {geo.num_judgerank}},
			
			{id = "num_count_pg", dst = {geo.num_judge_count.n[1]}},
			{id = "num_count_gr", dst = {geo.num_judge_count.n[2]}},
			{id = "num_count_gd", dst = {geo.num_judge_count.n[3]}},
			{id = "num_count_bd", dst = {geo.num_judge_count.n[4]}},
			{id = "num_count_pr", dst = {geo.num_judge_count.n[5]}},
			{id = "num_count_fl", dst = {geo.num_judge_count.n[6]}},
			{id = "num_count_cb", dst = {geo.num_judge_count.n[7]}},
			
			{id = "num_count_pg_fast", dst = {geo.num_judge_count.f[1]}},
			{id = "num_count_gr_fast", dst = {geo.num_judge_count.f[2]}},
			{id = "num_count_gd_fast", dst = {geo.num_judge_count.f[3]}},
			{id = "num_count_bd_fast", dst = {geo.num_judge_count.f[4]}},
			{id = "num_count_pr_fast", dst = {geo.num_judge_count.f[5]}},
			{id = "num_count_fl_fast", dst = {geo.num_judge_count.f[6]}},
			
			{id = "num_count_pg_slow", dst = {geo.num_judge_count.s[1]}},
			{id = "num_count_gr_slow", dst = {geo.num_judge_count.s[2]}},
			{id = "num_count_gd_slow", dst = {geo.num_judge_count.s[3]}},
			{id = "num_count_bd_slow", dst = {geo.num_judge_count.s[4]}},
			{id = "num_count_pr_slow", dst = {geo.num_judge_count.s[5]}},
			{id = "num_count_fl_slow", dst = {geo.num_judge_count.s[6]}},
			
			{id = "num_bpm_now", dst = {geo.num_bpm_now}},
			{id = "num_bpm_max", dst = {geo.num_bpm_max}},
			{id = "num_bpm_min", dst = {geo.num_bpm_min}},
			
			{id = "num_timeleft_mm", dst = {geo.num_timeleft_mm}},
			{id = "num_timeleft_ss", dst = {geo.num_timeleft_ss}}
		}
		
		append_all(skin.image, parts.graph.image)
		append_all(skin.value, parts.graph.value)
		append_all(skin.graph, parts.graph.graph)
		append_all(skin.destination, parts.graph.destination)
		--
		
		
		-- プレイエリア
		parts.play.image = {
			{id = "img_frame_play1p", src = "src_frame_play1p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_play2p", src = "src_frame_play2p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_off_play1p", src = "src_frame_off_play1p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_off_play2p", src = "src_frame_off_play2p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_laneSixtar", src = "src_frame_laneSixtar", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_lane1p", src = "src_frame_lane1p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_frame_lane2p", src = "src_frame_lane2p", x = 0, y = 0, w = -1, h = -1},
			{id = "img_glow",		src = "src_glow", x = 0, y = 0, w = -1, h = -1},
			{id = "img_judgeline",	src = "src_judgeline", x = 0, y = 0, w = -1, h = -1},
			{id = "img_scratch",	src = "src_scratch", x = 0, y = 0, w = -1, h = -1},
			
			{id = "img_gauge_p1", src = "src_gauge", x = 0, y = 0, w = 9, h = 32},
			{id = "img_gauge_p2", src = "src_gauge", x = 0, y = 32, w = 9, h = 32},
			{id = "img_gauge_p3", src = "src_gauge", x = 0, y = 0, w = 9, h = 32},
			{id = "img_gauge_g1", src = "src_gauge", x = 9, y = 0, w = 9, h = 32},
			{id = "img_gauge_g2", src = "src_gauge", x = 9, y = 32, w = 9, h = 32},
			{id = "img_gauge_g3", src = "src_gauge", x = 9, y = 0, w = 9, h = 32},
			{id = "img_gauge_b1", src = "src_gauge", x = 18, y = 0, w = 9, h = 32},
			{id = "img_gauge_b2", src = "src_gauge", x = 18, y = 32, w = 9, h = 32},
			{id = "img_gauge_b3", src = "src_gauge", x = 18, y = 0, w = 9, h = 32},
			{id = "img_gauge_r1", src = "src_gauge", x = 27, y = 0, w = 9, h = 32},
			{id = "img_gauge_r2", src = "src_gauge", x = 27, y = 32, w = 9, h = 32},
			{id = "img_gauge_r3", src = "src_gauge", x = 27, y = 0, w = 9, h = 32},
			{id = "img_gauge_y1", src = "src_gauge", x = 36, y = 0, w = 9, h = 32},
			{id = "img_gauge_y2", src = "src_gauge", x = 36, y = 32, w = 9, h = 32},
			{id = "img_gauge_y3", src = "src_gauge", x = 36, y = 0, w = 9, h = 32},
			{id = "img_gauge_w1", src = "src_gauge", x = 45, y = 0, w = 9, h = 32},
			{id = "img_gauge_w2", src = "src_gauge", x = 45, y = 32, w = 9, h = 32},
			{id = "img_gauge_w3", src = "src_gauge", x = 45, y = 0, w = 9, h = 32},
			
			{id = "img_level_beginner",	src = "src_level", x = 0, y = 0, w = 112, h = 112},
			{id = "img_level_normal",	src = "src_level", x = 112, y = 0, w = 112, h = 112},
			{id = "img_level_hyper",	src = "src_level", x = 224, y = 0, w = 112, h = 112},
			{id = "img_level_another",	src = "src_level", x = 336, y = 0, w = 112, h = 112},
			{id = "img_level_insane",	src = "src_level", x = 448, y = 0, w = 112, h = 112},
			{id = "img_level_unknown",	src = "src_level", x = 560, y = 0, w = 112, h = 112},
			
			{id = "img_keyflash_w", src = "src_keyflash", x = 0, y = 0, w = 60, h = 100},
			{id = "img_keyflash_b", src = "src_keyflash", x = 60, y = 0, w = 48, h = 100},
			
			{id = "img_keybeam_w", src = "src_keybeam", x = 0, y = 0, w = 60, h = 564},
			{id = "img_keybeam_b", src = "src_keybeam", x = 70, y = 0, w = 48, h = 564},
			{id = "img_keybeam_s", src = "src_keybeam", x = 130, y = 0, w = 108, h = 564},
			{id = "img_keybeam_pg_w", src = "src_keybeam_pg", x = 0, y = 0, w = 60, h = 564},
			{id = "img_keybeam_pg_b", src = "src_keybeam_pg", x = 70, y = 0, w = 48, h = 564},
			{id = "img_keybeam_pg_s", src = "src_keybeam_pg", x = 130, y = 0, w = 108, h = 564},
			
			{id = "img_section", src = "src_section", x = 0, y = 0, w = 513, h = 1},
			
			{id = "img_note_w", src = "src_notes", x = 216, y = 0, w = 60, h = 36},
			{id = "img_note_b", src = "src_notes", x = 276, y = 0, w = 48, h = 36},
			{id = "img_note_s", src = "src_notes", x = 108, y = 0, w = 108, h = 36},
			{id = "img_lne_w", src = "src_notes", x = 216, y = 36, w = 60, h = 36},
			{id = "img_lne_b", src = "src_notes", x = 276, y = 36, w = 48, h = 36},
			{id = "img_lne_s", src = "src_notes", x = 108, y = 36, w = 108, h = 36},
			{id = "img_lns_w", src = "src_notes", x = 216, y = 72, w = 60, h = 36},
			{id = "img_lns_b", src = "src_notes", x = 276, y = 72, w = 48, h = 36},
			{id = "img_lns_s", src = "src_notes", x = 108, y = 72, w = 108, h = 36},
			{id = "img_lnb_w", src = "src_notes", x = 216, y = 144, w = 60, h = 72, divy = 2, cycle = 200},
			{id = "img_lnb_b", src = "src_notes", x = 276, y = 144, w = 48, h = 72, divy = 2, cycle = 200},
			{id = "img_lnb_s", src = "src_notes", x = 108, y = 144, w = 108, h = 72, divy = 2, cycle = 200},
			{id = "img_lna_w", src = "src_notes", x = 216, y = 108, w = 60, h = 36},
			{id = "img_lna_b", src = "src_notes", x = 276, y = 108, w = 48, h = 36},
			{id = "img_lna_s", src = "src_notes", x = 108, y = 108, w = 108, h = 36},
			{id = "img_hcne_w", src = "src_notes", x = 216, y = 216, w = 60, h = 36},
			{id = "img_hcne_b", src = "src_notes", x = 276, y = 216, w = 48, h = 36},
			{id = "img_hcne_s", src = "src_notes", x = 108, y = 216, w = 108, h = 36},
			{id = "img_hcns_w", src = "src_notes", x = 216, y = 252, w = 60, h = 36},
			{id = "img_hcns_b", src = "src_notes", x = 276, y = 252, w = 48, h = 36},
			{id = "img_hcns_s", src = "src_notes", x = 108, y = 252, w = 108, h = 36},
			{id = "img_hcnb_w", src = "src_notes", x = 216, y = 288, w = 60, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnb_b", src = "src_notes", x = 276, y = 288, w = 48, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnb_s", src = "src_notes", x = 108, y = 288, w = 108, h = 36, divy = 2, cycle = 200},
			{id = "img_hcna_w", src = "src_notes", x = 216, y = 288, w = 60, h = 18},
			{id = "img_hcna_b", src = "src_notes", x = 276, y = 288, w = 48, h = 18},
			{id = "img_hcna_s", src = "src_notes", x = 108, y = 288, w = 108, h = 18},
			{id = "img_hcnr_w", src = "src_notes", x = 216, y = 324, w = 60, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnr_b", src = "src_notes", x = 276, y = 324, w = 48, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnr_s", src = "src_notes", x = 108, y = 324, w = 108, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnd_w", src = "src_notes", x = 216, y = 288, w = 60, h = 36, divy = 2, cycle = 100},
			{id = "img_hcnd_b", src = "src_notes", x = 276, y = 288, w = 48, h = 36, divy = 2, cycle = 100},
			{id = "img_hcnd_s", src = "src_notes", x = 108, y = 288, w = 108, h = 36, divy = 2, cycle = 100},
			{id = "img_mine_w", src = "src_mine", x = 216, y = 0, w = 60, h = 36},
			{id = "img_mine_b", src = "src_mine", x = 276, y = 0, w = 48, h = 36},
			{id = "img_mine_s", src = "src_mine", x = 108, y = 0, w = 108, h = 36},
			
			-- TODO: 新たに追加したほうが良いか
			-- ノーツタイプO2にオートスクラッチ用ノーツを使用
			{id = "img_note_a", src = "src_notes", x = 0, y = 0,   w = 108, h = 36},
			{id = "img_lne_a", src = "src_notes",  x = 0, y = 36,  w = 108, h = 36},
			{id = "img_lns_a", src = "src_notes",  x = 0, y = 72,  w = 108, h = 36},
			{id = "img_lnb_a", src = "src_notes",  x = 0, y = 144, w = 108, h = 72, divy = 2, cycle = 200},
			{id = "img_lna_a", src = "src_notes",  x = 0, y = 108, w = 108, h = 36},
			{id = "img_hcne_a", src = "src_notes", x = 0, y = 216, w = 108, h = 36},
			{id = "img_hcns_a", src = "src_notes", x = 0, y = 252, w = 108, h = 36},
			{id = "img_hcnb_a", src = "src_notes", x = 0, y = 288, w = 108, h = 36, divy = 2, cycle = 200},
			{id = "img_hcna_a", src = "src_notes", x = 0, y = 288, w = 108, h = 18},
			{id = "img_hcnr_a", src = "src_notes", x = 0, y = 324, w = 108, h = 36, divy = 2, cycle = 200},
			{id = "img_hcnd_a", src = "src_notes", x = 0, y = 288, w = 108, h = 36, divy = 2, cycle = 100},
			
			{id = "cover_finish", src = "src_cover_finish", x = 0, y = 0, w = -1, h = -1},
			
			{id = "img_judge_pg", src = "src_judge", x = 0, y = 0, w = 227, h = 252, divy = 3, cycle = 120},
			{id = "img_judge_gr", src = "src_judge", x = 0, y = 252, w = 227, h = 168, divy = 2, cycle = 80},
			{id = "img_judge_gd", src = "src_judge", x = 0, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
			{id = "img_judge_bd", src = "src_judge", x = 227, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
			{id = "img_judge_pr", src = "src_judge", x = 454, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
			{id = "img_judge_fl", src = "src_judge", x = 454, y = 420, w = 227, h = 168, divy = 2, cycle = 80},
			
			{id = "img_fast", src = "src_judgedetail", x = 0, y = 40, w = 72, h = 20},
			{id = "img_slow", src = "src_judgedetail", x = 0, y = 60, w = 72, h = 20},
			
			{id = "img_bomb1", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 51, cycle = 251},
			{id = "img_bomb2", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 52, cycle = 251},
			{id = "img_bomb3", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 53, cycle = 251},
			{id = "img_bomb4", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 54, cycle = 251},
			{id = "img_bomb5", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 55, cycle = 251},
			{id = "img_bomb6", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 56, cycle = 251},
			{id = "img_bomb7", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 57, cycle = 251},
			{id = "img_bombs", src = "src_bomb", x = 0, y = 0, w = 6400, h = 300, divx = 16, timer = 50, cycle = 251},
			
			{id = "img_bomb1_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 51, cycle = 251},
			{id = "img_bomb2_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 52, cycle = 251},
			{id = "img_bomb3_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 53, cycle = 251},
			{id = "img_bomb4_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 54, cycle = 251},
			{id = "img_bomb5_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 55, cycle = 251},
			{id = "img_bomb6_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 56, cycle = 251},
			{id = "img_bomb7_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 57, cycle = 251},
			{id = "img_bombs_pg", src = "src_bomb", x = 0, y = 300, w = 6400, h = 300, divx = 16, timer = 50, cycle = 251},
			
			{id = "img_hold1", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 71, cycle = 500},
			{id = "img_hold2", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 72, cycle = 500},
			{id = "img_hold3", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 73, cycle = 500},
			{id = "img_hold4", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 74, cycle = 500},
			{id = "img_hold5", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 75, cycle = 500},
			{id = "img_hold6", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 76, cycle = 500},
			{id = "img_hold7", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 77, cycle = 500},
			{id = "img_holds", src = "src_bomb", x = 0, y = 900, w = 6400, h = 300, divx = 16, timer = 70, cycle = 500}
		}
		
		parts.play.imageset = {
			{id = "imgset_bomb1", ref = 501, images = {"img_bomb1", "img_bomb1_pg"}},
			{id = "imgset_bomb2", ref = 502, images = {"img_bomb2", "img_bomb2_pg"}},
			{id = "imgset_bomb3", ref = 503, images = {"img_bomb3", "img_bomb3_pg"}},
			{id = "imgset_bomb4", ref = 504, images = {"img_bomb4", "img_bomb4_pg"}},
			{id = "imgset_bomb5", ref = 505, images = {"img_bomb5", "img_bomb5_pg"}},
			{id = "imgset_bomb6", ref = 506, images = {"img_bomb6", "img_bomb6_pg"}},
			{id = "imgset_bomb7", ref = 507, images = {"img_bomb7", "img_bomb7_pg"}},
			{id = "imgset_bombs", ref = 500, images = {"img_bombs", "img_bombs_pg"}},
			{id = "imgset_keybeam1", ref = 501, images = {"img_keybeam_w", "img_keybeam_pg_w"}},
			{id = "imgset_keybeam2", ref = 502, images = {"img_keybeam_b", "img_keybeam_pg_b"}},
			{id = "imgset_keybeam3", ref = 503, images = {"img_keybeam_w", "img_keybeam_pg_w"}},
			{id = "imgset_keybeam4", ref = 504, images = {"img_keybeam_b", "img_keybeam_pg_b"}},
			{id = "imgset_keybeam5", ref = 505, images = {"img_keybeam_w", "img_keybeam_pg_w"}},
			{id = "imgset_keybeam6", ref = 506, images = {"img_keybeam_b", "img_keybeam_pg_b"}},
			{id = "imgset_keybeam7", ref = 507, images = {"img_keybeam_w", "img_keybeam_pg_w"}},
			{id = "imgset_keybeams", ref = 500, images = {"img_keybeam_s", "img_keybeam_pg_s"}}
		}
		
		parts.play.value = {
			{id = "num_gauge",			src = "src_number_gauge", x = 0, y = 0, w = 220, h = 24, divx = 10, digit = 3, ref = 107},
			{id = "num_gauge_afterdot",	src = "src_number_gauge", x = 0, y = 0, w = 242, h = 24, divx = 11, digit = 1, ref = 407},
			
			{id = "num_level_beginner",	src = "src_number_level", x = 0, y = 0, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			{id = "num_level_normal",	src = "src_number_level", x = 0, y = 17, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			{id = "num_level_hyper",	src = "src_number_level", x = 0, y = 34, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			{id = "num_level_another",	src = "src_number_level", x = 0, y = 51, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			{id = "num_level_insane",	src = "src_number_level", x = 0, y = 68, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			{id = "num_level_unknown",	src = "src_number_level", x = 0, y = 85, w = 150, h = 17, divx = 10, digit = 2, align = 2, ref = 96},
			
			{id = "num_score",			src = "src_number_common_m", x = 0, y = 17, w = 209, h = 17, divx = 11, digit = 6, ref = 100},
			{id = "num_combo",			src = "src_number_common_m", x = 0, y = 0, w = 190, h = 17, divx = 10, digit = 5, ref = 105},
			{id = "num_speed",			src = "src_number_common_m", x = 0, y = 0, w = 190, h = 17, divx = 10, digit = 2, ref = 310},
			{id = "num_speed_afterdot",	src = "src_number_common_m", x = 0, y = 0, w = 209, h = 17, divx = 11, digit = 2, ref = 311},

			-- BMZ拡張: プレイ開始前に実効RANDOM配置を鍵盤色で表示する
			{id = "num_random_1", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 450},
			{id = "num_random_2", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 451},
			{id = "num_random_3", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 452},
			{id = "num_random_4", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 453},
			{id = "num_random_5", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 454},
			{id = "num_random_6", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 455},
			{id = "num_random_7", src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 1, ref = 456},
			
			{id = "num_judge_pg", src = "src_judge", x = 227, y = 0, w = 550, h = 252, divx = 10, divy = 3, digit = 6, ref = 75, cycle = 120},
			{id = "num_judge_gr", src = "src_judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
			{id = "num_judge_gd", src = "src_judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
			{id = "num_judge_bd", src = "src_judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
			{id = "num_judge_pr", src = "src_judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
			{id = "num_judge_fl", src = "src_judge", x = 227, y = 252, w = 550, h = 168, divx = 10, divy = 2, digit = 6, ref = 75, cycle = 80},
			
			-- 自己ベストが存在しない時ターゲットに設定する
			{id = "num_ghost_mybest", src = "src_number_lane", x = 0, y = 20, w = 216, h = 40, divx = 12, divy = 2, digit = 5, align = 2, value = function()
				-- TODO: なんかここに無いと動かない
				local mybest = main_state.number(150)
				local target = main_state.number(151)
				if mybest <= 0 then return main_state.number(153) end
				return main_state.number(152)
			end},
			-- ターゲットが存在しない時自己ベストを表示する
			{id = "num_ghost_target", src = "src_number_lane", x = 0, y = 20, w = 216, h = 40, divx = 12, divy = 2, digit = 5, align = 2, value = function()
				local mybest = main_state.number(150)
				local target = main_state.number(151)
				if target <= 0 then return main_state.number(152) end
				return main_state.number(153)
			end},
			-- 自己ベストとターゲットを比較して高い方を設定する
			{id = "num_ghost_high",			src = "src_number_lane", x = 0, y = 20, w = 216, h = 40, divx = 12, divy = 2, digit = 5, align = 2, value = function()
				local mybest = main_state.number(150)
				local target = main_state.number(151)
				if mybest <= target then return main_state.number(153) end
				return main_state.number(152)
			end},
			-- 自己ベストとターゲットを比較して低い方を設定する
			{id = "num_ghost_low", src = "src_number_lane", x = 0, y = 20, w = 216, h = 40, divx = 12, divy = 2, digit = 5, align = 2, value = function()
				local mybest = main_state.number(150)
				local target = main_state.number(151)
				if mybest <= 0 then return main_state.number(153) end
				if mybest <= target then return main_state.number(152) end
				return main_state.number(152)
			end},
			
			{id = "num_cover_green",		src = "src_number_lane", x = 0, y = 0, w = 180, h = 20, divx = 10, digit = 4, align = 2, ref = 313},
			{id = "num_cover_lane_white",	src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 4, align = 2, ref = 14},
			{id = "num_cover_lift_white",	src = "src_number_lane", x = 0, y = 20, w = 180, h = 20, divx = 10, digit = 4, align = 2, ref = 314}
		}
		
		parts.play.note = {
			id			= "notes",
			note		= {},
			lnend		= {},
			lnstart		= {},
			lnbody		= {},
			lnactive	= {},
			hcnend		= {},
			hcnstart	= {},
			hcnbody		= {},
			hcnactive	= {},
			hcndamage	= {},
			hcnreactive	= {},
			mine		= {},
			hidden		= {},
			processed	= {},
			size		= note_param.size,
			group		= {{id = "img_section", offset = 3, dst = {{x = geo.lane.x , y = geo.lane.y, w = geo.lane.w, h = 1, r = 128, g = 128, b = 128, a = 255 + value_offset.section.a}}}},
			time		= {{id = "img_section", offset = 3, dst = {{x = geo.lane.x , y = geo.lane.y, w = geo.lane.w, h = 1, r = 100, g = 100, b = 255, a = 255 + value_offset.section.a}}}},
			bpm			= {{id = "img_section", offset = 3, dst = {{x = geo.lane.x , y = geo.lane.y, w = geo.lane.w, h = 1, r = 100, g = 255, b = 100, a = 255 + value_offset.section.a}}}},
			stop		= {{id = "img_section", offset = 3, dst = {{x = geo.lane.x , y = geo.lane.y, w = geo.lane.w, h = 1, r = 255, g = 100, b = 100, a = 255 + value_offset.section.a}}}},
			dst			= {}
		}
		do
			local types = {"w","b","w","b","w","b","w","s"}
			if isO2Notes() then
				types = {"w","b","w","a","w","b","w","s"}
			elseif isSixtarNotes_Type1() then
				types = {"w","s","w","w","w","s","w","s"}
			elseif isSixtarNotes_Type2() then
				types = {"w","s","w","b","w","s","w","s"}
			end
			for i = 1, #types do
				table.insert(parts.play.note.note,			"img_note_" .. types[i])
				table.insert(parts.play.note.lnend,			"img_lne_" .. types[i])
				table.insert(parts.play.note.lnstart,		"img_lns_" .. types[i])
				table.insert(parts.play.note.lnbody,		"img_lnb_" .. types[i])
				table.insert(parts.play.note.lnactive,		"img_lna_" .. types[i])
				table.insert(parts.play.note.hcnend,		"img_hcne_" .. types[i])
				table.insert(parts.play.note.hcnstart,		"img_hcns_" .. types[i])
				table.insert(parts.play.note.hcnbody,		"img_hcnb_" .. types[i])
				table.insert(parts.play.note.hcnactive,		"img_hcna_" .. types[i])
				table.insert(parts.play.note.hcndamage,		"img_hcnd_" .. types[i])
				table.insert(parts.play.note.hcnreactive,	"img_hcnr_" .. types[i])
				table.insert(parts.play.note.mine,			"img_mine_" .. types[i])
				table.insert(parts.play.note.dst,			geo.note_dst[i])
			end
		end
		
		parts.play.gauge = {
			id = "gauge",
			parts = 54,
			nodes = {
				"img_gauge_r1","img_gauge_p1","img_gauge_r2","img_gauge_p2","img_gauge_r3","img_gauge_p3",
				"img_gauge_r1","img_gauge_g1","img_gauge_r2","img_gauge_g2","img_gauge_r3","img_gauge_g3",
				"img_gauge_r1","img_gauge_b1","img_gauge_r2","img_gauge_b2","img_gauge_r3","img_gauge_b3",
				"img_gauge_r1","img_gauge_r1","img_gauge_r2","img_gauge_r2","img_gauge_r3","img_gauge_r3",
				"img_gauge_y1","img_gauge_y1","img_gauge_y2","img_gauge_y2","img_gauge_y3","img_gauge_y3",
				"img_gauge_w1","img_gauge_w1","img_gauge_w2","img_gauge_w2","img_gauge_w3","img_gauge_w3"
			}
		}
		
		parts.play.judge = {
			{id = "judge", index = 0, images = {}, numbers = {}, shift = true}
		}
		do
			local types = {"pg","gr","gd","bd","pr","fl"}
			for i = 1, #types do
				table.insert(parts.play.judge[1].images, {id = "img_judge_" .. types[i], loop = -1, timer = 46 , offsets = {3, 32}, dst = {geo.img_judge, {time = 500}}})
				table.insert(parts.play.judge[1].numbers, {id = "num_judge_" .. types[i], loop = -1, timer = 46, offsets = {32}, dst = {geo.num_judge, {time = 500}}})
			end
		end
		
		parts.play.slider = {
			{id = "sld_progress_song", src = "src_progress_song", x = 0, y = 0, w = -1, h = -1, angle = 2, range = 617, type = 6},
			{id = "cover_lane", src = "src_cover_lane", x = 0, y = 0, w = -1, h = -1, angle = 2, range = geo.lane.h, type = 4}
		}
		
		parts.play.hiddenCover = {
			{id = "cover_hidden", src = "src_cover_hidden", x = 0, y = 0, w = -1, h = -1, disapearLine = geo.lane.y}
		}
		
		parts.play.liftCover = {
			{id = "cover_lift", src = "src_cover_lift", x = 0, y = 0, w = -1, h = -1, disapearLine = geo.lane.y}
		}
		
		parts.play.destination = {
			{id = "img_frame_play1p", op = {902,951}, dst = {geo.play}},
			{id = "img_frame_play2p", op = {903,951}, dst = {geo.play}},
			{id = "img_frame_off_play1p", op = {902,950}, dst = {geo.play}},
			{id = "img_frame_off_play2p", op = {903,950}, dst = {geo.play}},
			{id = "img_frame_lane1p", op = {902,990}, dst = {geo.lane}},
			{id = "img_frame_lane1p", op = {902,991}, dst = {geo.lane}},
			{id = "img_frame_lane2p", op = {903,990}, dst = {geo.lane}},
			{id = "img_frame_lane2p", op = {903,991}, dst = {geo.lane}},
			{id = "img_frame_laneSixtar", op = {992}, dst = {geo.lane}},
			{id = "img_frame_laneSixtar", op = {993}, dst = {geo.lane}},
			{id = -110, loop = 1200, dst = {geo.lane, {time = 600}, {time = 1200, a = value_offset.lane.a}}},
			{id = "img_glow", timer = 140, offset = 3, dst = {geo.anim.glow1, geo.anim.glow2}},
			{id = "img_judgeline",	offset = 3, dst = {geo.judgeline}},
			{id = "sld_progress_song", loop = 1200, blend = 2, dst = geo.anim.progress_song_start},
			{id = "sld_progress_song", timer = 140, loop = 0, blend = 2, dst = geo.anim.progress_song_play},
			{id = "img_scratch", offset = 1,	dst = {geo.scratch}},
			{id = "num_gauge",					dst = {geo.num_gauge}},
			{id = "num_gauge_afterdot",			dst = {geo.num_gauge_ad}},
			{id = "gauge",						dst = {geo.gauge}},

			{id = "num_random_1", op = {80,917}, draw = function() return main_state.number(450) > 0 end, dst = {geo.num_random[1]}},
			{id = "num_random_2", op = {80,917}, draw = function() return main_state.number(451) > 0 end, dst = {geo.num_random[2]}},
			{id = "num_random_3", op = {80,917}, draw = function() return main_state.number(452) > 0 end, dst = {geo.num_random[3]}},
			{id = "num_random_4", op = {80,917}, draw = function() return main_state.number(453) > 0 end, dst = {geo.num_random[4]}},
			{id = "num_random_5", op = {80,917}, draw = function() return main_state.number(454) > 0 end, dst = {geo.num_random[5]}},
			{id = "num_random_6", op = {80,917}, draw = function() return main_state.number(455) > 0 end, dst = {geo.num_random[6]}},
			{id = "num_random_7", op = {80,917}, draw = function() return main_state.number(456) > 0 end, dst = {geo.num_random[7]}},
			{id = "num_random_1", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(450) > 0 end, dst = {geo.num_random[1], {time = 500, a = 0}}},
			{id = "num_random_2", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(451) > 0 end, dst = {geo.num_random[2], {time = 500, a = 0}}},
			{id = "num_random_3", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(452) > 0 end, dst = {geo.num_random[3], {time = 500, a = 0}}},
			{id = "num_random_4", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(453) > 0 end, dst = {geo.num_random[4], {time = 500, a = 0}}},
			{id = "num_random_5", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(454) > 0 end, dst = {geo.num_random[5], {time = 500, a = 0}}},
			{id = "num_random_6", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(455) > 0 end, dst = {geo.num_random[6], {time = 500, a = 0}}},
			{id = "num_random_7", timer = 40, loop = -1, op = {81,917}, draw = function() return main_state.number(456) > 0 end, dst = {geo.num_random[7], {time = 500, a = 0}}},
			
			{id = "img_level_beginner",	blend = 2, op = {151}, dst = {geo.level}},
			{id = "img_level_normal",	blend = 2, op = {152}, dst = {geo.level}},
			{id = "img_level_hyper",	blend = 2, op = {153}, dst = {geo.level}},
			{id = "img_level_another",	blend = 2, op = {154}, dst = {geo.level}},
			{id = "img_level_insane",	blend = 2, op = {155}, dst = {geo.level}},
			{id = "img_level_unknown",	blend = 2, op = {150}, dst = {geo.level}},
			
			{id = "num_level_beginner",	op = {151}, dst = {geo.num_level}},
			{id = "num_level_normal",	op = {152}, dst = {geo.num_level}},
			{id = "num_level_hyper",	op = {153}, dst = {geo.num_level}},
			{id = "num_level_another",	op = {154}, dst = {geo.num_level}},
			{id = "num_level_insane",	op = {155}, dst = {geo.num_level}},
			{id = "num_level_unknown",	op = {150}, dst = {geo.num_level}},
			
			{id = "num_score",			dst = {geo.num_score}},
			{id = "num_combo",			dst = {geo.num_combo}},
			{id = "num_speed",			dst = {geo.num_speed}},
			{id = "num_speed_afterdot",	dst = {geo.num_speed_ad}},
			
			{id = "img_keyflash_w", timer = 101, dst = {geo.keyflash[1]}},
			{id = "img_keyflash_w", timer = 103, dst = {geo.keyflash[3]}},
			{id = "img_keyflash_w", timer = 105, dst = {geo.keyflash[5]}},
			{id = "img_keyflash_w", timer = 107, dst = {geo.keyflash[7]}},
			{id = "img_keyflash_b", timer = 102, dst = {geo.keyflash[2]}},
			{id = "img_keyflash_b", timer = 104, dst = {geo.keyflash[4]}},
			{id = "img_keyflash_b", timer = 106, dst = {geo.keyflash[6]}},
			
			{id = "imgset_keybeam1",timer = 101, offset = 3,				dst = {geo.anim.keybeam_on[1]}},
			{id = "imgset_keybeam1",timer = 121, loop = -1, offset = 3,		dst = {geo.anim.keybeam_on[1], geo.anim.keybeam_off[1]}},
			{id = "imgset_keybeam2",timer = 102, offset = 3,				dst = {geo.anim.keybeam_on[2]}},
			{id = "imgset_keybeam2",timer = 122, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[2], geo.anim.keybeam_off[2]}},
			{id = "imgset_keybeam3",timer = 103, offset = 3,				dst = {geo.anim.keybeam_on[3]}},
			{id = "imgset_keybeam3",timer = 123, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[3], geo.anim.keybeam_off[3]}},
			{id = "imgset_keybeam4",timer = 104, offset = 3,				dst = {geo.anim.keybeam_on[4]}},
			{id = "imgset_keybeam4",timer = 124, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[4], geo.anim.keybeam_off[4]}},
			{id = "imgset_keybeam5",timer = 105, offset = 3,				dst = {geo.anim.keybeam_on[5]}},
			{id = "imgset_keybeam5",timer = 125, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[5], geo.anim.keybeam_off[5]}},
			{id = "imgset_keybeam6",timer = 106, offset = 3,				dst = {geo.anim.keybeam_on[6]}},
			{id = "imgset_keybeam6",timer = 126, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[6], geo.anim.keybeam_off[6]}},
			{id = "imgset_keybeam7",timer = 107, offset = 3,				dst = {geo.anim.keybeam_on[7]}},
			{id = "imgset_keybeam7",timer = 127, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[7], geo.anim.keybeam_off[7]}},
			{id = "imgset_keybeams",timer = 100, offset = 3,				dst = {geo.anim.keybeam_on[8]}},
			{id = "imgset_keybeams",timer = 120, loop = -1,  offset = 3,	dst = {geo.anim.keybeam_on[8], geo.anim.keybeam_off[8]}},
			
			{id = "notes"},
			
			{id = "cover_lane", loop = 1000,	filter = 1, stretch = 3, dst = geo.anim.cover_lane},
			{id = "cover_lift",					filter = 1, stretch = 3, dst = {geo.cover_lift}},
			{id = "cover_hidden",				filter = 1, stretch = 3, dst = {geo.cover_hidden}},
			{id = "cover_finish", loop = 1000,	filter = 1, stretch = 3, timer = 143, dst = geo.anim.cover_finish},
			{id = "judge"},
			
			{id = "img_fast", timer = 46, loop = -1, offsets = {3, 32, 33}, op = {908, 1242}, dst = {geo.judgedetail, {time = 500}}},
			{id = "img_slow", timer = 46, loop = -1, offsets = {3, 32, 33}, op = {908, 1243}, dst = {geo.judgedetail, {time = 500}}},
			
			{id = "num_ghost_mybest",	timer = 46, loop = -1, offsets = {3, 32, 33}, op = {905}, dst = {geo.num_ghost, {time = 500}}},
			{id = "num_ghost_target",	timer = 46, loop = -1, offsets = {3, 32, 33}, op = {906}, dst = {geo.num_ghost, {time = 500}}},
			{id = "num_ghost_high",		timer = 46, loop = -1, offsets = {3, 32, 33}, op = {940}, dst = {geo.num_ghost, {time = 500}}},
			{id = "num_ghost_low",		timer = 46, loop = -1, offsets = {3, 32, 33}, op = {941}, dst = {geo.num_ghost, {time = 500}}},
			
			{id = "num_cover_green",		offset = 4, op = {270},			dst = {geo.num_cover_lane_green}},
			{id = "num_cover_green",		offset = 3, op = {270, 272},	dst = {geo.num_cover_lift_green}},
			{id = "num_cover_lane_white",	offset = 4, op = {270},			dst = {geo.num_cover_lane_white}},
			{id = "num_cover_lift_white",	offset = 3, op = {270, 272},	dst = {geo.num_cover_lift_white}},
			
			{id = "imgset_bomb1", blend = 2, offset = 3, timer = 51, loop = -1, dst = {geo.bomb[1], {time = 250}}},
			{id = "imgset_bomb2", blend = 2, offset = 3, timer = 52, loop = -1, dst = {geo.bomb[2], {time = 250}}},
			{id = "imgset_bomb3", blend = 2, offset = 3, timer = 53, loop = -1, dst = {geo.bomb[3], {time = 250}}},
			{id = "imgset_bomb4", blend = 2, offset = 3, timer = 54, loop = -1, dst = {geo.bomb[4], {time = 250}}},
			{id = "imgset_bomb5", blend = 2, offset = 3, timer = 55, loop = -1, dst = {geo.bomb[5], {time = 250}}},
			{id = "imgset_bomb6", blend = 2, offset = 3, timer = 56, loop = -1, dst = {geo.bomb[6], {time = 250}}},
			{id = "imgset_bomb7", blend = 2, offset = 3, timer = 57, loop = -1, dst = {geo.bomb[7], {time = 250}}},
			{id = "imgset_bombs", blend = 2, offset = 3, timer = 50, loop = -1, dst = {geo.bomb[8], {time = 250}}},
			
			{id = "img_hold1", blend = 2, offset = 3, timer = 71, dst = {geo.bomb[1]}},
			{id = "img_hold2", blend = 2, offset = 3, timer = 72, dst = {geo.bomb[2]}},
			{id = "img_hold3", blend = 2, offset = 3, timer = 73, dst = {geo.bomb[3]}},
			{id = "img_hold4", blend = 2, offset = 3, timer = 74, dst = {geo.bomb[4]}},
			{id = "img_hold5", blend = 2, offset = 3, timer = 75, dst = {geo.bomb[5]}},
			{id = "img_hold6", blend = 2, offset = 3, timer = 76, dst = {geo.bomb[6]}},
			{id = "img_hold7", blend = 2, offset = 3, timer = 77, dst = {geo.bomb[7]}},
			{id = "img_holds", blend = 2, offset = 3, timer = 70, dst = {geo.bomb[8]}}
		}
		
		skin.note = parts.play.note
		skin.gauge = parts.play.gauge
		skin.judge = parts.play.judge
		append_all(skin.image, parts.play.image)
		append_all(skin.imageset, parts.play.imageset)
		append_all(skin.value, parts.play.value)
		append_all(skin.slider, parts.play.slider)
		append_all(skin.hiddenCover, parts.play.hiddenCover)
		append_all(skin.liftCover, parts.play.liftCover)
		append_all(skin.destination, parts.play.destination)
		--
		
		
		---[[ 拡張 simple-play用の拡張機能を追加してます
		extension_path = string.sub(package.path, 7, string.len(package.path) - 6) .. "/ex/"
		local ex = {
			parts1 = require("ex.log.parts").load(skin, extension_path .. "log"),
			parts2 = require("ex.metronome.parts").load(skin, extension_path .. "metronome"),
			parts3 = require("ex.strokesound.parts").load(skin, extension_path .. "strokesound")
		}
		if EnableLog()			then append_all(skin.customTimers, ex.parts1.customTimers) end
		if EnableMetronome()	then append_all(skin.customTimers, ex.parts2.customTimers) end
		if EnableStrokeSound()	then append_all(skin.customTimers, ex.parts3.customTimers) end
		--]]
		
		do
			parts.custom = {
				customTimers = {},
				image = {},
				destination = {}
			}
			-- コンボボイス
			-- TODO: プラクティス(1080) main_stateで取得できてない感じがする
			if EnableVoice() --[[and not main_state.option(1080)]] then
				parts.custom.image = {
					{id = "img_VOICEVOX_Tsumugi_Kasukabe", src = "src_VOICEVOX_Tsumugi_Kasukabe", x = 0, y = 0, w = -1, h = -1}
				}
				local tsumugi_pos = {
					x = geo.lane.x + (geo.lane.w / 2) - 128,
					y = geo.lane.y + 200
				}
				parts.custom.destination = {
					{id = "img_VOICEVOX_Tsumugi_Kasukabe", loop = -1, dst = {
						{time = 0, x = tsumugi_pos.x - 50, y = tsumugi_pos.y, w = 256, h = 256, a = 0},
						{time = 100},
						{time = 300, x = tsumugi_pos.x, a = 255},
						{time = 1800},
						{time = 2000, x = tsumugi_pos.x + 50, a = 0}
					}}
				}
				local combo = 0
				local misscount = 0
				local judgecount = {
					pg = 0,
					gr = 0,
					gd = 0
				}
				local vol = main_state.volume_sys() * 1.85 -- 音量調節用
				local flg = {true,true,true,true,true,true,true,true,true,true,true,true}
				parts.custom.customTimers = {
					{id = 10100, timer = function()
						-- init プラクティス対策
						if main_state.number(425) == 0
						and main_state.number(110) == 0
						and main_state.number(111) == 0
						and main_state.number(112) == 0
						then
							combo = 0
							misscount = 0
							judgecount = {
								pg = 0,
								gr = 0,
								gd = 0
							}
							flg = {true,true,true,true,true,true,true,true,true,true,true,true}
						end
						-- TODO: 104:NUMBER_COMBO(LR2 104:NOWCOMBO)が動くようになったらそっちを使う
						combo = main_state.number(110) - judgecount.pg + main_state.number(111) - judgecount.gr + main_state.number(112) - judgecount.gd
						if misscount < main_state.number(425) then
							if combo >= 100 then
								main_state.audio_play(extension_path .. "combocount/miss.wav", main_state.volume_sys() * 1.5)
							end
							misscount = main_state.number(425)
							judgecount.pg = main_state.number(110)
							judgecount.gr = main_state.number(111)
							judgecount.gd = main_state.number(112)
							flg = {true,true,true,true,true,true,true,true,true,true,true,true}
							combo = 0
						end
						if main_state.timer(48) ~= main_state.timer_off_value and flg[12] then
							flg = {false,false,false,false,false,false,false,false,false,false,false,false}
							main_state.audio_play(extension_path .. "combocount/fullcombo.wav", vol)
						elseif flg[1] and combo >= 100 then
							flg[1] = false
							main_state.audio_play(extension_path .. "combocount/100.wav", vol)
						elseif flg[2] and combo >= 300 then
							flg[2] = false
							main_state.audio_play(extension_path .. "combocount/300.wav", vol)
						elseif flg[3] and combo >= 500 then
							flg[3] = false
							main_state.audio_play(extension_path .. "combocount/500.wav", vol)
						elseif flg[4] and combo >= 1000 then
							flg[4] = false
							main_state.audio_play(extension_path .. "combocount/1000.wav", vol)
						elseif flg[5] and combo >= 1500 then
							flg[5] = false
							main_state.audio_play(extension_path .. "combocount/1500.wav", vol)
						elseif flg[6] and combo >= 2000 then
							flg[6] = false
							main_state.audio_play(extension_path .. "combocount/2000.wav", vol)
						elseif flg[7] and combo >= 2500 then
							flg[7] = false
							main_state.audio_play(extension_path .. "combocount/2500.wav", vol)
						elseif flg[8] and combo >= 3000 then
							flg[8] = false
							main_state.audio_play(extension_path .. "combocount/3000.wav", vol)
						elseif flg[9] and combo >= 4000 then
							flg[9] = false
							main_state.audio_play(extension_path .. "combocount/4000.wav", vol)
						elseif flg[10] and combo >= 5000 then
							flg[10] = false
							main_state.audio_play(extension_path .. "combocount/5000.wav", vol)
						elseif flg[11] and combo >= 10000 then
							flg[11] = false
							main_state.audio_play(extension_path .. "combocount/10000.wav", vol)
						end
					end}
				}
				append_all(skin.customTimers, parts.custom.customTimers)
				append_all(skin.image, parts.custom.image)
				append_all(skin.destination, parts.custom.destination)
			end
		end
		
		-- 全体の演出
		-- 開始
		parts.start.image = {
			{id = "img_loading", src = "src_loading", x = 0, y = 0, w = -1, h = -1},
			{id = "img_ready", src = "src_ready", x = 0, y = 0, w = -1, h = -1}
		}
		parts.start.value = {
			{id = "num_loading", src = "src_number_common_m", x = 0, y = 0, w = 190, h = 17, divx = 10, digit = 3, ref = 165},
		}
		parts.start.graph = {
			{id = "grh_loading", src = "src_loading", x = 0, y = 0, w = 1, h = 1, angle = 0, type = 102},
		}
		parts.start.destination = {
			{id = -110, loop = 200, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255},{time = 200, a = 0}}},
			{id = "img_loading", op = {80}, offset = 3, dst = {geo.img_loading}},
			{id = "num_loading", op = {80}, offset = 3, dst = {geo.num_loading}},
			{id = "grh_loading", blend = 9, op = {80}, offset = 3, dst = {geo.grh_loading}},
			{id = "img_ready", loop = -1, timer = 40, offset = 3, dst = geo.anim.ready}
		}
		append_all(skin.image, parts.start.image)
		append_all(skin.value, parts.start.value)
		append_all(skin.graph, parts.start.graph)
		append_all(skin.destination, parts.start.destination)
		--
		
		
		-- 終了
		parts.close.image = {
			{id = "img_fc_effect", src = "src_fceffect", x = 0, y = 0, w = -1, h = -1},
			{id = "img_fullcombo", src = "src_fullcombo", x = 0, y = 0, w = -1, h = -1}
		}
		parts.close.destination = {
			{id = "img_fc_effect", loop = -1, timer = 48, stretch = 3, blend = 2, dst = geo.anim.fullcombo_effect},
			{id = "img_fullcombo", loop = -1, timer = 48, dst = geo.anim.fullcombo},
			{id = -110, loop = 500, timer = 2, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 500, a = 255}}}
		}
		append_all(skin.image, parts.close.image)
		append_all(skin.destination, parts.close.destination)
		--
		
		
		-- 閉店
		parts.failed.destination = {
			{id = -110, loop = 400, timer = 3, dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},{time = 400, a = 255}}},
			{id = -110, loop = 500, timer = 3, dst = {{time = 0, x = 0, y = 1080, w = 1920, h = 1080},{time = 500, y = 0}}}
		}
		append_all(skin.destination, parts.failed.destination)
		--
	end
	
	return skin
	
end

return {
	header = header,
	main = main
}
