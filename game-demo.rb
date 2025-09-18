# game.rb
require 'gosu'
require_relative 'niku'
require_relative 'sara'

# ゲームのメインウィンドウ 
class GameWindow < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "焼き肉キャッチゲーム"

    # 背景画像をロード
    @background_image = Gosu::Image.new("media/yakinikuya.png", retro: false)

    #BGMをロード
    @bgm = Gosu::Song.new("media/VSQSE_1044_grilling_meat_01.mp3")
    @bgm.volume = 1   # 音量調整（70%）
    @bgm.play(true)

    @special_se = Gosu::Sample.new("きらりん２２.mp3")   # シャトーブリアン専用

    @sara = Sara.new(self)
    @nikus = []
    @last_niku_spawn = Gosu.milliseconds
    @font = Gosu::Font.new(20)
    @score = 0
    @game_over = false
    @scores = load_scores # スコアを読み込む

    # 制限時間 (30秒)
    @time_limit = 30_000
    @start_time = Gosu.milliseconds
  end

  def update
    return if @game_over

    @sara.update
    @nikus.each(&:update)

    #新しい肉を生成
    if Gosu.milliseconds - @last_niku_spawn > 500
      @nikus << Niku.new(self)
      @last_niku_spawn = Gosu.milliseconds
    end

    # 画面外に出たボールを削除
    @nikus.reject! { |niku| niku.y > self.height + niku.radius }

    # 当たり判定
    @nikus.each do |niku|
      distance = Gosu.distance(@sara.x, @sara.y, niku.x, niku.y)
      if distance < @sara.radius + niku.radius
        if niku.good_niku?
          @score += niku.score

          # ★ シャトーブリアン判定して効果音再生 ★
          if niku.score == 250
            @special_se.play
          end

          @nikus.delete(niku)
        else
            @game_over = true
            end_game
        end
      end
    end

    # 制限時間チェック
    if Gosu.milliseconds - @start_time > @time_limit
      end_game
    end
  end

  def draw
    #背景を描画
    @background_image.draw(0,-200,0)

    #Gosu.draw_rect(0, 0, width, height, Gosu::Color::BLACK, 0)
    @font.draw_text("いただきます！", 200, 200, 1, 1.0, 1.0, Gosu::Color::WHITE)
    @sara.draw
    @nikus.each(&:draw)
    @font.draw_text("スコア: #{@score}", 10, 10, 1)

    #残り時間表示
    remaining = [(@time_limit - (Gosu.milliseconds - @start_time)) / 1000, 0].max
    @font.draw_text("残り時間: #{remaining}", 10, 40, 1)
  end

    private

  # ゲーム終了処理
  def end_game
    save_score(@score)
    # if @game_over 
    #     save_score(@score) # ゲームオーバー時にスコアを保存
    #     close # このウィンドウを閉じて
    #     EndingWindow.new(@score, @scores, :failure).show # スコアを渡してエンディング開始
    # else
    #     save_score(@score) # ゲームオーバー時にスコアを保存
    #     close # このウィンドウを閉じて
    #     EndingWindow.new(@score, @scores, :success).show # スコアを渡してエンディング開始
    # end
    # EndingWindowを開いて終了待ち
    ending = EndingWindow.new(@score, @scores, @game_over ? :failure : :success)
    ending.show

    # リスタート希望なら新しいGameWindowを開く
    if ending.restart
        GameWindow.new.show
    else
        
        exit   # ← プログラムを完全に終了
    end
  end

#   # スコアをファイルから読み込む
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
    scores.take(5) # 上位5件のみ取得
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
end

# ゲーム開始
#GameWindow.new.show