

require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "ゲームオープニング"

    @state = :opening
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
    @title_image.draw(0, 0, 0, @scale_x, @scale_y)
    @font.draw_text("スペースキーでスタート", 180, 400, 1, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def draw_game
    Gosu.draw_rect(0, 0, width, height, Gosu::Color::BLACK, 0)
    @font.draw_text("いただきます！", 200, 200, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end
end

GameWindow.new.show


class ScoreImageWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "スコアに応じた画像表示"

    @score = rand(3000..5000)   # 最終スコア

    # 画像を読み込む
    @low_image  = Gosu::Image.new("食中毒.png", retro: false)
    @high_image = Gosu::Image.new("成功エンディング画像.png", retro: false)

    # スコアに応じて画像を選択
    @image = @score <= 4000 ? @low_image : @high_image

    # 選択された画像サイズに合わせてスケール計算
    @scale_x = width / @image.width.to_f
    @scale_y = height / @image.height.to_f

    #最後のメッセージの分岐
    @message = case @score
               when 0..4000
                "残念ながら食中毒になりました。乙"
               else
                "成功しました。お腹いっぱいです。"
               end
  end

  def draw
    @image.draw(0, 0, 0, @scale_x, @scale_y)
    Gosu::Font.new(32).draw_text("スコア: #{@score}\n#{@message}", 150, 150, 1, 1.0, 1.0, Gosu::Color::WHITE)
    
  end
end

ScoreImageWindow.new.show



