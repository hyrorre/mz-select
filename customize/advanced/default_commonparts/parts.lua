local parts = {}

local function load()	
	
	parts.source = {
		{id = "src-default-commonparts-system", path = "customize/advanced/default_commonparts/system.png"},
	}
		
	parts.font = {
		{id = "font-default-commonparts-VL-Gothic-Regular",	path = "customize/advanced/default_commonparts/font/VL-Gothic-Regular.ttf"},
		{id = "font-default-commonparts-mgenplus-1c-bold",	path = "customize/advanced/default_commonparts/font/mgenplus-1c-bold.ttf"},
		{id = "font-default-commonparts-mplus-1c-bold",		path = "customize/advanced/default_commonparts/font/mplus-1c-bold.ttf"},
		{id = "font-default-commonparts-title",				path = "customize/advanced/default_commonparts/font/title.fnt"},
		{id = "font-default-commonparts-sub",				path = "customize/advanced/default_commonparts/font/sub.fnt"},
		{id = "font-default-commonparts-m_select1",			path = "customize/advanced/default_commonparts/font/m_select_system.fnt"},
		{id = "font-default-commonparts-m_select2",			path = "customize/advanced/default_commonparts/font/m_select_profile.fnt"},
		{id = "font-default-commonparts-m_select3",			path = "customize/advanced/default_commonparts/font/m_select_profile_24.fnt"}
	}
	
	return parts	
end

return {
	parts = parts,
	load = load
}