local main_state = require("main_state")

local header = {
	type = 6,
	name = "m-select-decide (lua)",
	w = 1920,
	h = 1080,
	scene = 2500,
	input = 1000, -- 決定画面が1000以上表示されていないとプレイスキンでの処理落ちがひどい
	fadeout = 1000,
	property = {},
	filepath = {
		{name = "背景", path = "../customize/background/*"}
	}
}

local function main()

	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end

	skin.source = {
		{id = "src-bg", path = "../customize/background/*"},
		{id = "src-shutter", path = "shutter.png"},
	}
	skin.font = {
		{id = 1, path = "../customize/advanced/default_commonparts/font/title.fnt"},
		{id = 2, path = "../customize/advanced/default_commonparts/font/sub.fnt"},
	}
	skin.image = {
		{id = "bg", src = "src-bg", x = 0, y = 0, w = -1, h = -1},
		{id = "shutter1", src = "src-shutter", x = 0, y = 0, w = -1, h = 208},
		{id = "shutter2", src = "src-shutter", x = 0, y = 508, w = -1, h = 572}
	}
	skin.imageset = {}
	skin.value = {}
	
	local difficulty = main_state.number(96)
	local color = {
		r = 255,
		g = 255,
		b = 255
	}
	if main_state.option(150) then
		difficulty = "UNKNOWN"	.. difficulty .. " " .. main_state.text(1003)
	elseif main_state.option(151) then
		difficulty = "BIGINNER"	.. difficulty .. " " .. main_state.text(1003)
		color.r = 204
		color.b = 153
	elseif main_state.option(152) then
		difficulty = "NORMAL"	.. difficulty .. " " .. main_state.text(1003)
		color.r = 153
		color.g = 204
	elseif main_state.option(153) then
		difficulty = "HYPER"	.. difficulty .. " " .. main_state.text(1003)
		color.b = 153
	elseif main_state.option(154) then
		difficulty = "ANOTHER"	.. difficulty .. " " .. main_state.text(1003)
		color.g = 153
		color.b = 153
	elseif main_state.option(155) then
		difficulty = "INSANE"	.. difficulty .. " " .. main_state.text(1003)
		color.g = 153
	end
	skin.text = {
		{id = "title",		font = 1, size = 72, align = 2, ref = 10,	overflow = 1},
		{id = "genre",		font = 2, size = 24, align = 2, ref = 13,	overflow = 1},
		{id = "subtitle",	font = 2, size = 24, align = 2, ref = 11,	overflow = 1},
		{id = "artist",		font = 2, size = 24, align = 2, ref = 16,	overflow = 1},
		{id = "difficulty",	font = 2, size = 24, align = 2, constantText = difficulty, overflow = 1}
	}
	skin.slider = {}
	skin.judgegraph = {
		{id = "notesgraph", type = 0, backTexOff = 0, delay = 500, orderReverse = 0, noGap = 0}
	}
	skin.bpmgraph = {
		{id = "bpmgraph"}
	}
	skin.destination = {
		{id = "bg", loop = skin.scene, stretch = 3, filter = 1, dst = {
			{time = 0, x = -520, y = -270, w = 2880, h = 1620, a = 128},
			{time = skin.scene, x = -420}
		}},
		
		{id = "notesgraph", dst = {
			{x = 0, y = 572, w = 1920, h = 300, a = 64}
		}},
		
		{id = "bpmgraph", dst = {
			{x = 0, y = 572, w = 1920, h = 300, a = 64}
		}},
		
		{id = -110, loop = 800, dst = {
			{time = 0, x = 0, y = 0, w = 1920, h = 1080, acc = 2, a = 255},
			{time = 250},
			{time = 800, a = 0}
		}},
		
		{id = -100, loop = 500, stretch = 3, filter = 1, dst = {
			{time = 0, x = 18, y = 602, w = 320, h = 240, acc = 2},
			{time = 200},
			{time = 500, x = 240}
		}},
		
		{id = "title", loop = 500, dst = {
			{time = 0, x = 1080, y = 663, w = 724, h = 72, acc = 2},
			{time = 200},
			{time = 500, x = 1680}
		}},
		
		{id = "genre", loop = 500, op = {192}, dst = {
			{time = 0, x = 1080, y = 747, w = 724, h = 24, acc = 2},
			{time = 200},
			{time = 500, x = 1680}
		}},
		{id = "genre", loop = 500,op = {193}, dst = {
			{time = 0, x = 760, y = 747, w = 724, h = 24, acc = 2},
			{time = 200},
			{time = 500, x = 1360}
		}},
		
		{id = -102, stretch = 1, filter = 1, loop = 500, dst = {
			{time = 0, x = 780, y = 747, w = 300, h = 80, acc = 2},
			{time = 200},
			{time = 500, x = 1380}
		}},
		
		{id = "subtitle", loop = 500, dst = {
			{time = 0, x = 1080, y = 663, w = 724, h = 24, g = 153, acc = 2},
			{time = 200},
			{time = 500, x = 1680}
		}},
		
		{id = "artist", loop = 500, dst = {
			{time = 0, x = 1080, y = 633, w = 724, h = 24, acc = 2},
			{time = 200},
			{time = 500, x = 1680}
		}},
		
		{id = "difficulty", loop = 800, dst = {
			{time = 0, x = 1680, y = 550, w = 724, h = 36, r = color.r, g = color.g, b = color.b, acc = 2, a = 0},
			{time = 500},
			{time = 800, y = 580, a = 255}
		}},
		
		{id = "shutter1", blend = 2, loop = 1000, dst = {
			{time = 0, x = 0, y = 1080, w = 1920, h = 208, acc = 2},
			{time = 500},
			{time = 1000, y = 872}
		}},
		{id = "shutter2", blend = 2, loop = 1000, dst = {
			{time = 0, x = 0, y = -572, w = 1920, h = 572, acc = 2},
			{time = 500},
			{time = 1000, y = -0}
		}},
		
		{id = -110, loop = skin.scene, dst = {
			{time = skin.scene - 200, x = 0, y = 0, w = 1920, h = 1080, a = 0},
			{time = skin.scene, a = 255}
		}}
	}
	
	return skin
end

return {
	header = header,
	main = main
}
