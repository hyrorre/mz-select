-- BMZ DETAIL OPTIONS v1. Settings, translations and input belong to the player.
local function load()
	if not bmz or bmz.get_option("bmz_detail_options", "0") ~= "1" then return nil end
	local prefix = "mz_detail_"
	local pitch, left, width = 274, 9, 258
	local parts = {
		bmzDetailOptions = 1,
		bmzDetailOptionsNumbers = true,
		bmzDetailOptionsClose = true,
		source = {
			{id = prefix .. "panel", path = "customize/advanced/default_optionpanel4/panel2.png"},
			{id = prefix .. "panel3", path = "customize/advanced/default_optionpanel4/panel3.png"},
			{id = prefix .. "cursor", path = "customize/advanced/default_optionpanel4/cursor.png"},
		},
		font = {
			{id = prefix .. "font", path = "customize/advanced/default_commonparts/font/mgenplus-1c-bold.ttf"},
			-- The version/IR bitmap font, with only missing parentheses supplemented.
			{id = prefix .. "choices", path = "customize/advanced/default_detailoptions/choices.fnt"},
		},
		panel = {}, text = {}, image = {}, imageset = {}, destination = {},
	}
	local function panel(id, color)
		table.insert(parts.panel, {id = prefix .. id, color = color})
	end
	local function sprite(id, source, x, y, w, h)
		table.insert(parts.image, {id = prefix .. id, src = prefix .. source, x = x, y = y, w = w, h = h})
	end
	local function text(id, ref, size, align, choice, outline)
		table.insert(parts.text, {
			id = prefix .. id, font = prefix .. (choice and "choices" or "font"), ref = ref,
			size = size, align = align or 0, overflow = 1,
			outlineColor = outline and "000000FF" or nil, outlineWidth = outline,
		})
	end
	local function hit(id, event)
		table.insert(parts.image, {id = prefix .. id, src = -1, x = 0, y = 0, w = 1, h = 1, act = event, clickable = true})
	end
	-- Same 300 ms ease-out as the original Assist panel (timer 22, acc 2).
	-- A full-canvas carousel needs no opaque side masks: canvas clipping preserves
	-- the transparent song screen behind it. Overscan starts after the entrance.
	-- The selected item always lands in the centre slot 3. bmzDetailRaise lifts
	-- whichever column is passing the centre, following the scroll interpolation,
	-- for drawing, hit areas and the frozen exit alike.
	local selected_raise = 24
	local function draw(id, x, y, w, h, options, slot, color, alpha, blend)
		-- Drawing column: overscan slot 7 sits left of 0 and slot 8 right of 6.
		local raise = slot and {slot == 7 and -1 or slot == 8 and 7 or slot, selected_raise} or nil
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
			bmzDetailScroll = slot and {pitch, 0} or nil, bmzDetailRaise = raise,
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
				bmzDetailScroll = slot and {pitch, 0} or nil, bmzDetailRaise = raise,
			})
		end
	end
	panel("shade", "000000A8")
	panel("black", "000000FF")
	panel("footer", "00000070")
	-- Reuse the original artwork without modifying any image files. The 170x50
	-- button and cursor keep their end caps; only a plain column between the caps
	-- and the baked OFF label stretches, so no baked text is ever drawn.
	sprite("button_l", "panel", 331, 217, 12, 50)
	sprite("button_m", "panel", 351, 217, 20, 50)
	sprite("button_r", "panel", 489, 217, 12, 50)
	sprite("edge_h", "panel", 326, 153, 179, 1)
	-- Column colours follow each row's category. Every option card has the same
	-- 3 px rim and a plain header fill; {source, left, top} of the card used.
	local cards = {
		blue = {"panel", 325, 152}, -- REGUL SPEED
		green = {"panel3", 552, 222}, -- hi-speed
		orange = {"panel3", 118, 21}, -- gauge auto shift
		red = {"panel3", 452, 758}, -- display auto adjust
		pink = {"panel3", 692, 758}, -- judge timing
	}
	for name, card in pairs(cards) do
		sprite("header_" .. name, card[1], card[2] + 3, card[3] + 3, 176, 8)
		sprite("rim_h_" .. name, card[1], card[2] + 1, card[3] + 1, 179, 1)
		sprite("rim_v_" .. name, card[1], card[2], card[3] + 3, 3, 40)
	end
	-- Index = category_id: 1 LANE / HI-SPEED, 2 GAUGE, 4 LONG NOTE,
	-- 5 ASSIST / MODIFIER, 6 BGA, 7 JUDGE (0 and the retired 3 stay blue).
	local category_colors = {"blue", "blue", "green", "blue", "orange", "pink", "red", "blue"}
	-- An imageset per column picks the colour from that row's category_id, so
	-- the columns need no extra destinations or draw conditions.
	for slot = 0, 8 do
		for _, part in ipairs({"header", "rim_h", "rim_v"}) do
			local images = {}
			for _, name in ipairs(category_colors) do
				table.insert(images, prefix .. part .. "_" .. name)
			end
			table.insert(parts.imageset, {id = prefix .. part .. "_" .. slot,
				value = 19401 + slot * 10, images = images})
		end
	end
	sprite("value_selected_l", "cursor", 616, 500, 24, 50)
	sprite("value_selected_m", "cursor", 646, 500, 20, 50)
	sprite("value_selected_r", "cursor", 762, 500, 24, 50)
	hit("blocker", 0)
	-- Input is consumed immediately, including the uncovered area during entry.
	table.insert(parts.destination, {id = prefix .. "blocker", op = {19300, 22}, dst = {{x = 0, y = 0, w = 1920, h = 1080}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, 22}, timer = 22, loop = 300,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0}, {time = 300, a = 255}}})
	table.insert(parts.destination, {id = prefix .. "shade", op = {19300, -22}, timer = 32, loop = -1,
		dst = {{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 255}, {time = 300, a = 0}}})

	local function border(x, row, slot, alpha)
		draw("rim_h_" .. slot, x, 180, width, 3, {row}, slot, nil, alpha)
		draw("rim_h_" .. slot, x, 727, width, 3, {row}, slot, nil, alpha)
		draw("rim_v_" .. slot, x, 183, 3, 544, {row}, slot, nil, alpha)
		draw("rim_v_" .. slot, x + width - 3, 183, 3, 544, {row}, slot, nil, alpha)
	end
	-- Like panel2's cards, buttons sit 6 px inside the frame (3 px rim, 3 px fill).
	local button_x, button_w = 6, width - 12
	-- Three-slice a 170x50 part to the button width: fixed caps, stretched plain middle.
	local function three(id, cap, x, y, options, slot, blend)
		draw(id .. "_l", x, y, cap, 50, options, slot, nil, nil, blend)
		draw(id .. "_m", x + cap, y, button_w - cap * 2, 50, options, slot, nil, nil, blend)
		draw(id .. "_r", x + button_w - cap, y, cap, 50, options, slot, nil, nil, blend)
	end
	-- Card layout of panel2: a 3 px rim, an opaque header-colour fill, the title
	-- and a subtitle in the header, then 50 px buttons stacked from 65 px down.
	local first = 245
	for slot = 0, 8 do
		local position = slot == 7 and -1 or slot == 8 and 7 or slot
		local x = left + position * pitch
		local row = 19400 + slot * 10
		local id = "row_" .. slot
		hit(id .. "_hit", 19310 + slot)
		-- Black-edged like the titles printed on the normal cards.
		text(id .. "_label", row, 20, 1, false, 2)
		text(id .. "_caption", row + 3, 14, 1)
		text(id .. "_status", row + 2, 18, 1)
		text(id .. "_external", row + 1, 21, 1)
		draw(id .. "_hit", x, 180, width, 550, {row}, slot)
		draw("header_" .. slot, x + 3, 183, width - 6, 544, {row}, slot)
		border(x, row, slot, 92)
		border(x, row + 1, slot, 255)
		draw(id .. "_label", x + width / 2, 190, width - 20, 24, {row}, slot)
		draw(id .. "_caption", x + width / 2, 216, width - 20, 16, {row}, slot)
		draw(id .. "_status", x + width / 2, 699, width - 20, 22, {row}, slot, {223, 197, 143})
		draw(id .. "_external", x + width / 2, 652, width - 20, 30, {row, row + 4}, slot, {223, 197, 143})
		for choice = 0, 7 do
			local cell = 19500 + slot * 64 + choice * 4
			local name = id .. "_choice_" .. choice
			local y = first + choice * 50
			hit(name .. "_hit", cell)
			text(name, cell, 21, 1, true)
			three("button", 12, x + button_x, y, {cell}, slot)
			three("value_selected", 24, x + button_x, y, {cell + 1}, slot, 2)
			draw(name, x + width / 2, y + 14, 220, 24, {cell, row + 3}, slot)
			draw(name, x + width / 2, y + 14, 220, 24, {cell, -(row + 3)}, slot, {176, 176, 176})
			draw(name .. "_hit", x + button_x, y, button_w, 50, {cell + 2}, slot)
		end
		text(id .. "_number", row + 1, 21, 1, true)
		-- A number has no choice to highlight: draw it in an unselected button.
		three("button", 12, x + button_x, first, {row + 5}, slot)
		draw(id .. "_number", x + width / 2, first + 14, 220, 24, {row + 5}, slot)
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
