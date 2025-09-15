require 'gosu'

class ScoreImageWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score = rand(3000..5000)   #ここに最終スコアを入れる

    # 画像を読み込む（同じフォルダに画像を置いておく）
    @low_image    = Gosu::Image.new("失敗エンディング画像.png")
    @high_image   = Gosu::Image.new("成功エンディング画像.png")
  end

  def draw
    # スコアに応じて画像を切り替えて表示
    image = case @scoreSS
            when 0..4000  #自由に決めるところ
              @low_image
            else
              @high_image
            end

    image.draw(160, 120, 0)  # 中央付近に表示
    Gosu::Font.new(32).draw_text("スコア: #{@score}", 20, 20, 1, 1.0, 1.0, Gosu::Color::BLACK)
  end
end

ScoreImageWindow.new.show
