# game.rb
require 'gosu'
require_relative 'niku'
require_relative 'sara'

RANKING_FILE = 'ranking.dat'
MAX_RANKING_ENTRIES = 5 # 表示するランキングの最大数

# ゲームのメインウィンドウ
class GameWindow < Gosu::Window #Gosuのウィンドウを作成
  def initialize
    super(640, 480) #サイズを幅640ピクセル、高さ480ピクセルに設定
    self.caption = "ボール避けゲーム" #ウィンドウのタイトルバーに表示されるテキスト
    @player = Player.new(self)    #プレイヤーオブジェクトを作成
    @balls = []  #ボールオブジェクトを格納するための空の配列を初期化
    @last_ball_spawn = Gosu.milliseconds #最後にボールが生成された時刻（ミリ秒単位）を記録(、一定間隔でボールを生成するために使用)
    @font = Gosu::Font.new(20)  #フォントオブジェクトを作成し、()内でサイズを設定
    @score = 0 #プレイヤーのスコアを0で初期化
    @game_over = false #ゲームオーバー状態かどうかを示すフラグを false (ゲームは進行中) で初期化
  end

  def update
    return if @game_over #@game_over が true なら、def updateは行わずにメソッドを終了

    @player.update #プレイヤーの状態（位置など）を更新
    @balls.each do |ball| #全てのボールオブジェクトに対して
      ball.update         #ボールの状態（落下など）を更新
    end

    # 新しいボールを生成
    if Gosu.milliseconds - @last_ball_spawn > 500 #現在時刻から最後にボールが生成された時刻を引いて、その差が500ミリ秒（0.5秒）より大きい場合
      @balls << Ball.new(self)                    #新しいBallオブジェクトを作成し、@balls配列に追加
      @last_ball_spawn = Gosu.milliseconds   # 新しいボールが生成された時刻を記録し直す
    end

    # 画面外に出たボールを削除       @balls配列から、ボールのY座標がウィンドウの高さを超えた（画面外に出た）ものを削除
    @balls.reject! { |ball| ball.y > self.height + ball.radius }  
    #reject!=条件に合致する要素を配列から削除し、残った要素で配列を更新する

    # 当たり判定
    @balls.each do |ball| #すべてのボールを対象
      distance = Gosu.distance(@player.x, @player.y, ball.x, ball.y) #プレイヤーの中心座標とボールの中心座標との間の距離を計算
      if distance < @player.radius + ball.radius #計算された距離が、プレイヤーの半径とボールの半径の合計よりも小さい場合
        @game_over = true #ゲームオーバーフラグを true に設定
      end
    end

    @score += 1 unless @game_over #ゲームオーバーフラグを true に設定
  end

  def draw
    @player.draw 
    @balls.each do |ball| #すべてのボールを対象
      ball.draw  #それぞれの draw メソッドを呼び出し、ボールを描画
    end
    @font.draw_text("スコア: #{@score}", 10, 10, 1)

    if @game_over
      game_over_text = "ゲームオーバー！ スコア: #{@score}" #ゲームオーバーメッセージを作成
      text_width = @font.text_width(game_over_text) #メッセージの幅を計算
      @font.draw_text(game_over_text, (self.width - text_width) / 2, self.height / 2, 1) #メッセージを画面の中央に表示
      @font.draw_text("Rキーでリスタート", (self.width - @font.text_width("Rキーでリスタート")) / 2, self.height / 2 + 30, 1) # リスタート方法を示すメッセージも中央に表示
    end
  end

  def button_down(id) #button_down=キーボードやマウスなどの入力があったときに呼び出されるメソッド
    if @game_over && id == Gosu::KB_R #@game_over が true で、かつ押されたキーが 'R'キー (Gosu::KB_R) 
      initialize #initialize メソッドを再度呼び出す(ゲームの状態をリセットし、ゲームを最初からやり直し)
    end
  end


  private

  # スコアをファイルから読み込む
  def load_scores
    scores = []
    if File.exist?('scores.txt')
      File.open('scores.txt', 'r') do |file|
        file.each_line do |line|
          scores << line.chomp.to_i # 各行を整数に変換して追加
        end
      end
    end
    scores.sort { |a, b| b <=> a } # スコアを降順にソート
    scores.take(10) # 上位10件のみ取得
  end

  # スコアをファイルに保存する
  def save_score(score)
    @scores << score # 現在のスコアを追加
    @scores.sort! { |a, b| b <=> a } # スコアを降順にソート
    @scores = @scores.take(5) # 上位5件のみ保持

    File.open('scores.txt', 'w') do |file|
      @scores.each do |s|
        file.puts s # 各スコアを改行して書き込む
      end
    end
  end

  # ランキングを描画する
  def draw_ranking
    ranking_text = "--- スコアランキング ---"
    text_width = @font.text_width(ranking_text)
    @font.draw_text(ranking_text, (self.width - text_width) / 2, self.height / 2 + 70, 1)
    @scores.each_with_index do |score, index|
      rank_text = "#{index + 1}. #{score}"
      text_width = @font.text_width(rank_text)
      @font.draw_text(rank_text, (self.width - text_width) / 2, self.height / 2 + 90 + index * 20, 1)
    end
  end
end

# ゲーム開始
GameWindow.new.show