# プレイヤー（キャラクター）クラス
class Sara
  def initialize(window)
    @window = window
    @x = @window.width / 2   #初期値のx座標を中央に設定
    @y = @window.height - 50 #初期値のy座標を画面下に設定
    @speed = 5         #動くスピード

     # お皿の画像を読み込み
    @image = Gosu::Image.new("images/plate.png")  

  end

  def update
    if @window.button_down?(Gosu::KB_LEFT) #←が押されたときに左に動く
      @x -= @speed
    end
    if @window.button_down?(Gosu::KB_RIGHT) #→が押されたときに右に動く
      @x += @speed
    end
    # 画面外に出ないようにする
    @x = [[@x, @radius].max, @window.width - @radius].min  #[].maxで左側を制限、[].minで右側を制限
  end

  def draw  #@window.draw_rect(皿の左上のx座標, 四角形の左上のy座標, 幅, 高さ, 色)
    #@image.draw(@x - @image.width / 2, @y - @image.height / 2, 1)
    @image.draw(@x - @image.width / 2 * 1, 
            @y - @image.height / 2 * 1, 
            1, 
            1,1)
  end

  def x
    @x
  end

  def y
    @y
  end

  def radius
    [@image.width * @scale, @image.height * @scale].min / 2
  end
end
