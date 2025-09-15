# プレイヤー（キャラクター）クラス
class Player
  def initialize(window)
    @window = window
    @x = @window.width / 2  #初期値のx座標を中央に設定
    @y = @window.height - 50 #初期値のy座標を画面下に設定
    @radius = 20           #サイズ
    @color = Gosu::Color::BLUE #色
    @speed = 5          #動くスピード
  end

  def update
    if @window.button_down?(Gosu::KB_LEFT) #←が押されたときに左に動く
      @x -= @speed
    end
    if @window.button_down?(Gosu::KB_RIGHT) #→が押されたときに右に動く
      @x += @speed
    end
    # 画面外に出ないようにする
    @x = [[@x, @radius].max, @window.width - @radius].min #[].maxで左側を制限、[].minで右側を制限
  end

  def draw #@window.draw_rect(四角形の左上のx座標, 四角形の左上のy座標, 幅, 高さ, 色)
    @window.draw_rect(@x - @radius, @y - @radius, @radius * 2, @radius * 2, @color)
  end

  def x
    @x
  end

  def y
    @y
  end

  def radius
    @radius
  end
end
