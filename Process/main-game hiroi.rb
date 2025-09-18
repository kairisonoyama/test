# game.rb
require 'gosu'
require_relative 'niku'
require_relative 'sara'

# ゲームのメインウィンドウ 
class GameWindow < Gosu::Window
  def initialize
    super(640, 480)
    self.caption = "拾い物ゲーム"
    @sara = Sara.new(self)
    @nikus = []
    @last_niku_spawn = Gosu.milliseconds
    @font = Gosu::Font.new(20)
    @score = 0
    @game_over = false

    # 制限時間 (30秒)
    @time_limit = 30_000
    @start_time = Gosu.milliseconds
  end

  def update
    return if @game_over

    @sara.update
    @nikus.each(&:update)

    # 新しい肉を生成
    if Gosu.milliseconds - @last_niku_spawn > 500
      @nikus << Niku.new(self)
      @last_niku_spawn = Gosu.milliseconds
    end

    # 画面外に出たボールを削除
    @nikus.reject! { |niku| niku.y > self.height + niku.radius }

    # 当たり判定
    @nikus.each do |niku|
      distance = Gosu.distance(@sara.x, @sara.y, niku.x, niku.y)
      if distance < @sara.radius + niku.radius
        if niku.good?
          @score += niku.score
          @nikus.delete(niku)
        else
          @game_over = true  # 生肉 → ゲームオーバー
        end
      end
    end

    # 制限時間チェック
    if Gosu.milliseconds - @start_time > @time_limit
      @game_over = true
    end
  end

  def draw
    @player.draw
    @nikus.each(&:draw)
    @font.draw_text("スコア: #{@score}", 10, 10, 1)

    # 残り時間表示
    remaining = [(@time_limit - (Gosu.milliseconds - @start_time)) / 1000, 0].max
    @font.draw_text("残り時間: #{remaining}", 10, 40, 1)

    if @game_over
      game_over_text = "ゲーム終了！ スコア: #{@score}"
      text_width = @font.text_width(game_over_text)
      @font.draw_text(game_over_text, (self.width - text_width) / 2, self.height / 2, 1)
      @font.draw_text("Rキーでリスタート", (self.width - @font.text_width("Rキーでリスタート")) / 2, self.height / 2 + 30, 1)
    end
  end

  def button_down(id)
    if @game_over && id == Gosu::KB_R
      initialize
    end
  end
end

# ゲーム開始
GameWindow.new.show