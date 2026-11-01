-- BMZ: actual opponent metadata, independent from the player's current options.
local function load()
	if not bmz then return nil end
	local prefix = "mz_battle_"
	local active, known, pattern, loading = 20200, 20201, 20202, 20203
	local parts = {
		bmzBattleInfo = true,
		source = {{id = prefix .. "keys", path = "result/keys1p.png"}},
		font = {{id = prefix .. "font", path = "customize/advanced/default_commonparts/font/mgenplus-1c-bold.ttf"}},
		panel = {}, image = {}, text = {}, destination = {},
	}
	local function destination(id, x, top, w, h, op, draw, color)
		local frame = {x = x, y = 1080 - top - h, w = w, h = h}
		if color then frame.r, frame.g, frame.b = color[1], color[2], color[3] end
		table.insert(parts.destination, {id = prefix .. id, op = op or {active}, draw = draw, dst = {frame}})
	end
	local function panel(id, color, x, top, w, h, border)
		table.insert(parts.panel, {id = prefix .. id, color = color, borderColor = border, borderWidth = border and 1 or 0})
		destination(id, x, top, w, h)
	end
	local function text(id, value, size, x, top, w, op, color, draw)
		local def = {id = prefix .. id, font = prefix .. "font", size = size, overflow = 1,
			outlineColor = "000000B0", outlineWidth = 0.5}
		if type(value) == "number" then def.ref = value
		elseif type(value) == "function" then def.value = value
		else def.constantText = value end
		table.insert(parts.text, def)
		destination(id, x, top, w, size, op, draw, color)
	end
	local muted, accent = {183, 207, 215}, {170, 238, 248}
	panel("body", "07141BD9", 324, 615, 337, 388, "CDDDE6FF")
	panel("header", "091116D9", 325, 616, 335, 38)
	panel("rule", "BDD5DCC0", 325, 654, 335, 1)
	text("title", "G-BATTLE", 26, 340, 620, 305)
	text("name", 20204, 27, 340, 664, 305)
	text("option_label", "RIVAL OPTION", 19, 340, 700, 305, nil, muted)
	text("arrange", 20205, 36, 340, 725, 305, {active, known}, accent)
	text("unknown", "オプション情報なし", 25, 340, 730, 305, {active, -known, -loading}, muted)
	text("loading", "読み込み中…", 25, 340, 730, 305, {active, loading}, muted)
	local function is_double()
		local mode = main_state.number(20208)
		return mode == 10 or mode == 14
	end
	text("arrange_2p", function()
		local value = main_state.text(20206)
		if value == "" then value = "未取得" end
		return "2P  " .. value .. "   /   " .. main_state.text(20207)
	end, 20, 340, 765, 305, {active, known}, muted, is_double)
	text("lane_label", "LANE ORDER", 19, 340, 788, 305, nil, muted)
	for _, kind in ipairs({"white", "black"}) do
		table.insert(parts.image, {id = prefix .. kind, src = prefix .. "keys", x = kind == "white" and 180 or 243, y = 138, w = 47, h = 70})
	end
	local function count()
		local mode = main_state.number(20208)
		if mode == 10 then return 5 elseif mode == 14 then return 7 else return mode end
	end
	for n = 4, 9 do
		local pitch = math.min(43, math.floor(305 / n))
		local width = pitch - 5
		for side = 1, 2 do
			for key = 1, n do
				local ref = 20210 + (side - 1) * 10 + key - 1
				local x = 340 + (key - 1) * pitch
				local top, height = side == 1 and 817 or 875, 48
				local function visible()
					return count() == n and (side == 1 or is_double()) and main_state.number(ref) > 0
				end
				local function black()
					local number = main_state.number(ref)
					return number == 2 or number == 4 or number == 6
				end
				destination("white", x, top, width, height, {active, pattern}, function() return visible() and not black() end)
				destination("black", x, top, width, height, {active, pattern}, function() return visible() and black() end)
				text("key_" .. n .. "_" .. side .. "_" .. key, function()
					local value = main_state.number(ref)
					if (main_state.number(20208) == 5 or main_state.number(20208) == 7 or is_double()) and value == n + 1 then return "S" end
					return tostring(value)
				end, 30, x + 8, top + 5, width - 7, {active, pattern}, nil, visible)
			end
		end
	end
	text("pattern_unknown", "固定配置なし / 未取得", 23, 340, 830, 305, {active, -pattern, -loading}, muted)
	panel("footer_rule", "8FAAB560", 340, 937, 305, 1)
	text("copy_label", "CHART REPLICATION", 18, 340, 943, 305, nil, muted)
	text("copy", 86, 26, 340, 966, 305, nil, accent)
	return parts
end
return {load = load}
