local parts = {}

local function load()
	
	local version = main_state.text(1010)
	version = string.sub(version, (string.find(version, " ") + 1))
	
	parts.text = {
		{id = "default_version", font = "font-default-commonparts-m_select1", size = 21, align = 0, constantText = version},
	}
		
	parts.destination = {
		{id = "default_version", dst = {{x = 6, y = 33, w = 21, h = 21}}},
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}