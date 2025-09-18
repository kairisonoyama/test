#ending
require 'gosu'
require_relative 'game'

class EndingWindow < Gosu::Window

  attr_reader :restart   # ← 外から参照できるようにする

  def initialize(score, scores, result)
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score = score   # ← 引数で受け取る！
    @scores = scores # スコアを読み込む
    @result = result   # ← 成功 or 失敗のフラグ

    # フォント準備
    @font = Gosu::Font.new(32)

    # 画像を読み込む
    @low_image  = Gosu::Image.new("食中毒.png", retro: false)
    @high_image = Gosu::Image.new("成功エンディング画像.png", retro: false)

    #BGMを取り込む
    @low_bgm = Gosu::Song.new("失敗BGM.mp3")
    @high_bgm = Gosu::Song.new("成功BGM.mp3")

    # 成否で分岐
    if @result == :failure
      @image = @low_image
      @bgm   = @low_bgm
      @message = "残念ながら食中毒になりました。乙"
    else
      @image = @high_image
      @bgm   = @high_bgm
      @message = "成功しました。お腹いっぱいです。"
    end

    @bgm.play(false)

    # 選択された画像サイズに合わせてスケール計算
    @scale_x = width / @image.width.to_f
    @scale_y = height / @image.height.to_f

  end

  def draw
    #背景画像
    @image.draw(0, 0, 0, @scale_x, @scale_y)
    #今回のスコア、メッセージ
    Gosu::Font.new(32).draw_text("スコア: #{@score}\n#{@message}", 150, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
    
     # ランキング呼び出し
    draw_ranking

     # リスタート指示
    @font.draw_text("Rキーでリスタート", (self.width - @font.text_width("Rキーでリスタート")) / 2, self.height / 2 + 30, 1)
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


  def button_down(id)
    if id == Gosu::KB_D # 'D'キーが押されたらファイルの中身を空にする
      File.open('scores.txt', 'w') do |file|
        file.truncate(0)
      end
      puts "スコアランキングをリセットしました。"
    end

    if id == Gosu::KB_R
      @restart = true   # ← フラグを立てるだけ
      close             # ← ウィンドウは閉じる
    end
  end

end