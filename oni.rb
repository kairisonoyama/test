require 'gosu'

class ScoreImageWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score =    #ここに最終スコアを入れる

    # 画像を読み込む（同じフォルダに画像を置いておく）
    @low_image    = Gosu::Image.new("失敗エンディング画像.png")
    @medium_image = Gosu::Image.new("neutral.png")
    @high_image   = Gosu::Image.new("happy.png")
  end

  def draw
    # スコアに応じて画像を切り替えて表示
    image = case @score
            when #ここにスコアの範囲を入力
              @low_image
            when #ここにスコア
              @medium_image
            else
              @high_image
            end

    image.draw(160, 120, 0)  # 中央付近に表示
    Gosu::Font.new(32).draw_text("スコア: #{@score}", 20, 20, 1, 1.0, 1.0, Gosu::Color::BLACK)
  end
end

ScoreImageWindow.new.show
