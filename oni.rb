

require 'gosu'

class ScoreImageWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score = rand(4000..5000)   # 最終スコア

    # 画像を読み込む
    @low_image  = Gosu::Image.new("失敗エンディング画像.png", retro: false)
    @high_image = Gosu::Image.new("成功エンディング画像.png", retro: false)

    # スコアに応じて画像を選択
    @image = @score <= 4000 ? @low_image : @high_image

    # 選択された画像サイズに合わせてスケール計算
    @scale_x = width / @image.width.to_f
    @scale_y = height / @image.height.to_f
  end

  def draw
    @image.draw(0, 0, 0, @scale_x, @scale_y)
    Gosu::Font.new(32).draw_text("スコア: #{@score}", 20, 20, 1, 1.0, 1.0, Gosu::Color::BLACK)
  end
end

ScoreImageWindow.new.show
