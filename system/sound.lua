-- TODO: そもそもjavaがわからんから何もできん
-- hoge = luajava.bindClass("class") たぶんusing的なやつ
--  hoge:なんちゃらメソッド() みたいな感じで使えてるように見える
-- hoge = luajava.newInstance("class", 初期値) たぶん Nanchara hoge = new Nanchara(); みたいなやつ
-- hoge = luajava.createProxy() なにこれ

-- 0.8.7でmain_stateに音鳴らすやつが追加されたので今後使用しない
local luajava = require("luajava")
local gdx = luajava.bindClass("com.badlogic.gdx.Gdx")
local audio = nil

local sound = {
	effect = {
		open = skin_config.get_path("system/sounds/open.wav"),
		close = skin_config.get_path("system/sounds/close.wav")
	},

	init = function()
		pcall(function() audio = gdx.app:getApplicationListener():getAudioProcessor() end)
	end,

    play = function(path, vol)
		pcall(function() audio:play(path, vol) end)
	end,

	dispose = function(path)
		pcall(function() audio:dispose(path) end)
	end
}

return sound