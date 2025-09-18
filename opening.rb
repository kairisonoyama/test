require 'gosu'
require_relative 'game'
require_relative 'ending'

class OpeningWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "ゲームオープニング"

    #@state = :opening
    @font = Gosu::Font.new(32)
    @title_image = Gosu::Image.new("オープニング　候補　画像.png", retro: false)
    @bgm = Gosu::Song.new("オープニング曲.mp3")
    @bgm.play(true)

    @start_time = Gosu.milliseconds
     # 選択された画像サイズに合わせてスケール計算
    @scale_x = width / @title_image.width.to_f
    @scale_y = height / @title_image.height.to_f

  end

  def update
    # if @state == :opening && Gosu.button_down?(Gosu::KB_SPACE)
    #   @state = :playing
    #   @bgm.stop
    # end
    if Gosu.button_down?(Gosu::KB_SPACE)
      close # このウィンドウを閉じて
      GameWindow.new.show # ゲーム本体を開始
    end
  end

  def draw
    @title_image.draw(0, 0, 0, @scale_x, @scale_y)
    @font.draw_text("スペースキーでスタート", 180, 400, 1, 1.0, 1.0, Gosu::Color::YELLOW)
    # case @state
    # when :opening
    #   draw_opening
    # when :playing 
    #   draw_game
    # end
  end

#   def draw_opening
#     @title_image.draw(0, 0, 0, @scale_x, @scale_y)
#     @font.draw_text("スペースキーでスタート", 180, 400, 1, 1.0, 1.0, Gosu::Color::YELLOW)
#   end

#   def draw_game
#     Gosu.draw_rect(0, 0, width, height, Gosu::Color::BLACK, 0)
#     @font.draw_text("いただきます！", 200, 200, 1, 1.0, 1.0, Gosu::Color::WHITE)
#   end
end

OpeningWindow.new.show