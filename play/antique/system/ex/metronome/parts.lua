local parts = {}
local main_state = require("main_state")
local timer_util = require("timer_util")

local function load(skin, path)

	-- 最小発音間隔
	local se_min_time = 50000
	local customTimer_metronome = 10001
	local rhythm = {}
	local se = {
		path1 = (path .. "/metronome.wav"),
		vol = main_state.volume_sys()
	}
	print(se.path1)
	local tmp1 = 0
	local tmp2 = 100000
	local tmp3 = 0
	
	local endtimer = false
	
	local function metronome()
	
		local rhythmTimer_value = main_state.timer(140)
		local startTimer_value = main_state.timer(1)
		
		if rhythmTimer_value ~= main_state.timer_off_value
		and endtimer == false then
		
			local timewatch = timer_util.now_timer(rhythmTimer_value)
			local now_time = timer_util.now_timer(startTimer_value)
			local v = math.floor(timewatch / 1000000) + 1
			
			if timewatch == 0 then
				rhythm = {}
				tmp2 = now_time - tmp1
				--print("tmp: " .. tmp2)
				count = 0
			end
			
			if not rhythm[v] then
				tmp3 = now_time - tmp1
				if tmp3 > se_min_time then
					tmp1 = now_time
					rhythm[v] = true
					--print(v .. " - " .. timewatch)
					if tmp2 < 10000 then
						--print(v .. " - skip")
						tmp2 = now_time
					else
						main_state.audio_play(se.path1, se.vol)
					end
				end
			end
			
			if not (main_state.timer(2) == main_state.timer_off_value)
			or not (main_state.timer(3) == main_state.timer_off_value) then
				if endtimer == false then
					--print(skin_msg .. "dispose metronome")
				end
				endtimer = true
			end
			
		end
		
	end

	parts.customTimers = {{id = customTimer_metronome, timer = function() return metronome() end}}
	
	return parts
	
end

return {
	parts = parts,
	load = load
}