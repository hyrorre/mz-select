-- TODO: LN中終点までに離すと判定カウントされない
-- TODO: CN/HCN中終点までに離すと始点時の判定でカウントされる問題が発生している
-- 一時対策: 始点で判定カウントしない

local parts = {}
local main_state = require("main_state")
local timer_util = require("timer_util")

local timer_key_on	= {}	-- キーオン時の時刻を保持
local timer_key_off	= {}	-- キーオフ時の時刻を保持(ホールド中からキーオフ状態に移行したときのみ)
local state_hold	= {}	-- ホールド中かどうか(ホールド中は始点時の判定を保持)
local just			= {}	-- PGREAT数
local fast			= {}	-- FAST数
local slow			= {}	-- SLOW数
local blank			= {}	-- 空打ち数
local input			= {}	-- 入力数
local input_total	= 0		-- 総入力数
local judge_total	= 0		-- 総判定処理数
local keys			= 20
local timer_start	= false
local timer_end		= false
local timer_auto	= main_state.option(33)

-- 区間ログ
local section = {}
section.log = {
	timing = {},	-- 判定タイミング推移
	p1 = {
		just = {},
		fast = {},
		slow = {},
		blank = {}
	},
	p2 = {
		just = {},
		fast = {},
		slow = {},
		blank = {}
	}
}
section.tmp = {
	just = {},
	fast = {},
	slow = {},
	blank = {}
}
section.part = 110 -- 区間分割数
section.time = (((main_state.number(1163) * 60) + main_state.number(1164)) * 1000000) / section.part
section.pass = section.time

for i = 1, keys do
	table.insert(timer_key_on, 0)
	table.insert(timer_key_off, 0)
	table.insert(state_hold, 0)
	table.insert(just, 0)
	table.insert(fast, 0)
	table.insert(slow, 0)
	table.insert(blank, 0)
	table.insert(input, 0)
	table.insert(section.tmp.just, 0)
	table.insert(section.tmp.fast, 0)
	table.insert(section.tmp.slow, 0)
	table.insert(section.tmp.blank, 0)
end

local function load(skin, path)

	--[[ デバッグ用
	local pos = {x = 200, y = 500}

	parts.source = {{id = "hub-src-logger-num", path = "../../Hub/extension/log/parts.png"}}
	
	parts.value = {}
	parts.destination = {}
	for i = 1, keys do
		table.insert(parts.value, {id = "ex-count-input" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 4, value = function() return input[i] end})
		table.insert(parts.value, {id = "ex-count-just" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 4, value = function() return just[i] end})
		table.insert(parts.value, {id = "ex-count-fast" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 4, value = function() return fast[i] end})
		table.insert(parts.value, {id = "ex-count-slow" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 4, value = function() return slow[i] end})
		table.insert(parts.value, {id = "ex-count-blank" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 4, value = function() return blank[i] end})
		table.insert(parts.value, {id = "ex-state-hold" .. i,	src = "hub-src-logger-num", x = 0, y = 0, w = 143, h = 17, divx = 11, digit = 1, value = function() return state_hold[i] end})
		table.insert(parts.destination, {id = "ex-count-input" .. i,	dst = {{x = pos.x + 0,   y = pos.y + 400 - (20 * i), w = 13, h = 17}}})
		table.insert(parts.destination, {id = "ex-count-just" .. i,		dst = {{x = pos.x + 65,  y = pos.y + 400 - (20 * i), w = 13, h = 17, b = 128}}})
		table.insert(parts.destination, {id = "ex-count-fast" .. i,		dst = {{x = pos.x + 130, y = pos.y + 400 - (20 * i), w = 13, h = 17, r = 128, g = 128}}})
		table.insert(parts.destination, {id = "ex-count-slow" .. i,		dst = {{x = pos.x + 195, y = pos.y + 400 - (20 * i), w = 13, h = 17, g = 128, b = 128}}})
		table.insert(parts.destination, {id = "ex-count-blank" .. i,	dst = {{x = pos.x + 260, y = pos.y + 400 - (20 * i), w = 13, h = 17, r = 128, g = 128, b = 128}}})
		table.insert(parts.destination, {id = "ex-state-hold" .. i,		dst = {{x = pos.x + 325, y = pos.y + 400 - (20 * i), w = 13, h = 17, r = 128, b = 128}}})
	end
	--]]
	
	parts.customTimers = {
		{id = 10000, timer = function()
			if	timer_start	== true
			and	timer_end	== false
			and	timer_auto	== false then
				for i = 1, keys do
					local key_on	= main_state.timer(99 + i)
					local key_off	= main_state.timer(119 + i)
					local hold		= main_state.timer(69 + i)
					local judge_index = main_state.event_index(499 + i) -- VALUE_JUDGE index 1:PG 2:GR-FAST 3:GR-SLOW ...
					-- 打鍵時
					if key_on > 0 and timer_key_on[i] < key_on then
						timer_key_on[i] = key_on
						input[i] = input[i] + 1
						if hold ~= main_state.timer_off_value then -- ホールドタイマー動作時
							-- CN/HCN時判定カウントする
							-- LN時始点を叩いた時 judge_index == 8
							--[[ TODO: 一時対策としてコメントアウト
							if judge_index == 1 then
								just[i] = just[i] + 1
							elseif	judge_index == 2
							or		judge_index == 4
							or		judge_index == 6 then
								fast[i] = fast[i] + 1
							elseif	judge_index == 3
							or		judge_index == 5
							or		judge_index == 7 then
								slow[i] = slow[i] + 1
							end
							--]]
							state_hold[i] = judge_index
						elseif judge_index == 1 then
							just[i] = just[i] + 1
						elseif	judge_index == 2
						or		judge_index == 4
						or		judge_index == 6
						or		judge_index == 8
						or		judge_index == 10 then
							fast[i] = fast[i] + 1
						elseif	judge_index == 3
						or		judge_index == 5
						or		judge_index == 7
						or		judge_index == 9
						or		judge_index == 11 then
							slow[i] = slow[i] + 1
						elseif hold == main_state.timer_off_value then
							blank[i] = blank[i] + 1
						end
					end
					-- ホールド終了判定
					if key_off > 0 and timer_key_off[i] < key_off and state_hold[i] > 0 then
						timer_key_off[i] = key_off
						-- TODO: ここに修正処理を追加する必要がある
						-- CN/HCN時入力カウント
						if state_hold[i] < 8 then
							input[i] = input[i] + 1
						end
						if judge_index == 1 then
							just[i] = just[i] + 1
						elseif	judge_index == 2
						or		judge_index == 4
						or		judge_index == 6
						or		judge_index == 8
						or		judge_index == 10 then
							fast[i] = fast[i] + 1
						elseif	judge_index == 3
						or		judge_index == 5
						or		judge_index == 7
						or		judge_index == 9
						or		judge_index == 11 then
							slow[i] = slow[i] + 1
						end
						state_hold[i] = 0
					end
				end
				-- 区間ログ
				if timer_util.now_timer(41) >= section.pass then
					local t = {
						just1p = 0,
						just2p = 0,
						fast1p = 0,
						fast2p = 0,
						slow1p = 0,
						slow2p = 0,
						blank1p = 0,
						blank2p = 0
					}
					for i = 1, keys do
						if i <= 10 then
							t.just1p = t.just1p + just[i] - section.tmp.just[i]
							t.fast1p = t.fast1p + fast[i] - section.tmp.fast[i]
							t.slow1p = t.slow1p + slow[i] - section.tmp.slow[i]
							t.blank1p = t.blank1p + blank[i] - section.tmp.blank[i]
						else
							t.just2p = t.just2p + just[i] - section.tmp.just[i]
							t.fast2p = t.fast2p + fast[i] - section.tmp.fast[i]
							t.slow2p = t.slow2p + slow[i] - section.tmp.slow[i]
							t.blank2p = t.blank2p + blank[i] - section.tmp.blank[i]
						end
						section.tmp.just[i] = just[i]
						section.tmp.fast[i] = fast[i]
						section.tmp.slow[i] = slow[i]
						section.tmp.blank[i] = blank[i]
					end
					table.insert(section.log.timing, main_state.number(12))
					table.insert(section.log.p1.just, t.just1p)
					table.insert(section.log.p1.fast, t.fast1p)
					table.insert(section.log.p1.slow, t.slow1p)
					table.insert(section.log.p1.blank, t.blank1p)
					table.insert(section.log.p2.just, t.just2p)
					table.insert(section.log.p2.fast, t.fast2p)
					table.insert(section.log.p2.slow, t.slow2p)
					table.insert(section.log.p2.blank, t.blank2p)
					section.pass = section.pass + section.time
				end
				-- 終了
				if timer_end == false then
					if main_state.timer(2) ~= main_state.timer_off_value
					or main_state.timer(3) ~= main_state.timer_off_value
					then
						for i = 1, keys do
							input_total = input_total + input[i]
							judge_total = judge_total + just[i]
							judge_total = judge_total + fast[i]
							judge_total = judge_total + slow[i]
						end
						local t = os.date("*t")
						
						-- ログ出力
						local ex_logger = io.open("skin/m_select/play/antique/system/ex/log/log.lua", "w")
						ex_logger:write("return {\n")
						ex_logger:write("\tclock = " .. os.clock() .. ",\n")
						ex_logger:write("\tinput = {" .. table.concat(input, ",") .. "},\n")
						ex_logger:write("\tjust = {" .. table.concat(just, ",") .. "},\n")
						ex_logger:write("\tfast = {" .. table.concat(fast, ",") .. "},\n")
						ex_logger:write("\tslow = {" .. table.concat(slow, ",") .. "},\n")
						ex_logger:write("\tblank = {" .. table.concat(blank, ",") .. "},\n")
						ex_logger:write("\tinput_total = " .. input_total .. ",\n")
						ex_logger:write("\tjudge_total = " .. judge_total .. ",\n")
						ex_logger:write("\tsection_part = " .. section.part .. ",\n")
						ex_logger:write("\tsection_timing = {" .. table.concat(section.log.timing, ",") .. "},\n")
						ex_logger:write("\tsection_1p = {\n\t\tjust = {" .. table.concat(section.log.p1.just, ",") .. "},\n")
						ex_logger:write("\t\tfast = {" .. table.concat(section.log.p1.fast, ",") .. "},\n")
						ex_logger:write("\t\tslow = {" .. table.concat(section.log.p1.slow, ",") .. "},\n")
						ex_logger:write("\t\tblank = {" .. table.concat(section.log.p1.blank, ",") .. "}\n\t},\n")
						ex_logger:write("\tsection_2p = {\n\t\tjust = {" .. table.concat(section.log.p2.just, ",") .. "},\n")
						ex_logger:write("\t\tfast = {" .. table.concat(section.log.p2.fast, ",") .. "},\n")
						ex_logger:write("\t\tslow = {" .. table.concat(section.log.p2.slow, ",") .. "},\n")
						ex_logger:write("\t\tblank = {" .. table.concat(section.log.p2.blank, ",") .. "}\n\t},\n")
						ex_logger:write("\tskin_type = " .. skin.type .. "\n")
						ex_logger:write("}")
						ex_logger:close()
						timer_end = true
					end
				end
			else
				-- 開始
				if timer_start == false then
					if main_state.timer(41) ~= main_state.timer_off_value then
						timer_start = true
					end
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