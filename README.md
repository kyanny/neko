# つかいかた
* CSV の欄に CSV ファイルの中身をコピーして貼り付けてフォーム送信する
* HTML の欄に CSV データを変換した HTML が表示される
* open other window のリンクをクリックすると新しいウィンドウでひらくのでファイルを保存する

# CSV の書式
* 一行目は必ず項目名を書いてください ("category_id", "song_id" など)
* 二行目以降に、項目名に対応したデータを書いてください ("ライオンハート", "SMAP" など)
* 新しい項目とデータを追加する場合は最後の列に追加してください
* 列を入れ替えてもたぶん動きます

# テンプレートの書式
* neko.tmpl がテンプレートファイルです
* このファイルを雛形として CSV のデータを埋め込みます
* Template-Toolkit (TT2) を使っています
* [% FOR melo = melos %] ... [% END %] の間にデータが埋め込まれます
* [% melo.caption | html %] のように、 [% melo.項目名 | html %] としてください
* CSV に新しい項目を追加したときは、 [% melo.new_field | html %] のようにしてください