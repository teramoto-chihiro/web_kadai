require 'webrick'
#gem install webrickでインストールされたライブラリ「webrick」を呼び出しています。こうすることで、このRubyファイル内でWebrickが使えるようになります
server = WEBrick::HTTPServer.new({
  #Webrickのインスタンスを作成し、serverという名前のローカル変数に入れます。
  :DocumentRoot => '.',
  #このWebアプリケーションのドメインの設定（ここに書き込まれた記述が、作成するWebアプリケーションのドメインになる）
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  #このプログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定する記述。
  :Port => '3000',
  #このWebアプリケーションの情報の出入り口を表す設定。
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'web_kadai.html.erb')
#Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示する
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/give_for.cgi', WEBrick::HTTPServlet::CGIHandler, 'give_for.rb')
server.mount('/quality.cgi', WEBrick::HTTPServlet::CGIHandler, 'quality.rb')
server.start
#Webrickのサーバを起動させる
