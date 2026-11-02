-- BMZ: actual opponent metadata, using the select skin's existing artwork.
local function load()
	if not bmz then return nil end
	local prefix = "mz_battle_"
	local active, known, pattern, loading = 20200, 20201, 20202, 20203
	-- The chart panel artwork has four transparent rows above its visible edge.
	local top_offset = 4
	local parts = {
		bmzBattleInfo = true,
		source = {
			{id = prefix .. "background", path = "customize/advanced/default_irdata/irdata_bg.png"},
			{id = prefix .. "options", path = "customize/advanced/default_stateplayoption/parts.png"},
			{id = prefix .. "options_bmz", path = "customize/advanced/default_stateplayoption/random_bmz.png"},
			{id = prefix .. "keys", path = "result/keys1p.png"},
		},
		font = {
			{id = prefix .. "system", path = "customize/advanced/default_commonparts/font/m_select_system.fnt"},
		},
		panel = {}, image = {}, text = {}, destination = {},
	}
	local function destination(id, x, top, w, h, op, draw, muted)
		local frame = {x = x, y = 1080 - top - h - top_offset, w = w, h = h}
		-- Native NO PLAY glyphs have an opaque RGB(116, 116, 116) face.
		if muted then frame.r, frame.g, frame.b = 116, 116, 116 end
		table.insert(parts.destination, {id = prefix .. id, op = op or {active}, draw = draw,
			dst = {frame}})
	end
	local function sprite(id, source, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. source, x = x, y = y, w = w, h = h})
	end
	local function text(id, value, x, top, width, options)
		options = options or {}
		local size = options.size or 21
		local def = {id = prefix .. id, font = prefix .. "system",
			size = size, overflow = 1}
		if type(value) == "number" then def.ref = value
		elseif type(value) == "function" then def.value = value
		else def.constantText = value end
		table.insert(parts.text, def)
		destination(id, x, top, width, options.height or size, options.op, options.draw, options.muted)
	end
	local function is_double()
		local mode = main_state.number(20208)
		return mode == 10 or mode == 14
	end
	local function not_fixed()
		for _, ref in ipairs(is_double() and {20205, 20206} or {20205}) do
			local value = main_state.text(ref)
			if value == "S-RANDOM" or value == "SPIRAL" or value == "H-RANDOM"
				or value == "ALL-SCR" or value == "S-RANDOM-EX" then return true end
		end
		return false
	end
	-- Disjoint strips preserve the native 50% black and the left line's edges.
	sprite("body", "background", 10, 10, 1, 1)
	sprite("left", "background", 0, 10, 10, 1)
	for _, double in ipairs({false, true}) do
		local function visible() return is_double() == double end
		destination("body", 334, 615, 327, double and 302 or 200, nil, visible)
		destination("left", 324, 615, 10, double and 302 or 200, nil, visible)
	end
	text("title", "g-battle data", 351, 623, 288, {height = 26})
	text("unknown", "NO DATA", 357, 667, 288, {op = {active, -known, -loading}, muted = true})
	text("loading", "LOADING", 357, 667, 288, {op = {active, loading}, muted = true})
	local arrangements = {"NORMAL", "MIRROR", "RANDOM", "R-RANDOM", "S-RANDOM", "SPIRAL",
		"H-RANDOM", "ALL-SCR", "RANDOM-EX", "S-RANDOM-EX", "F-RANDOM", "MF-RANDOM"}
	-- Remove each sprite's centered padding without scaling its letters.
	local insets = {28, 34, 28, 10, 10, 34, 10, 19, 28, 10, 10, 1}
	for index, arrange in ipairs(arrangements) do
		local id = "arrange_" .. index
		local inset, width = insets[index], 166 - insets[index] * 2
		sprite(id, index <= 10 and "options" or "options_bmz", inset, ((index - 1) % 10) * 19, width, 19)
		for _, double in ipairs({false, true}) do
			destination(id, double and 405 or 357, 667, width, 19, {active, known}, function()
				return is_double() == double and main_state.text(20205) == arrange
			end)
		end
		destination(id, 405, 693, width, 19, {active, known}, function()
			return is_double() and main_state.text(20206) == arrange
		end)
	end
	for _, row in ipairs({{id = "p1", label = "1P", top = 667}, {id = "p2", label = "2P", top = 693},
		{id = "dp", label = "DP", top = 719}}) do
		text(row.id, row.label, 357, row.top, 40, {op = {active, known}, draw = is_double})
	end
	text("unknown_2p", "NO DATA", 405, 693, 240, {op = {active, known}, muted = true, draw = function()
		return is_double() and main_state.text(20206) == ""
	end})
	text("dp_option", 20207, 405, 719, 240, {op = {active, known}, draw = is_double})
	text("unknown_dp", "NO DATA", 405, 719, 240, {op = {active, known}, muted = true, draw = function()
		return is_double() and main_state.text(20207) == ""
	end})
	for _, kind in ipairs({"white", "black"}) do
		sprite(kind, "keys", kind == "white" and 180 or 243, 138, 47, 70)
	end
	local function count()
		local mode = main_state.number(20208)
		if mode == 10 then return 5 elseif mode == 14 then return 7 else return mode end
	end
	for n = 4, 9 do
		for _, double in ipairs({false, true}) do
			local left, width = double and 397 or 357, double and 248 or 288
			local pitch = math.min(40, math.floor(width / n))
			for side = 1, double and 2 or 1 do
				local top = double and (side == 1 and 761 or 811) or 709
				for key = 1, n do
					local ref = 20210 + (side - 1) * 10 + key - 1
					local x, tile = left + (key - 1) * pitch, pitch - 5
					local function visible()
						return is_double() == double and count() == n and main_state.number(ref) > 0
					end
					-- Even original lanes are black keys, 8 included; the scratch stays white.
					local function black()
						local number = main_state.number(ref)
						local mode = main_state.number(20208)
						local scratch = (mode == 5 or mode == 7 or double) and number == n + 1
						return number % 2 == 0 and not scratch
					end
					destination("white", x, top, tile, 40, {active, pattern}, function() return visible() and not black() end)
					destination("black", x, top, tile, 40, {active, pattern}, function() return visible() and black() end)
					text("key_" .. n .. "_" .. tostring(double) .. "_" .. side .. "_" .. key, function()
						local value = main_state.number(ref)
						if (main_state.number(20208) == 5 or main_state.number(20208) == 7 or double) and value == n + 1 then return "S" end
						return tostring(value)
					end, x + math.floor((tile - 20) / 2), top + 9, 20, {op = {active, pattern}, draw = visible})
				end
			end
		end
	end
	for side = 1, 2 do
		text("lane_p" .. side, side .. "P", 351, side == 1 and 770 or 820, 40,
			{op = {active, pattern}, draw = is_double})
	end
	for _, double in ipairs({false, true}) do
		local function visible() return is_double() == double end
		text("pattern_status_" .. tostring(double), function() return not_fixed() and "NOT FIXED" or "NO DATA" end,
			357, double and 771 or 719, 288, {op = {active, -pattern, -loading}, draw = visible, muted = true})
		text("copy_" .. tostring(double), 86, 357, double and 877 or 775, 288, {draw = visible})
	end
	return parts
end
return {load = load}
