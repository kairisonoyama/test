# ボールクラス
class Ball
  def initialize(window)
    @window = window
    @x = rand(@window.width)
    @y = 0
    @radius = 15
    @speed = 3
    @color = Gosu::Color::RED
  end

  def update
    @y += @speed
  end

  def draw
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
