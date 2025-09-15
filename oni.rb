

require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "ゲームオープニング"

    @state = :opening
    @font = Gosu::Font.new(32)
    @title_image = Gosu::Image.new("オープニング　候補　画像.png")
    @bgm = Gosu::Song.new("オープニング曲")
    @bgm.play(true)

    @start_time = Gosu.milliseconds
  end

  def update
    if @state == :opening && Gosu.button_down?(Gosu::KB_SPACE)
      @state = :playing
      @bgm.stop
    end
  end

  def draw
    case @state
    when :opening
      draw_opening
    when :playing
      draw_game
    end
  end

  def draw_opening
    @title_image.draw(0, 0, 0)
    @font.draw_text("スペースキーでスタート", 180, 400, 1, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def draw_game
    Gosu.draw_rect(0, 0, width, height, Gosu::Color::BLACK, 0)
    @font.draw_text("いただきます！", 200, 200, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end
end

GameWindow.new.show





