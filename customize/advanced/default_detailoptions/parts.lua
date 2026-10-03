-- BMZ DETAIL OPTIONS v1. Settings, translations and input belong to the player.
local function load()
	if not bmz then return nil end
	local prefix = "mz_detail_"
	local pitch, left, width = 274, 9, 258
	local parts = {
		bmzDetailOptions = 1,
		bmzDetailOptionsClose = true,
		source = {
			{id = prefix .. "panel", path = "customize/advanced/default_optionpanel4/panel2.png"},
			{id = prefix .. "cursor", path = "customize/advanced/default_optionpanel4/cursor.png"},
		},
		font = {
			{id = prefix .. "font", path = "customize/advanced/default_commonparts/font/mgenplus-1c-bold.ttf"},
			-- The version/IR bitmap font, with only missing parentheses supplemented.
			{id = prefix .. "choices", path = "customize/advanced/default_detailoptions/choices.fnt"},
		},
		panel = {}, text = {}, image = {}, destination = {},
	}
	local function panel(id, color)
		table.insert(parts.panel, {id = prefix .. id, color = color})
	end
	local function sprite(id, source, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. source, x = x, y = y, w = w, h = h})
	end
	local function text(id, ref, size, align, choice)
		table.insert(parts.text, {
			id = prefix .. id, font = prefix .. (choice and "choices" or "font"), ref = ref,
			size = size, align = align or 0, overflow = 1,
		})
	end
	local function hit(id, event)
		table.insert(parts.image, {id = prefix .. id, src = -1, x = 0, y = 0, w = 1, h = 1, act = event, clickable = true})
	end
	-- Same 300 ms ease-out as the original Assist panel (timer 22, acc 2).
	-- A full-canvas carousel needs no opaque side masks: canvas clipping preserves
	-- the transparent song screen behind it. Overscan starts after the entrance.
	local function draw(id, x, y, w, h, options, slot, color, alpha, blend)
		local op = {19300, 22}
		for _, value in ipairs(options or {}) do table.insert(op, value) end
		local frame = {time = 0, x = x - 1920, y = 1080 - y - h, w = w, h = h, acc = 2, a = alpha or 255}
		if color then frame.r, frame.g, frame.b = color[1], color[2], color[3] end
		local frames = {frame, {time = 300, x = x}}
		if slot and slot >= 7 then
			frame.time, frame.x = 300, x
			frames = {frame}
		end
		table.insert(parts.destination, {
			id = prefix .. id, op = op, timer = 22, loop = 300, dst = frames, blend = blend,
			bmzDetailScroll = slot and {pitch, 0} or nil,
		})
		-- The player freezes display data on release; hit areas are never retained.
		if not id:match("_hit$") and (not slot or slot < 7) then
			local close_op = {19300, -22}
			for _, value in ipairs(options or {}) do table.insert(close_op, value) end
			local close_frame = {time = 0, x = x, y = 1080 - y - h, w = w, h = h, acc = 2, a = alpha or 255}
			if color then close_frame.r, close_frame.g, close_frame.b = color[1], color[2], color[3] end
			table.insert(parts.destination, {
				id = prefix .. id, op = close_op, timer = 32, loop = -1, blend = blend,
				dst = {close_frame, {time = 300, x = x - 1920}},
				bmzDetailScroll = slot and {pitch, 0} or nil,
			})
		end
	end
	panel("shade", "000000A8")
	panel("column", "00000050")
	panel("selected", "07373760")
	panel("black", "000000FF")
	panel("footer", "00000070")
	-- Reuse the original artwork without modifying any image files.
	sprite("button", "panel", 331, 217, 170, 50)
	sprite("header", "panel", 328, 155, 176, 8)
	sprite("edge_h", "panel", 326, 153, 179, 1)
	sprite("edge_v", "panel", 325, 155, 3, 162)
	sprite("value_selected", "cursor", 616, 500, 170, 50)
	hit("blocker", 0)
	-- Input is consumed immediately, including the uncovered area during entry.
	table.insert(parts.destination, {id = prefix .. "blocker", op = {19300, 22}, dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, 22}, timer = 22, loop = 300,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0}, {time = 300, a = 255}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, -22}, timer = 32, loop = -1,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255}, {time = 300, a = 0}}})

	local function border(x, row, slot, alpha)
		draw("edge_h", x, 180, width, 3, {row}, slot, nil, alpha)
		draw("edge_h", x, 727, width, 3, {row}, slot, nil, alpha)
		draw("edge_v", x, 183, 3, 544, {row}, slot, nil, alpha)
		draw("edge_v", x + width - 3, 183, 3, 544, {row}, slot, nil, alpha)
	end
	for slot = 0, 8 do
		local position = slot == 7 and -1 or slot == 8 and 7 or slot
		local x = left + position * pitch
		local row = 19400 + slot * 10
		local id = "row_" .. slot
		hit(id .. "_hit", 19310 + slot)
		text(id .. "_label", row, 24, 1)
		text(id .. "_status", row + 2, 18, 1)
		text(id .. "_external", row + 1, 21, 1)
		draw(id .. "_hit", x, 180, width, 550, {row}, slot)
		draw("column", x, 180, width, 550, {row}, slot)
		draw("selected", x, 180, width, 550, {row + 1}, slot)
		border(x, row, slot, 92)
		border(x, row + 1, slot, 255)
		draw("header", x + 4, 184, width - 8, 66, {row}, slot, nil, 170)
		draw("header", x + 4, 184, width - 8, 66, {row + 1}, slot)
		draw(id .. "_label", x + width / 2, 200, width - 20, 34, {row}, slot)
		draw(id .. "_status", x + width / 2, 699, width - 20, 22, {row}, slot, {223, 197, 143})
		draw(id .. "_external", x + width / 2, 652, width - 20, 30, {row, row + 4}, slot, {223, 197, 143})
		for choice = 0, 7 do
			local cell = 19500 + slot * 64 + choice * 4
			local name = id .. "_choice_" .. choice
			local y = 274 + choice * 52
			hit(name .. "_hit", cell)
			text(name, cell, 21, 1, true)
			draw("button", x + 11, y, 236, 50, {cell}, slot)
			-- Hide the baked OFF label inside the unchanged bevel, then draw live text.
			draw("black", x + 27, y + 9, 204, 31, {cell}, slot)
			draw("value_selected", x + 11, y, 236, 50, {cell + 1}, slot, nil, 210, 2)
			draw(name, x + width / 2, y + 14, 206, 24, {cell, row + 3}, slot)
			draw(name, x + width / 2, y + 14, 206, 24, {cell, -(row + 3)}, slot, {176, 176, 176})
			draw(name .. "_hit", x + 11, y, 236, 50, {cell + 2}, slot)
		end
	end

	-- Only the information in the requested crop: category, value, description,
	-- saved amount / GAS mode, and an explanatory reason when needed.
	draw("footer", 9, 742, 1902, 182)
	draw("edge_h", 9, 742, 1902, 1, nil, nil, nil, 110)
	text("category", 19302, 22)
	text("value", 19301, 21, 2)
	text("description", 19303, 22)
	text("auxiliary", 19305, 22)
	text("reason", 19304, 21)
	draw("category", 24, 756, 1260, 30, nil, nil, {113, 233, 242})
	draw("value", 1894, 756, 520, 30)
	draw("description", 24, 796, 1870, 32)
	draw("auxiliary", 24, 836, 1870, 30, nil, nil, {178, 202, 211})
	draw("reason", 24, 876, 1870, 30, nil, nil, {223, 197, 143})
	-- Keep overscan out of pillarbox bars on wide windows. These masks are
	-- entirely outside the skin canvas, so no song-screen pixels are covered.
	for _, x in ipairs({-1920, 1920}) do
		table.insert(parts.destination, {id = prefix .. "black", op = {19300},
			dst = {{x = x, y = 0, w = 1920, h = 1080}}})
	end
	return parts
end

return {parts = {}, load = load}
