# nikuクラス
class Niku

  NIKU = [
    "images/karubi.png",
    "images/rosu.png",
    "images/harami.png",
    "images/tan.png",
    "images/horumon.png"
  ]

  def initialize(window)
    @window = window
    @x = rand(@window.width)
    @y = 0
    @speed = 3

  # 画像をランダムで選ぶ
    image_path = NIKU.sample
    @image = Gosu::Image.new(image_path, retro: false)

    # 当たり判定用の大きさ（半径っぽく扱う）
    @radius = [@image.width, @image.height].min / 2
  end

  def update
    @y += @speed
  end


 def draw
    # 中心を @x, @y に合わせて描画
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  #def draw
    #@window.draw_rect(@x - @radius, @y - @radius, @radius * 2, @radius * 2, @color)
  #end

  # 座標・サイズを外から参照できるように
  attr_reader :x, :y, :radius
end

  #def x
   # @x
  #end

#  def y
   # @y
  #end

  #def radius
   # @radius
  #end
#end
