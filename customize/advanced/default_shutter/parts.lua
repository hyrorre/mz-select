local parts = {}

local OP_SHUTTER_OFF	= get_property_op()
local OP_SHUTTER_ON		= get_property_op()

parts.property = {
	{name = "スキン起動時シャッターを表示する", item = {
		{name = "OFF",	op = OP_SHUTTER_OFF},
		{name = "ON",	op = OP_SHUTTER_ON}
	},def = "ON"}
}
	
parts.filepath = {}
	
parts.offset = {}

local function load()	
	parts.source = {
		{id = "src-shutter", path = "customize/advanced/default_shutter/shutter.png"}
	}

	parts.font = {}

	parts.image = {
		{id = "img-shutter", src = "src-shutter", x = 0, y = 0, w = -1, h = -1}
	}

	parts.imageset = {}

	parts.value = {}

	parts.text = {}

	parts.slider = {}

	parts.graph = {}
	
	parts.judgegraph = {}
	
	parts.bpmgraph = {}

	parts.customEvents = {}
	
	parts.customTimers = {}
	
	parts.destination = {
		{id = "img-shutter", loop = 400, op = {OP_SHUTTER_ON}, dst = {
			{time = 0, x = -640, y = 0, w = 2560, h = 1080, acc = 2},{time = 400, x = 1920},
		}}
	}
	
	-- 他のパーツとのid被りを防ぐために先頭にフォルダ名を付けています
	local folder_name = "shutter"
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