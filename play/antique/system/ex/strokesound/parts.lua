local parts = {}
-- ガイドSEの拡張
-- LN時始点で発音 CN/HCN時始点のみ発音 BP/空打ち時の音声を追加
local main_state = require("main_state")

local timer_keysound = 10002

SOUNDEFFECT = {}
SOUNDEFFECT.timervalues = {
	0, 0, 0, 0, 0, 0, 0, 0, 0 ,0,
	0, 0, 0, 0, 0, 0, 0, 0, 0 ,0
}
SOUNDEFFECT.lasttimer = 0
SOUNDEFFECT.starttimer = false
SOUNDEFFECT.endtimer = false
SOUNDEFFECT.keys = 20

local function load(skin, path)
	
	SOUNDEFFECT.PATH = {
		pg = (path .. "/guide-pg.wav"), -- PGREAT
		gg = (path .. "/guide-gg.wav"), -- GREAT/GOOD
		bp = (path .. "/guide-bp.wav"), -- BAD/POOR
		bl = (path .. "/guide-bl.wav") -- BLANK
	}
	
	local flag_auto = main_state.option(33) -- オート時発音しない
	local flag_replay = main_state.option(84) -- リプレイ時発音しない
	local flag_ln = main_state.event_index(308) -- LNMODE index 0:LN 1:CN 2:HCN
	--print("LNMODE:" .. flag_ln)
	
	parts.customTimers = {
		{id = timer_keysound, timer = function()
			if SOUNDEFFECT.starttimer
			and not SOUNDEFFECT.endtimer
			and not flag_auto
			and not flag_replay
			then
				for i = 1, SOUNDEFFECT.keys do
					local vol = main_state.volume_sys()
					local value = main_state.timer(99 + i)
					local value_ln = main_state.timer(69 + i)
					local judge_index = main_state.event_index(499 + i) -- VALUE_JUDGE index 1:PG 2:GR-FAST 3:GR-SLOW ...
					if value > 0 and SOUNDEFFECT.timervalues[i] < value then
						SOUNDEFFECT.timervalues[i] = value
						if value - SOUNDEFFECT.lasttimer < 1000 * 10 then
							vol = vol / 3
						end
						SOUNDEFFECT.lasttimer = value
						-- 判定毎に出す音を変える
						if value_ln > 0 and flag_ln == 0 then
							-- LNMODE:LN時 LN始点
							main_state.audio_play(SOUNDEFFECT.PATH.pg, vol)
						else
							-- PG
							if judge_index == 1 then
								main_state.audio_play(SOUNDEFFECT.PATH.pg, vol)
							-- GR/GD
							elseif	judge_index == 2
							or		judge_index == 3
							or		judge_index == 4
							or		judge_index == 5 then
								main_state.audio_play(SOUNDEFFECT.PATH.gg, vol)
							-- BD/PR/KP
							elseif	judge_index == 6
							or		judge_index == 7
							or		judge_index == 8
							or		judge_index == 9
							or		judge_index == 10
							or		judge_index == 11 then
								main_state.audio_play(SOUNDEFFECT.PATH.bp, vol)
							-- 空打ち
							else
								main_state.audio_play(SOUNDEFFECT.PATH.bl, vol)
							end
						end
					end
				end					
				-- 終了時にリソース開放
				if not (main_state.timer(2) == main_state.timer_off_value)
				or not (main_state.timer(3) == main_state.timer_off_value) then
					if SOUNDEFFECT.endtimer == false then
						--print(skin_msg .. "dispose")
					end
					SOUNDEFFECT.endtimer = true
				end
			else
				-- プレイ開始前にキーボード等でスクラッチ前後同時入力するとすごい音が出る対策
				if not (main_state.timer(41) == main_state.timer_off_value) then
					SOUNDEFFECT.starttimer = true
				end
			end
		end}
	}
	
	return parts	
	
end

return {
	parts = parts,
	load = load
}