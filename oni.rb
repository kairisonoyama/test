

require 'gosu'

class ScoreImageWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score = rand(3000..5000)   # 最終スコア

    # 画像を読み込む
    @low_image  = Gosu::Image.new("食中毒.png", retro: false)
    @high_image = Gosu::Image.new("成功エンディング画像.png", retro: false)

    # スコアに応じて画像を選択
    @image = @score <= 4000 ? @low_image : @high_image

    # 選択された画像サイズに合わせてスケール計算
    @scale_x = width / @image.width.to_f
    @scale_y = height / @image.height.to_f

    #最後のメッセージの分岐
    @message = case @score
               when 0..4000
                "残念ながら食中毒になりました。乙"
               else
                "成功しました。お腹いっぱいです。"
               end
  end

  def draw
    @image.draw(0, 0, 0, @scale_x, @scale_y)
    Gosu::Font.new(32).draw_text("スコア: #{@score}\n#{@message}", 150, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
    
  end
end

ScoreImageWindow.new.show
