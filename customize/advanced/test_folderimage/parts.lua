local parts = {}

local TIMER_FOLDER = get_customTimer_id()

local flag = {
	gdbg2022 = false,
	gdbg2023 = false,
	bmssp2022 = false,
	ng_insane = false,
	ng_normal = false
}

local function load()	
	parts.source = {
		{id = "src-folder-image", path = "customize/advanced/test_folderimage/parts.png"}
	}

	parts.image = {
		{id = "img-gdbg2022", src = "src-folder-image", x = 0, y = 0, w = 160, h = 80},
		{id = "img-gdbg2023", src = "src-folder-image", x = 0, y = 160, w = 160, h = 80},
		{id = "img-bmssp2022", src = "src-folder-image", x = 0, y = 80, w = 160, h = 80},
		{id = "img-ng_insane", src = "src-folder-image", x = 160, y = 0, w = 160, h = 80},
		{id = "img-ng_normal", src = "src-folder-image", x = 160, y = 80, w = 160, h = 80}
	}
	
	parts.customTimers = {
		{id = TIMER_FOLDER, timer = function()
		
			local folder_name = main_state.text(1000)
			
			-- GdbG2022
			if string.find(folder_name, "GdbG BMS Package 2022") and main_state.option(2) then
				flag.gdbg2022 = true
			else
				flag.gdbg2022 = false
			end
			
			-- GdbG2023
			if string.find(folder_name, "GdbG BMS Package 2023") and main_state.option(2) then
				flag.gdbg2023 = true
			else
				flag.gdbg2023 = false
			end
			
			-- bmssp2022
			if string.find(folder_name, "BMS_Starter_Pack_2022") and main_state.option(2) then
				flag.bmssp2022 = true
			else
				flag.bmssp2022 = false
			end
			
			-- NEW GENERATION 通常難易度表
			if string.find(folder_name, "NEW GENERATION 通常難易度表") and main_state.option(2) then
				flag.ng_normal = true
			else
				flag.ng_normal = false
			end
			
			-- NEW GENERATION 発狂難易度表
			if string.find(folder_name, "NEW GENERATION 発狂難易度表") and main_state.option(2) then
				flag.ng_insane = true
			else
				flag.ng_insane = false
			end
			
		end},
	}
	
	parts.destination = {
		{id = "img-gdbg2022", draw = function() return flag.gdbg2022 end, dst = {{x = 355, y = 776, w = 160, h = 80}}},
		{id = "img-gdbg2023", draw = function() return flag.gdbg2023 end, dst = {{x = 355, y = 776, w = 160, h = 80}}},
		{id = "img-bmssp2022", draw = function() return flag.bmssp2022 end, dst = {{x = 355, y = 776, w = 160, h = 80}}},
		{id = "img-ng_insane", draw = function() return flag.ng_insane end, dst = {{x = 355, y = 776, w = 160, h = 80}}},
		{id = "img-ng_normal", draw = function() return flag.ng_normal end, dst = {{x = 355, y = 776, w = 160, h = 80}}}
	}
	
	-- 他のパーツとのid被りを防ぐために先頭にフォルダ名を付けています
	local folder_name = "folder_image"
	for i = 1, #parts.source do
		parts.source[i].id = folder_name .. parts.source[i].id
	end
	for i = 1, #parts.image do
		parts.image[i].id = folder_name .. parts.image[i].id
		parts.image[i].src = folder_name .. parts.image[i].src
	end
	for i = 1, #parts.destination do
		parts.destination[i].id = folder_name .. parts.destination[i].id
	end
			
	return parts	
end

return {
	parts = parts,
	load = load
}