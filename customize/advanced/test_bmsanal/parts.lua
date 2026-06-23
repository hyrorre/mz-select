local parts = {}

local OP_ANALYSIS_OFF	= get_property_op()
local OP_ANALYSIS_ON	= get_property_op()
local TIMER_ANALYSIS	= get_customTimer_id()

parts.property = {
	{name = "楽曲分析情報を表示する(BMS Analysis)", item = {
		{name = "OFF",	op = OP_ANALYSIS_OFF},
		{name = "ON",	op = OP_ANALYSIS_ON}
	},def = "ON"}
}

parts.filepath = {}
parts.offset = {}

local function load()

	if skin_config.option["楽曲分析情報を表示する(BMS Analysis)"] == OP_ANALYSIS_ON then
	
		local function split(str, d)
			local s = str
			local t = {}
			local p = "%s*(.-)%s*" .. d .. "%s*"
			local f = function(v) table.insert(t, v) end
			if s ~= nil then
				string.gsub(s, p, f)
				f(string.gsub(s, p, ""))
			end
			return t
		end
		
		local now_song = {
			title = "",
			level = 0,
			total = 0
		}
		local display = {
			flag		= false,
			complex		= 0,
			power		= 0,
			rhythm		= 0,
			scratch		= 0,
			gimmick		= 0,
			holding		= 0
		}
		local analysis = {
			lookup		= {1,1,1,1,1,1,1,1,1},
			title		= {},
			level		= {},
			total		= {},
			complex		= {},
			power		= {},
			rhythm		= {},
			scratch		= {},
			gimmick		= {},
			holding		= {}
		}
		
		do
			local c = 1
			local file_csv = io.open("skin/m_select/list.csv", "r")
			for line in file_csv:lines() do
				local str = line
				str = string.gsub( str, "\r", "")
				local t = split(str, ",")
				if c > 1 then
					table.insert(analysis.level,	tonumber(t[analysis.lookup[1]]))
					table.insert(analysis.total,	tonumber(t[analysis.lookup[2]]))
					table.insert(analysis.complex,	tonumber(t[analysis.lookup[3]]))
					table.insert(analysis.power,	tonumber(t[analysis.lookup[4]]))
					table.insert(analysis.rhythm,	tonumber(t[analysis.lookup[5]]))
					table.insert(analysis.scratch,	tonumber(t[analysis.lookup[6]]))
					table.insert(analysis.gimmick,	tonumber(t[analysis.lookup[7]]))
					table.insert(analysis.holding,	tonumber(t[analysis.lookup[8]]))
					table.insert(analysis.title,	tostring(t[analysis.lookup[9]]))
					do -- フルタイトルに,が含まれている場合の対策
						local i = 1
						while true do
							if not t[analysis.lookup[9] + i] then
								break
							end
							analysis.title[#analysis.title] = analysis.title[#analysis.title] .. "," .. t[analysis.lookup[9] + i]
							i = i + 1
						end
					end
				else
					for i, v in pairs(t) do
						if		v == "楽曲レベル"	then analysis.lookup[1] = i
						elseif	v == "TOTAL値"		then analysis.lookup[2] = i
						elseif	v == "COMPLEX"		then analysis.lookup[3] = i
						elseif	v == "POWER"		then analysis.lookup[4] = i
						elseif	v == "RHYTHM"		then analysis.lookup[5] = i
						elseif	v == "SCRATCH"		then analysis.lookup[6] = i
						elseif	v == "GIMMICK"		then analysis.lookup[7] = i
						elseif	v == "HOLDING"		then analysis.lookup[8] = i
						elseif	v == "フルタイトル"	then analysis.lookup[9] = i
						end
					end
				end
				c = c + 1
			end
			file_csv:close()
		end
		
		parts.source = {
			{id = "src-analysis", path = "customize/advanced/test_bmsanal/parts.png"}
		}
		parts.font = {}
		parts.image = {
			{id = "ui-analysis", src = "src-analysis", x = 0, y = 0, w = -1, h = -1}
		}
		parts.imageset = {}
		parts.value = {}
		parts.graph = {}

		parts.text = {
			{id = "analysis-c",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.complex + 0.5) end},
			{id = "analysis-p",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.power + 0.5) end},
			{id = "analysis-r",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.rhythm + 0.5) end},
			{id = "analysis-s",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.scratch + 0.5) end},
			{id = "analysis-h",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.holding + 0.5) end},
			{id = "analysis-g",	font = "font-default-commonparts-m_select1", size = 18, align = 2, value = function() return math.floor(display.gimmick + 0.5) end}
		}
		
		-- 表示切替用
		parts.customTimers = {
			{id = TIMER_ANALYSIS, timer = function()
				
				 -- TODO: TOTAL値を楽曲特定に使うと動作がおかしい
				 -- ハッシュ値使いたい
				local display_song = {
					title = main_state.text(12),
					level = main_state.number(96),
					total = main_state.number(368)
				}

				if now_song.title ~= display_song.title
				or now_song.level ~= display_song.level
				--or now_song.total ~= display_song.total
				then
					-- TODO: 検索の効率化
					--[[
						csv側でフルタイトル順にソートしておく
						レベル毎にテーブルを分ける table_level = {{},{},...}
						選択中の楽曲レベルを添え字として使用する table_level[n + 1]
					--]]
					for i, v in pairs(analysis.title) do
						if	analysis.title[i] == display_song.title
						and	analysis.level[i] == display_song.level
						--and	analysis.total[i] == display_song.total
						then
							display.complex		= analysis.complex[i]
							display.power		= analysis.power[i]
							display.rhythm		= analysis.rhythm[i]
							display.scratch		= analysis.scratch[i]
							display.gimmick		= analysis.gimmick[i]
							display.holding		= analysis.holding[i]
							now_song.title		= display_song.title
							now_song.level		= display_song.level
							now_song.total		= display_song.total
							break
						end
					end
					if now_song.title ~= display_song.title
					and	analysis.level[i] ~= display_song.level
					--and	analysis.total[i] ~= display_song.total
					then
						display.complex		= 0
						display.power		= 0
						display.rhythm		= 0
						display.scratch		= 0
						display.gimmick		= 0
						display.holding		= 0
						now_song.title		= display_song.title
						now_song.level		= display_song.level
						now_song.total		= display_song.total
					end
				end
				
				if (display.complex + display.power + display.rhythm + display.scratch + display.gimmick + display.holding) == 0 then
					display.flag = false
				else
					display.flag = true
				end
			end}
		}
		
		parts.destination = {
			{id = "ui-analysis", draw = function() return display.flag end, dst = {{x = 377, y = 873, w = 705, h = 34}}},
			{id = "analysis-c", draw = function() return display.flag end, dst = {{x = 967 + 3, y = 879 - 2, w = 18, h = 18}}},
			{id = "analysis-p", draw = function() return display.flag end, dst = {{x = 1074 + 3, y = 879 - 2, w = 18, h = 18}}},
			{id = "analysis-r", draw = function() return display.flag end, dst = {{x = 840 + 3, y = 879 - 2, w = 18, h = 18}}},
			{id = "analysis-s", draw = function() return display.flag end, dst = {{x = 713 + 3, y = 879 - 2, w = 18, h = 18}}},
			{id = "analysis-h", draw = function() return display.flag end, dst = {{x = 606 + 3, y = 879 - 2, w = 18, h = 18}}},
			{id = "analysis-g", draw = function() return display.flag end, dst = {{x = 479 + 3, y = 879 - 2, w = 18, h = 18}}}
		}
		
		local tag = "bmsanalysis"
		for i = 1, #parts.source do
			parts.source[i].id = tag .. parts.source[i].id
		end
		for i = 1, #parts.image do
			parts.image[i].id = tag .. parts.image[i].id
			parts.image[i].src = tag .. parts.image[i].src
		end
		for i = 1, #parts.text do
			parts.text[i].id = tag .. parts.text[i].id
		end
		for i = 1, #parts.destination do
			parts.destination[i].id = tag .. parts.destination[i].id
		end
	
	end
			
	return parts	
end

return {
	parts = parts,
	load = load
}