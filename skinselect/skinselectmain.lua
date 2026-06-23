local header = {
	type		= 9,
	name		= "m-select-skinselect(lua)",
	w			= 1920,
	h			= 1080,
	scene		= 3000,
	input		= 500,
	fadeout		= 500,
	property	= {},
	filepath	= {}
}

local function append_all(list, list1)
	for i, v in ipairs(list1) do
		table.insert(list, v)
	end
end

local function main()

	local skin = {}
	for k, v in pairs(header) do
		skin[k] = v
	end
	
	-- 調整用
	local pos = {
		window		= {337, 612},
		font_offset	= 10,
		types = {
			999, 945, 891, 837, 783, 729, 675, 621, 540,
			486, 432, 378, 324, 270, 216,
			162, 108, 54, 0
		}
	}
	local size = {
		font	= 18,
		column	= 40
	}
	local sort = {
		types = {
			5, 6, 7, 15, 10, 8, 9, 11, 1,
			0, 4, 3, 2, 16, 17,
			13, 12, 14, 18
		}
	}
	
	skin.source = {
		{id = "bg",		path = "bg.png"},
		{id = "parts",	path = "parts.png"}
	}
	
	skin.font = {{id = 0, path = "../customize/advanced/default_commonparts/font/mgenplus-1c-bold.ttf"}}
	
	skin.image = {{id = "bg", src = "bg", x = 0, y = 0, w = 1920, h = 1080}}
	
	skin.imageset = {}
	
	skin.text = {}
	
	skin.slider = {}
	
	skin.destination = {{id = "bg", dst = {{x = 0, y = 0, w = 1920, h = 1080}}}}

	skin.skinSelect = {
		defaultType			= 0,
		customOffsetStyle	= 0,
		customPropertyCount	= 4, -- TODO: 0.8.5時点 act229が動作しない対策として小さい数値を入れてます
		sampleBMS			= {}
	}
	
	
	-- タイプセレクトここから
	do
		local parts = {
			image = {
				{id = "type-active",	src = "parts", x = 300, y = 0, w = 270, h = 54},
				{id = "off",			src = "parts", x = 0, y = 1026, w = 300, h = 54},
			},
			imageset = {},
			destination = {}
		}
		for i = 0, 18 do
			table.insert(parts.image, {id = "on-" .. i, src = "parts", x = 0, y = 54 * i, w = 300, h = 54})
			if i >= 16 then
				table.insert(parts.imageset, {id = "type-" .. i, images = {"off", "on-" .. i}, act = 370 + i, ref = 370 + i})
			else
				table.insert(parts.imageset, {id = "type-" .. i, images = {"off", "on-" .. i}, act = 170 + i, ref = 170 + i})
			end
			table.insert(parts.destination, {id = "type-active", dst = {{x = 0, y = pos.types[i + 1], w = 270, h = 54}}, mouseRect = {x = 0, y = 0, w = 270, h = 54}})
			table.insert(parts.destination, {id = "type-" .. sort.types[i + 1], dst = {{x = 0, y = pos.types[i + 1], w = 300, h = 54}}})
		end
		append_all(skin.image, parts.image)
		append_all(skin.imageset, parts.imageset)
		append_all(skin.destination, parts.destination)
	end
	-- タイプセレクトここまで
	
	
	-- カスタマイズウインドウここから
	do
		local parts = {
			image = {
				{id = "custom-window",	src = "parts", x = 300, y = 440, w = 1110, h = 440},
				{id = "button-skin",	src = "parts", x = 0, y = 1026, w = 1, h = 1, act = 190, click = 2},
				{id = "arrow-l-active",	src = "parts", x = 910, y = 64, w = 16, h = 20},
				{id = "arrow-r-active",	src = "parts", x = 926, y = 64, w = 16, h = 20}
			},
			text = {
				{id = "skin-name", font = 0, size = size.font, align = 1, overflow = 1, ref = 50}
			},
			slider = {
				{id = "scroll-fg",			src = "parts", x = 910, y = 0, w = 64, h = 64, angle = 2, range = 319, type = 7, changeable = false},
				{id = "scroll-collision",	src = "parts", x = 974, y = 0, w = 64, h = 64, angle = 2, range = 341, type = 7}
			},
			destination = {
				{id = "custom-window",			dst = {{x = pos.window[1], y = pos.window[2], w = 1110, h = 440}}},
				{id = "skin-name", filter = 1,	dst = {{x = pos.window[1] + 405, y = pos.window[2] + 400 + pos.font_offset,	w = 512, h = size.font}}},
				{id = -111,						dst = {{x = pos.window[1] + 149, y = pos.window[2] + 405, w = 512, h = 30, a = 32}}, mouseRect = {x = -26, y = -10, w = 564, h = 40}},
				{id = "button-skin",			dst = {{x = pos.window[1] + 123, y = pos.window[2] + 400, w = 564, h = 40}}},
				{id = "arrow-l-active",			dst = {{x = pos.window[1] + 123, y = pos.window[2] + 410, w = 16, h = 20}}, mouseRect = {x = 0, y = -10, w = 282, h = 40}},
				{id = "arrow-r-active",			dst = {{x = pos.window[1] + 671, y = pos.window[2] + 410, w = 16, h = 20}}, mouseRect = {x = -266, y = -10, w = 282, h = 40}},
				{id = "scroll-fg", blend = 2, loop = 0,	dst = {{time = 0,	x = pos.window[1] + 1065, y = pos.window[2] + 327, w = 64, h = 64, a = 255}, {time = 200, a = 162}}},
				{id = "scroll-collision",				dst = {{			x = pos.window[1] + 1065, y = pos.window[2] + 370, w = 64, h = 64}}}
			}
		}
		for i = 1, 10 do
			table.insert(parts.text, {id = "custom-label-" .. i, font = 0, size = size.font, align = 2, overflow = 1, ref = 99 + i})
			table.insert(parts.text, {id = "custom-value-" .. i, font = 0, size = size.font, align = 1, overflow = 1, ref = 109 + i})
			table.insert(parts.image, {id = "button-custom-" .. i, src = "parts", x = 0, y = 1026, w = 1, h = 1, act = 219 + i, click = 2})
			table.insert(parts.destination, {id = "custom-label-" .. i, filter = 1,	dst = {{x = pos.window[1] + 513,	y = pos.window[2] + 400 - (size.column * i) + pos.font_offset, w = 503, h = size.font}}})
			table.insert(parts.destination, {id = "custom-value-" .. i, filter = 1,	dst = {{x = pos.window[1] + 795,	y = pos.window[2] + 400 - (size.column * i) + pos.font_offset, w = 492, h = size.font}}})
			table.insert(parts.destination, {id = -111,								dst = {{x = pos.window[1] + 549,	y = pos.window[2] + 405 - (size.column * i), w = 492, h = 30, a = 32}}, mouseRect = {x = -26, y = -10, w = 544, h = 40}})
			table.insert(parts.destination, {id = "button-custom-" .. i,			dst = {{x = pos.window[1] + 523,	y = pos.window[2] + 400 - (size.column * i), w = 544, h = 40}}})
			table.insert(parts.destination, {id = "arrow-l-active",					dst = {{x = pos.window[1] + 523,	y = pos.window[2] + 410 - (size.column * i), w = 16, h = 20}}, mouseRect = {x = 0, y = -10, w = 272, h = 40}})
			table.insert(parts.destination, {id = "arrow-r-active",					dst = {{x = pos.window[1] + 1051,	y = pos.window[2] + 410 - (size.column * i), w = 16, h = 20}}, mouseRect = {x = -256, y = -10, w = 272, h = 40}})
		end
		append_all(skin.image, parts.image)
		append_all(skin.text, parts.text)
		append_all(skin.slider, parts.slider)
		append_all(skin.destination, parts.destination)
	end
	-- カスタマイズウインドウここまで
	
	
	return skin
	
end

return {
	header	= header,
	main	= main
}