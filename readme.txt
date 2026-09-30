mnpy氏により作成された m-select をベースに、bmz-player 向けの拡張を加えたスキンです。

antiqueのBMZ拡張:
・「Ambient」: 既定OFF。ONでBGA/汎用背景をぼかして画面の背面に表示します。
・「Ambient表示方式」: 全体（既定）／Spread。
・「Spread範囲 (%)」: 0～200%、10%刻み、既定20%。実際の映像範囲の幅・高さを拡大します。
  20%なら幅・高さが1.2倍。映像外周はぼかして透明へ減衰します。
・「Ambientぼかし度 (%)」: 0～100%、10%刻み、既定50%。0%ではぼかしません。
・「Ambientパネル透明度」: ON時のパネル透明度を0～100%の10%刻みで設定できます（既定40%）。
  レーン背景は対象外で、不透明度100%を維持します。
  数値・テキスト・ノーツ・判定・グラフ本体の透明度は変わりません。
  フレーム画像に含まれる装飾やラベルはフレームと一緒に透過します。
・ON時は従来の暗いBGA背景を省き、鮮明なBGAとAmbientを表示します。
  BGAサイズが「背景(1920x1080)」の場合は選択した全体／SpreadのAmbientだけを表示します。
この演出にはambient / ambientMode / ambientSpread / ambientBlurに対応したBMZ Playerが必要です。

--- 以下、readme.txt 原文 ---

ダウンロードありがとうございます
このファイルはbeatoraja用のフルHD(1920x1080)選曲スキンです

使用する際は展開して出てきたm-selectフォルダを下記のように配置してください
skin/m-select/customize/..
             /font/..

スキンそのものやスキンに含まれる画像等は自由に利用、改変、再配布して頂いて構いません
フォントの扱いについてはフォントに同梱しているライセンスを参照してください
[VOICEVOX:春日部つむぎ]を使用した音声の規約については下記のURLを参照してください
VOICEVOX
https://voicevox.hiroshiba.jp
春日部つむぎ
https://tsumugi-official.studio.site/rule

2026/05/28 mnpy
