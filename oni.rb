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
    G

  end
end

ScoreImageWindow.new.show

class AutoResizeWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "画像の自動調整表示"

    @low_image = Gosu::Image.new("失敗エンディング画像.png", retro: false)
    @High_image = Gosu::Image.new("成功エンディング画像.png", retro: false)

    # 元の画像サイズを取得
    @img_width1 = @low_image.width.to_f
    @img_height1 = @low_image.height.to_f
    @img_width2 = @High_image.width.to_f
    @img_height2 = @High_image.height.to_f

    # ウィンドウサイズに合わせたスケールを計算
    @scale_x = width / @img_width1
    @scale_y = height / @img_height1
    @scale_x = width / @img_width2
    @scale_y = height / @img_height2
  end

  def draw
    # スケールを使って画像を描画（左上に表示）
    @image.draw(0, 0, 0, @scale_x, @scale_y)
  end
end

AutoResizeWindow.new.show

