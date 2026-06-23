-- TODO: 内部バージョンを持たせてスキン更新時にデータを初期化するように変更する
local parts = {}

local OP_RANK_OFF	= get_property_op()
local OP_RANK_ON	= get_property_op()
local OP_RESULT_RESET_OFF	= get_property_op()
local OP_RESULT_RESET_ON	= get_property_op()

local function zero_padding(num)
	if		string.len(tostring(num)) == 0 then return "00"
	elseif	string.len(tostring(num)) == 1 then return "0" .. num
	end
	return num
end

parts.filepath = {
	{name = "プロフィール画像", path = "customize/profile/*"}
}

parts.property = {
	{name = "プレイヤー情報を表示する", item = {
		{name = "OFF",	op = OP_RANK_OFF},
		{name = "ON",	op = OP_RANK_ON}
	},def = "ON"},
	{name = "日付変更時に今日の成果をリセットする", item = {
		{name = "OFF",	op = OP_RESULT_RESET_OFF},
		{name = "ON",	op = OP_RESULT_RESET_ON}
	},def = "ON"},
}

local function load()

	if skin_config.option["プレイヤー情報を表示する"] == OP_RANK_ON then
	
		-- ランク関連
		local font1_id = "font-default-commonparts-VL-Gothic-Regular"
	
		-- プレイヤーランクの表示
		-- 現在のランク
		local current_rank = 0
		-- 累計経験値
		local total_exp = 0
		-- 次のランクまでに必要な経験値
		local next_exp = 0
		-- 次のランクまでに必要な経験値(割合)
		local next_exp_per = 0
		-- 現在のランクの経験値
		local current_exp = 0
		-- ランク到達に必要な累計経験値
		local next_total_exp = 0
		
		do
			-- ランク上限
			local rank_cap = 500
			-- 累計パーフェクトグレート数
			local total_pf = main_state.number(33)
			-- 累計グレート数
			local total_gr = main_state.number(34)
			-- 累計経験値(累計EXスコア)
			total_exp = (total_pf * 2) + (total_gr)
			
			-- 経験値テーブル計算用
			local rank_exp_0_100	= 50000
			local rank_exp_100_200	= 100000
			local rank_exp_200_250	= 150000
			local rank_exp_250_500	= 300000
			--[[ 確認用
			local f1 = io.open("skin/m_select/exp_table.txt", "w")
			local f2 = io.open("skin/m_select/total_exp_table.txt", "w")
			--]]
			for i = 1, rank_cap do
				if i <= 100 then		next_exp = ((rank_exp_0_100 / 100) * i)
				elseif i < 200 then		next_exp = rank_exp_0_100 + ((rank_exp_100_200 / 100) * (i - 100))
				elseif i < 250 then		next_exp = rank_exp_0_100 + rank_exp_100_200 + ((rank_exp_200_250 / 50) * (i - 200))
				elseif i < 500 then		next_exp = rank_exp_0_100 + rank_exp_100_200 + rank_exp_200_250 + ((rank_exp_250_500 / 50) * (i - 250))
				elseif i == 500 then	next_exp = 0
				end
				next_total_exp = next_total_exp + next_exp
				--[[
				f1:write(next_exp .. "\n")
				f2:write(next_total_exp .. "\n")
				--]]
				current_rank = i
				if next_total_exp > total_exp then 
					current_exp = next_exp - (next_total_exp - total_exp)
					next_exp_per = (current_exp / next_exp)
					break
				end
			end
			--[[
			f1:close()
			f2:close()
			--]]			
		end
		-- ランク関連ここまで
		
		-- プロフィール関連
		local font2_id = "font-default-commonparts-m_select2"
		local flg = false
		local timer = {
			on	= get_customTimer_id(),
			off	= get_customTimer_id()
		}
		
		local profile = {}
		profile.name	= main_state.text(2)
		profile.hh		= main_state.number(17)
		profile.mm		= main_state.number(18)
		profile.ss		= main_state.number(19)
		profile.play	= main_state.number(30)
		profile.clear	= main_state.number(31)
		profile.pf		= main_state.number(33)
		profile.gr		= main_state.number(34)
		profile.gd		= main_state.number(35)
		profile.bd		= main_state.number(36)
		profile.pr		= main_state.number(37)
		profile.note	= main_state.number(333)
		
		profile.time	= profile.hh .. ":" .. zero_padding(profile.mm) .. ":" .. zero_padding(profile.ss)
		profile.cp		= profile.clear .. " / " .. profile.play
		profile.min		= (profile.hh * 60) + profile.mm
		
		profile.pf_pm	= math.floor(profile.pf / profile.min)
		profile.gr_pm	= math.floor(profile.gr / profile.min)
		profile.gd_pm	= math.floor(profile.gd / profile.min)
		profile.bd_pm	= math.floor(profile.bd / profile.min)
		profile.pr_pm	= math.floor(profile.pr / profile.min)
		profile.note_pm	= math.floor(profile.note / profile.min)
		
		profile.tgt1	= 1600000 / 200000000
		profile.tgt2	= 10000000 / 200000000
		profile.tgt3	= 100000000 / 200000000
		profile.tgt4	= 190000000 / 200000000
		profile.graph	= (profile.pf + profile.gr) / 200000000
		if profile.graph > 1 then profile.graph = 1 end
		
		-- メニューの開閉とSE再生
		local function toggle()
			flg = not flg
			--sound.init()
			if flg then
				main_state.set_timer(timer.on, main_state.time())
				main_state.set_timer(timer.off, main_state.timer_off_value)
				main_state.audio_play(sound.effect.open, main_state.volume_sys())
				--sound.play(sound.effect.open, main_state.volume_sys())
				--sound.dispose(sound.effect.open)
			else
				main_state.set_timer(timer.off, main_state.time())
				main_state.set_timer(timer.on, main_state.timer_off_value)
				main_state.audio_play(sound.effect.close, main_state.volume_sys())
				--sound.play(sound.effect.close, main_state.volume_sys())
				--sound.dispose(sound.effect.close)
			end
		end
		
		-- 当日リザルトここから
		local play_data_path		= ADVANCED_PATH .. "/default_playerrank2/data"
		local play_songs_path		= ADVANCED_PATH .. "/default_playerrank2/songs"
		local today_num_font_path	= "customize/advanced/default_playerrank2/num.fnt"
		local today_rank_font_path	= "customize/advanced/default_playerrank2/npc_rank.fnt"
		local play_data			= {}
		local today_result		= {}
		local now_date			= main_state.number(21) .. main_state.number(22) .. main_state.number(23)
		local play_songs		= {}
		
		-- TODO: ファイルが存在しない時
		-- local function file_exists() end
		
		--[[ ファイルの内容を取得
			当日初回起動時
			play_data.date:		playdate
			play_data.play:		totalplay
			play_data.clear:	totalclear
			play_data.pg:		totalperfect
			play_data.gr:		totalgreat
			play_data.gd:		totalgood
			play_data.bd:		totalbad
			play_data.pr:		totalpoor
			play_data.notes:	totalnotes
		--]]
		do
			local tmp = {}
			for l in io.lines(play_data_path) do tmp[#tmp + 1] = l end
			play_data.date	= tmp[1]
			play_data.play	= tmp[2]
			play_data.clear	= tmp[3]
			play_data.pg	= tmp[4]
			play_data.gr	= tmp[5]
			play_data.gd	= tmp[6]
			play_data.bd	= tmp[7]
			play_data.pr	= tmp[8]
			play_data.notes	= tmp[9]
		end
		
		-- スキン更新時
		if play_data.date	== 0 then play_data.date	= main_state.number(21) .. main_state.number(22) .. main_state.number(23) end
		if play_data.play	== 0 then play_data.play	= main_state.number(30) end
		if play_data.clear	== 0 then play_data.clear	= main_state.number(31) end
		if play_data.pg		== 0 then play_data.pg		= main_state.number(33) end
		if play_data.gr		== 0 then play_data.gr		= main_state.number(34) end
		if play_data.gd		== 0 then play_data.gd		= main_state.number(35) end
		if play_data.bd		== 0 then play_data.bd		= main_state.number(36) end
		if play_data.pr		== 0 then play_data.pr		= main_state.number(37) end
		if play_data.notes	== 0 then play_data.notes	= main_state.number(333) end
		
		-- 現在の日付と一致しない時
		if skin_config.option["日付変更時に今日の成果をリセットする"] == OP_RESULT_RESET_ON and now_date ~= play_data.date then
			-- ファイルに現在の状態を書込
			local file = io.open(play_data_path, "w")
			play_data.date	= main_state.number(21) .. main_state.number(22) .. main_state.number(23)
			play_data.play	= main_state.number(30)
			play_data.clear	= main_state.number(31)
			play_data.pg	= main_state.number(33)
			play_data.gr	= main_state.number(34)
			play_data.gd	= main_state.number(35)
			play_data.bd	= main_state.number(36)
			play_data.pr	= main_state.number(37)
			play_data.notes	= main_state.number(333)
			file:write(
				play_data.date	.. "\n" ..
				play_data.play	.. "\n" ..
				play_data.clear	.. "\n" ..
				play_data.pg	.. "\n" ..
				play_data.gr	.. "\n" ..
				play_data.gd	.. "\n" ..
				play_data.bd	.. "\n" ..
				play_data.pr	.. "\n" ..
				play_data.notes
			)
			file:close()
		end
		
		-- リザルトの計算
		today_result.play		= main_state.number(30) - play_data.play
		today_result.clear		= main_state.number(31) - play_data.clear
		today_result.pg			= main_state.number(33) - play_data.pg
		today_result.gr			= main_state.number(34) - play_data.gr
		today_result.gd			= main_state.number(35) - play_data.gd
		today_result.bd			= main_state.number(36) - play_data.bd
		today_result.pr			= main_state.number(37) - play_data.pr
		today_result.notes		= main_state.number(333) - play_data.notes
		today_result.pg_p		= math.floor(today_result.pg / today_result.notes * 10000 + 0.5) / 100
		today_result.gr_p		= math.floor(today_result.gr / today_result.notes * 10000 + 0.5) / 100
		today_result.gd_p		= math.floor(today_result.gd / today_result.notes * 10000 + 0.5) / 100
		today_result.bd_p		= math.floor(today_result.bd / today_result.notes * 10000 + 0.5) / 100
		today_result.pr_p		= math.floor(today_result.pr / today_result.notes * 10000 + 0.5) / 100
		today_result.maxscore	= today_result.notes * 2
		today_result.exscore	= (today_result.pg * 2) + today_result.gr
		today_result.rate		= math.floor(today_result.exscore / today_result.maxscore * 10000 + 0.5) / 100
		today_result.accuracy	= (today_result.exscore / today_result.maxscore) * 100
		
		-- NaN対策
		if today_result.pg_p ~= today_result.pg_p then today_result.pg_p = 0 end
		if today_result.gr_p ~= today_result.gr_p then today_result.gr_p = 0 end
		if today_result.gd_p ~= today_result.gd_p then today_result.gd_p = 0 end
		if today_result.bd_p ~= today_result.bd_p then today_result.bd_p = 0 end
		if today_result.pr_p ~= today_result.pr_p then today_result.pr_p = 0 end
		if today_result.rate ~= today_result.rate then today_result.rate = 0 end
		if today_result.accuracy ~= today_result.accuracy then today_result.accuracy = 0 end
		
		-- ランク計算
		if		today_result.accuracy < ((100 / 9) * 2)	then today_result.rank = "F"
		elseif	today_result.accuracy < ((100 / 9) * 3)	then today_result.rank = "E"
		elseif	today_result.accuracy < ((100 / 9) * 4)	then today_result.rank = "D"
		elseif	today_result.accuracy < ((100 / 9) * 5)	then today_result.rank = "C"
		elseif	today_result.accuracy < ((100 / 9) * 6)	then today_result.rank = "B"
		elseif	today_result.accuracy < ((100 / 9) * 7)	then today_result.rank = "A"
		elseif	today_result.accuracy < ((100 / 9) * 8)	then today_result.rank = "AA"
		elseif	today_result.accuracy <= 100			then today_result.rank = "AAA"
		end
		
		-- プレイ楽曲ログ
		for l in io.lines(play_songs_path) do play_songs[#play_songs + 1] = l end
		-- 2024/05/08廃止: 日付更新時
		--[[
		if play_songs[1] ~= now_date then
			for i = 1, #play_songs do play_songs[i] = "" end
			play_songs[1] = now_date
			play_songs[2] = profile.note
			local file = io.open(play_songs_path, "w")
			file:write(play_songs[1] .. "\n" .. play_songs[2])
			file:close()
		end
		--]]
		-- スキン更新時
		if tonumber(play_songs[1]) == 0 then
			play_songs[1] = now_date
			play_songs[2] = profile.note
			local file = io.open(play_songs_path, "w")
			file:write(play_songs[1] .. "\n" .. play_songs[2] .. "\n")
			file:close()
		end
		-- プレイ判定時
		if tonumber(play_songs[2]) < profile.note then
			local now_song = main_state.text(12)
			play_songs[1] = now_date
			play_songs[2] = profile.note
			-- 連続プレイ時に記録しない
			if play_songs[3] ~= now_song then
				table.insert(play_songs, 3, now_song)
			end
			local file = io.open(play_songs_path, "w")
			file:write(play_songs[1] .. "\n" .. play_songs[2] .. "\n")
			for i = 1, 10 do
				if play_songs[2 + i] then
					file:write(play_songs[2 + i] .. "\n")
				end
			end
			file:close()
		end
		-- 表示テキスト生成
		today_result.songs = {}
		for i = 1, 10 do
			if play_songs[i + 2] then
				today_result.songs[i] = play_songs[i + 2]
			end
		end
		
		-- 2024/05/08追加: リセットボタン押下時の処理
		-- TODO: 処理が上とダブってるのでどっかにメソッド作る
		local function button_reset()
			-- SE再生
			main_state.audio_play(sound.effect.open, main_state.volume_sys())
			-- ファイルに現在の状態を書込
			local file = io.open(play_data_path, "w")
			play_data.date	= main_state.number(21) .. main_state.number(22) .. main_state.number(23)
			play_data.play	= main_state.number(30)
			play_data.clear	= main_state.number(31)
			play_data.pg	= main_state.number(33)
			play_data.gr	= main_state.number(34)
			play_data.gd	= main_state.number(35)
			play_data.bd	= main_state.number(36)
			play_data.pr	= main_state.number(37)
			play_data.notes	= main_state.number(333)
			file:write(
				play_data.date	.. "\n" ..
				play_data.play	.. "\n" ..
				play_data.clear	.. "\n" ..
				play_data.pg	.. "\n" ..
				play_data.gr	.. "\n" ..
				play_data.gd	.. "\n" ..
				play_data.bd	.. "\n" ..
				play_data.pr	.. "\n" ..
				play_data.notes
			)
			file:close()
			-- 再計算
			today_result.play		= main_state.number(30) - play_data.play
			today_result.clear		= main_state.number(31) - play_data.clear
			today_result.pg			= main_state.number(33) - play_data.pg
			today_result.gr			= main_state.number(34) - play_data.gr
			today_result.gd			= main_state.number(35) - play_data.gd
			today_result.bd			= main_state.number(36) - play_data.bd
			today_result.pr			= main_state.number(37) - play_data.pr
			today_result.notes		= main_state.number(333) - play_data.notes
			today_result.pg_p		= math.floor(today_result.pg / today_result.notes * 10000 + 0.5) / 100
			today_result.gr_p		= math.floor(today_result.gr / today_result.notes * 10000 + 0.5) / 100
			today_result.gd_p		= math.floor(today_result.gd / today_result.notes * 10000 + 0.5) / 100
			today_result.bd_p		= math.floor(today_result.bd / today_result.notes * 10000 + 0.5) / 100
			today_result.pr_p		= math.floor(today_result.pr / today_result.notes * 10000 + 0.5) / 100
			today_result.maxscore	= today_result.notes * 2
			today_result.exscore	= (today_result.pg * 2) + today_result.gr
			today_result.rate		= math.floor(today_result.exscore / today_result.maxscore * 10000 + 0.5) / 100
			today_result.accuracy	= (today_result.exscore / today_result.maxscore) * 100
			if today_result.pg_p ~= today_result.pg_p then today_result.pg_p = 0 end
			if today_result.gr_p ~= today_result.gr_p then today_result.gr_p = 0 end
			if today_result.gd_p ~= today_result.gd_p then today_result.gd_p = 0 end
			if today_result.bd_p ~= today_result.bd_p then today_result.bd_p = 0 end
			if today_result.pr_p ~= today_result.pr_p then today_result.pr_p = 0 end
			if today_result.rate ~= today_result.rate then today_result.rate = 0 end
			if today_result.accuracy ~= today_result.accuracy then today_result.accuracy = 0 end
			if		today_result.accuracy < ((100 / 9) * 2)	then today_result.rank = "F"
			elseif	today_result.accuracy < ((100 / 9) * 3)	then today_result.rank = "E"
			elseif	today_result.accuracy < ((100 / 9) * 4)	then today_result.rank = "D"
			elseif	today_result.accuracy < ((100 / 9) * 5)	then today_result.rank = "C"
			elseif	today_result.accuracy < ((100 / 9) * 6)	then today_result.rank = "B"
			elseif	today_result.accuracy < ((100 / 9) * 7)	then today_result.rank = "A"
			elseif	today_result.accuracy < ((100 / 9) * 8)	then today_result.rank = "AA"
			elseif	today_result.accuracy <= 100			then today_result.rank = "AAA"
			end
		end
		
		-- 当日リザルトここまで
		-- プロフィール関連ここまで
		
		-- 表示
		parts.source = {
			{id = "src-default_playerrank2_parts", path = "customize/advanced/default_playerrank2/parts.png"},
			{id = "src-default_playerrank2_profile_image", path = "customize/profile/*"},
			{id = "src-default_playerrank2_profile_ui", path = "customize/advanced/default_playerrank2/ui.png"},
			{id = "src-default_playerrank2_profile_msg", path = "customize/advanced/default_playerrank2/msg.png"},
			{id = "src-default_playerrank2_button_reset", path = "customize/advanced/default_playerrank2/button_reset.png"}
		}
		
		parts.image = {
			{id = "default_playerrank2_panel",	src = "src-default_playerrank2_parts", x = 0, y = 0, w = 280, h = 50},
			{id = "default_playerrank2_graph",	src = "src-default_playerrank2_parts", x = 0, y = 50, w = 180, h = 11},
			{id = "default_playerrank2_rect",	src = "src-default_playerrank2_parts", x = 0, y = 89, w = 280, h = 50},
			{id = "default_playerrank2_button",	src = "src-default-commonparts-system", x = 0, y = 0, w = 1, h = 1, act = (function() return toggle() end)},
			{id = "default_playerrank2_button_reset",		src = "src-default_playerrank2_button_reset", x = 0, y = 0, w = 100, h = 25, act = (function() return button_reset() end)},
			{id = "default_playerrank2_button_reset_rect",	src = "src-default_playerrank2_button_reset", x = 0, y = 25, w = 100, h = 25},
			{id = "default_playerrank2_image",	src = "src-default_playerrank2_profile_image", x = 0, y = 0, w = -1, h = -1},
			{id = "default_playerrank2_ui",		src = "src-default_playerrank2_profile_ui", x = 0, y = 0, w = -1, h = -1},
			{id = "default_playerrank2_msg1",	src = "src-default_playerrank2_profile_msg", x = 0, y = 0, w = 512, h = 20},
			{id = "default_playerrank2_msg2",	src = "src-default_playerrank2_profile_msg", x = 0, y = 20, w = 512, h = 20},
			{id = "default_playerrank2_msg3",	src = "src-default_playerrank2_profile_msg", x = 0, y = 40, w = 512, h = 20},
			{id = "default_playerrank2_msg4",	src = "src-default_playerrank2_profile_msg", x = 0, y = 60, w = 512, h = 20},
			{id = "default_playerrank2_msg5",	src = "src-default_playerrank2_profile_msg", x = 0, y = 80, w = 512, h = 20}
		}
		
		parts.value = {
			{id = "default_playerrank2_player_rank_count",			src = "src-default_playerrank2_parts", x = 0, y = 61, w = 140, h = 19, divx = 10, align = 2, digit = 3, value = function() return current_rank end},
			{id = "default_playerrank2_player_next_exp_count",		src = "src-default_playerrank2_parts", x = 0, y = 80, w = 90, h = 9, divx = 10, digit = 10, value = function() return next_exp end},
			{id = "default_playerrank2_player_current_exp_count",	src = "src-default_playerrank2_parts", x = 0, y = 80, w = 90, h = 9, divx = 10, align = 1, digit = 10, value = function() return current_exp end},
			{id = "default_playerrank2_player_total_exp_count",		src = "src-default_playerrank2_parts", x = 0, y = 80, w = 90, h = 9, divx = 10, digit = 10, value = function() return total_exp end},	
		}
		
		parts.font = {
			{id = "defaultNotesProcessingCounter_font_num", path = today_num_font_path},
			{id = "defaultNotesProcessingCounter_font_rank", path = today_rank_font_path}
		}
		
		parts.text = {
			{id = "default_playerrank2_player_name",				font = font1_id, size = 14, overflow = 1, ref = 2},
			{id = "default_playerrank2_profile_player_rank",		font = font2_id, size = 32, align = 1, constantText = current_rank},
			{id = "default_playerrank2_profile_player_name",		font = font2_id, size = 32, ref = 2},
			{id = "default_playerrank2_profile_play_time",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.time},
			{id = "default_playerrank2_profile_play_cp",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.cp},
			{id = "default_playerrank2_profile_play_pf",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.pf .. "  (" .. profile.pf_pm .. ")"},
			{id = "default_playerrank2_profile_play_gr",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.gr .. "  (" .. profile.gr_pm .. ")"},
			{id = "default_playerrank2_profile_play_gd",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.gd .. "  (" .. profile.gd_pm .. ")"},
			{id = "default_playerrank2_profile_play_bd",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.bd .. "  (" .. profile.bd_pm .. ")"},
			{id = "default_playerrank2_profile_play_pr",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.pr .. "  (" .. profile.pr_pm .. ")"},
			{id = "default_playerrank2_profile_play_note",			font = "defaultNotesProcessingCounter_font_num", size = 24, constantText = profile.note .. "  (" .. profile.note_pm .. ")"},
			
			--[[
			{id = "defaultNotesProcessingCounter_exscore",	font = font2_id, size = 22, align = 0, constantText = today_result.exscore},
			{id = "defaultNotesProcessingCounter_pg",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.pg .. "  (" .. today_result.pg_p .. "%)"},
			{id = "defaultNotesProcessingCounter_gr",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.gr .. "  (" .. today_result.gr_p .. "%)"},
			{id = "defaultNotesProcessingCounter_gd",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.gd .. "  (" .. today_result.gd_p .. "%)"},
			{id = "defaultNotesProcessingCounter_bd",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.bd .. "  (" .. today_result.bd_p .. "%)"},
			{id = "defaultNotesProcessingCounter_pr",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.pr .. "  (" .. today_result.pr_p .. "%)"},
			{id = "defaultNotesProcessingCounter_notes",	font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, constantText = today_result.notes},
			
			{id = "defaultNotesProcessingCounter_stroke",	font = "font-default-commonparts-m_select1", size = 13, align = 1, constantText = today_result.notes},
			{id = "defaultNotesProcessingCounter_cp",		font = "font-default-commonparts-m_select1", size = 13, align = 1, constantText = today_result.clear .. "/" .. today_result.play},
			{id = "defaultNotesProcessingCounter_rank",		font = "defaultNotesProcessingCounter_font_rank", size = 31, align = 1, constantText = today_result.rank},
			{id = "defaultNotesProcessingCounter_rate",		font = "font-default-commonparts-m_select1", size = 13, align = 1, constantText = today_result.rate},
			--]]
			
			-- 2024/05/08 確認済: 旧verだと異常にFPSが低下していたので要確認 重くなかったらこれで良い
			{id = "defaultNotesProcessingCounter_exscore",	font = font2_id, size = 22, align = 0, value = function() return today_result.exscore end},
			{id = "defaultNotesProcessingCounter_pg",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.pg .. "  (" .. today_result.pg_p .. "%)" end},
			{id = "defaultNotesProcessingCounter_gr",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.gr .. "  (" .. today_result.gr_p .. "%)" end},
			{id = "defaultNotesProcessingCounter_gd",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.gd .. "  (" .. today_result.gd_p .. "%)" end},
			{id = "defaultNotesProcessingCounter_bd",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.bd .. "  (" .. today_result.bd_p .. "%)" end},
			{id = "defaultNotesProcessingCounter_pr",		font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.pr .. "  (" .. today_result.pr_p .. "%)" end},
			{id = "defaultNotesProcessingCounter_notes",	font = "defaultNotesProcessingCounter_font_num", size = 24, align = 0, value = function() return today_result.notes end},
			
			{id = "defaultNotesProcessingCounter_stroke",	font = "font-default-commonparts-m_select1", size = 13, align = 1, value = function() return today_result.notes end},
			{id = "defaultNotesProcessingCounter_cp",		font = "font-default-commonparts-m_select1", size = 13, align = 1, value = function() return today_result.clear .. "/" .. today_result.play end},
			{id = "defaultNotesProcessingCounter_rank",		font = "defaultNotesProcessingCounter_font_rank", size = 31, align = 1, value = function() return today_result.rank end},
			{id = "defaultNotesProcessingCounter_rate",		font = "font-default-commonparts-m_select1", size = 13, align = 1, value = function() return today_result.rate end},
			
			{id = "default_playSongLogger_song1",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[1]},
			{id = "default_playSongLogger_song2",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[2]},
			{id = "default_playSongLogger_song3",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[3]},
			{id = "default_playSongLogger_song4",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[4]},
			{id = "default_playSongLogger_song5",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[5]},
			{id = "default_playSongLogger_song6",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[6]},
			{id = "default_playSongLogger_song7",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[7]},
			{id = "default_playSongLogger_song8",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[8]},
			{id = "default_playSongLogger_song9",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[9]},
			{id = "default_playSongLogger_song10",	font = "font-default-commonparts-m_select3", size = 24, align = 2, overflow = 1, constantText = today_result.songs[10]}
		}
		
		parts.graph = {
			{id = "default_playerrank2_profile_graph", src = "src-default-commonparts-system", x = 824, y = 325, w = 1, h = 8, angle = 0, value = function() return profile.graph end}
		}
		
		local player_rank_x = 40
		local player_rank_y = 990
		local graph_width = 180 * next_exp_per

		parts.destination = {
			{id = "default_playerrank2_panel",						dst = {{x = player_rank_x,			y = player_rank_y,		w = 280, h = 50}}},
			{id = "default_playerrank2_player_name",				dst = {{x = player_rank_x + 64,		y = player_rank_y + 29,	w = 119, h = 14}}},
			{id = "default_playerrank2_graph",						dst = {{x = player_rank_x + 94,		y = player_rank_y + 6,	w = graph_width, h = 11}}},
			{id = "default_playerrank2_player_rank_count",			dst = {{x = player_rank_x + 8,		y = player_rank_y + 7,	w = 14, h = 19}}},
			{id = "default_playerrank2_player_next_exp_count",		dst = {{x = player_rank_x + 183,	y = player_rank_y + 7,	w = 9, h = 9, a = 192}}},
			{id = "default_playerrank2_player_current_exp_count",	dst = {{x = player_rank_x + 95,		y = player_rank_y + 7,	w = 9, h = 9, a = 192}}},
			{id = "default_playerrank2_player_total_exp_count",		dst = {{x = player_rank_x + 183,	y = player_rank_y + 29,	w = 9, h = 9, a = 80}}},
			{id = "default_playerrank2_rect",						dst = {{x = player_rank_x,			y = player_rank_y,		w = 280, h = 50}}, mouseRect = {x = 0, y = 0, w = 280, h = 50}},
			
			{id = "default_playerrank2_button", dst = {{x = player_rank_x, y = player_rank_y, w = 280, h = 50}}},
			{id = "default_playerrank2_button", draw = function() return flg end, dst = {{x = 0, y = 0, w = 1920, h = 1080}}},
			{id = -111, loop = 300, timer = timer.on,	dst = {{time = 0, x = 319, y = 179, w = 1282, h = 722, a = 0}, {time = 250}, {time = 300, a = 168}}},
			{id = "default_playerrank2_image", filter = 1, stretch = 2, loop = 300, timer = timer.on,	dst = {{time = 0, x = -1280, y = 180, w = 1280, h = 720, acc = 2}, {time = 300, x = 320}}},
			{id = "default_playerrank2_image", filter = 1, stretch = 2, loop = 300, timer = timer.off,	dst = {{time = 0, x = 320, y = 180, w = 1280, h = 720, acc = 2}, {time = 300, x = -1280}}},
			{id = "default_playerrank2_ui", loop = 400, timer = timer.on, dst = {{time = 0, x = 320, y = 180, w = 1280, h = 720, acc = 2, a = 0}, {time = 300}, {time = 400, a = 255}}},
			
			{id = "default_playerrank2_profile_player_rank",		loop = 400, timer = timer.on, dst = {{time = 0, x = 391, y = 754, w = 32, h = 32, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_player_name",		loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 754, w = 32, h = 32, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_time",			loop = 400, timer = timer.on, dst = {{time = 0, x = 500, y = 683, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_cp",			loop = 400, timer = timer.on, dst = {{time = 0, x = 500, y = 612, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_pf",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 459, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_gr",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 423, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_gd",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 387, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_bd",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 351, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_pr",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 315, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_play_note",			loop = 400, timer = timer.on, dst = {{time = 0, x = 450, y = 279, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playerrank2_profile_graph",				loop = 400, timer = timer.on, dst = {{time = 0, x = 320, y = 195, w = 1280, h = 8, a = 0}, {time = 200}, {time = 400, a = 255}}},
			
			{id = "defaultNotesProcessingCounter_pg",		loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 459, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "defaultNotesProcessingCounter_gr",		loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 423, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "defaultNotesProcessingCounter_gd",		loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 387, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "defaultNotesProcessingCounter_bd",		loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 351, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "defaultNotesProcessingCounter_pr",		loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 315, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "defaultNotesProcessingCounter_notes",	loop = 400, timer = timer.on, dst = {{time = 0, x = 720, y = 279, w = 24, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			
			{id = "default_playerrank2_button_reset",		dst = {{x = 6, y = 0 + 60, w = 100, h = 25}}},
			{id = "default_playerrank2_button_reset_rect",	dst = {{x = 6, y = 0 + 60, w = 100, h = 25}}, mouseRect = {x = 0, y = 0, w = 100, h = 25}},
			
			{id = "defaultNotesProcessingCounter_stroke",	dst = {{time = 0, x = 56, y = 64 + 60 + 30, w = 13, h = 13}}},
			{id = "defaultNotesProcessingCounter_cp",		dst = {{time = 0, x = 56, y = 50 + 60 + 30, w = 13, h = 13}}},
			{id = "defaultNotesProcessingCounter_rank",		dst = {{time = 0, x = 56, y = 14 + 60 + 30, w = 28, h = 31}}},
			{id = "defaultNotesProcessingCounter_rate",		dst = {{time = 0, x = 56, y = 0 + 60 + 30, w = 13, h = 13}}},
			
			{id = "default_playSongLogger_song1",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song2",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 1, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song3",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 2, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song4",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 3, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song5",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 4, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song6",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 5, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song7",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 6, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song8",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 7, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song9",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 8, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}},
			{id = "default_playSongLogger_song10",	loop = 400, timer = timer.on, dst = {{time = 0, x = 960 + 640 - 40, y = 532 - 32 * 9, w = 500, h = 24, a = 0}, {time = 200}, {time = 400, a = 255}}}
		}
		if profile.graph < profile.tgt1 then
			table.insert(parts.destination, {id = "default_playerrank2_msg1", loop = 400, timer = timer.on, dst = {{time = 0, x = 360, y = 730, w = 512, h = 20, a = 0}, {time = 200}, {time = 400, a = 255}}})
		elseif profile.graph < profile.tgt2 then
			table.insert(parts.destination, {id = "default_playerrank2_msg2", loop = 400, timer = timer.on, dst = {{time = 0, x = 360, y = 730, w = 512, h = 20, a = 0}, {time = 200}, {time = 400, a = 255}}})
		elseif profile.graph < profile.tgt3 then
			table.insert(parts.destination, {id = "default_playerrank2_msg3", loop = 400, timer = timer.on, dst = {{time = 0, x = 360, y = 730, w = 512, h = 20, a = 0}, {time = 200}, {time = 400, a = 255}}})
		elseif profile.graph < profile.tgt4 then
			table.insert(parts.destination, {id = "default_playerrank2_msg4", loop = 400, timer = timer.on, dst = {{time = 0, x = 360, y = 730, w = 512, h = 20, a = 0}, {time = 200}, {time = 400, a = 255}}})
		elseif profile.graph >= profile.tgt4 then
			table.insert(parts.destination, {id = "default_playerrank2_msg5", loop = 400, timer = timer.on, dst = {{time = 0, x = 360, y = 730, w = 512, h = 20, a = 0}, {time = 200}, {time = 400, a = 255}}})
		end
		
		parts.customTimers = {
			{id = timer.on},
			{id = timer.off}
		}
		
	end
	
	return parts	
end

return {
	parts = parts,
	load = load
}