local parts = {}

local OP_SLIDESHOW_OFF		= get_property_op()
local OP_SLIDESHOW_ON		= get_property_op()

parts.property = {
	{name = "スライドショーを使用する", item = {
		{name = "OFF",	op = OP_SLIDESHOW_OFF},
		{name = "ON",	op = OP_SLIDESHOW_ON}
	},def = "OFF"},
}

local function getFilelist(path)
	--print("msg mselect: " .. path)
	local tbl = {}
	local txt_path = path .. "/list.txt"
	--print("msg mselect: " .. txt_path)
	local c = 1
	local f = io.open(txt_path, "r")
	for l in f:lines() do
		tbl[c] = l
		c = c + 1
		--print("msg mselect: " .. l)
	end
	io.close(f)
	return tbl
end

parts.filepath = {
	{name = "背景(スライドショー)", path = "customize/slideshow/*"}
}

local function load()

	if skin_config.option["スライドショーを使用する"] == OP_SLIDESHOW_ON then
	
		local slide_path = nil
		local list = {}
		
		do
			local slide_get_path = skin_config.get_path("customize/slideshow/*")
			--print("msg mselect: " .. slide_get_path)
			local slide_sub = string.find(slide_get_path, "customize")
			slide_path = string.sub(slide_get_path, slide_sub)
			--print("msg mselect: " .. slide_path)
			list = getFilelist(slide_get_path)
		end
		
		parts.source = {}
		parts.image = {}
		parts.destination = {{id = -110, dst = {{x = 0, y = 0, w = 1920, h = 1080}}}}
		
		do
			local switch = 1000
			local view = 8000
			local t = 0
			local end_time = view * #list
			for i, v in pairs(list) do
				table.insert(parts.source, {id = "src-default-slideshow" .. i, path = slide_path .. "/" .. v})
				table.insert(parts.image, {id = "img_default_slideshow" .. i, src = "src-default-slideshow" .. i, x = 0, y = 0, w = -1, h = -1})
				if i == 1 then
					table.insert(parts.destination,
						{id = "img_default_slideshow" .. i, filter = 1, stretch = 2, dst = {
							{time = t, x = -140, y = -45, w = 2080, h = 1170},
							{time = t + view, x = 0},
							{time = end_time}
						}}
					)
				t = t + view - switch
				else
					table.insert(parts.destination,
						{id = "img_default_slideshow" .. i, filter = 1, stretch = 2, dst = {
							{time = t - switch, x = -160, y = -45, w = 2080, h = 1170, a = 0},
							{time = t, x = -140, a = 255},
							{time = t + view + switch, x = 0},
							{time = end_time}
						}}
					)
				t = t + view
				end
					table.insert(parts.destination,
						{id = "img_default_slideshow1", filter = 1, stretch = 2, dst = {
							{time = end_time - switch, x = -160, y = -45, w = 2080, h = 1170, a = 0},
							{time = end_time, x = -140, a = 255}
						}}
					)
			end
		end
		
	end
	
	return parts	
end

return {
	parts = parts,
	load = load
}