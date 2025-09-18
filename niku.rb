# nikuクラス
class Niku

  NIKU = [
    { path: "images/karubi.png",       weight: 40, score: 11, good: true },#カルビ
    { path: "images/rosu.png",       weight: 27, score: 37, good: true },#ロース
    { path: "images/harami.png",       weight: 12, score: 83, good: true },#ハラミ
    { path: "images/tan.png",       weight: 7, score:103, good: true },#タン
    { path: "images/horumon.png",       weight: 18, score: 61, good: true },#ホルモン
    { path: "images/chateaubrian.png",       weight: 1, score: 634, good: true },#シャトーブリアン
    { path: "images/karubi nama.png",       weight: 4, score: 0, good: false },#以下、生肉
    { path: "images/rosu nama.png",       weight: 4, score: 0, good: false },
    { path: "images/harami nama.png",       weight: 4, score: 0, good: false },
    { path: "images/tan nama.png",       weight: 4, score: 0, good: false },
    { path: "images/horumon nama 2.png",       weight: 4, score: 0, good: false }
    #{ path: "images/rosu.png",       weight: 30, score: 10, bad: false },
]

  def initialize(window)
    @window = window
    @x = rand(@window.width)
    @y = 0
    @speed = 5

  # 重みに応じて選ばれる肉
    niku_data = self.class.weighted_random
    @image = Gosu::Image.new(niku_data[:path], retro: false)

    # 当たり判定用の大きさ（半径っぽく扱う）
    @radius = [@image.width, @image.height].min / 2 *0.8

    # 肉ごとのスコア
    @score = niku_data[:score]

    #よい肉かどうか
    @good = niku_data[:good]

  end

  def self.weighted_random
    total = NIKU.sum { |n| n[:weight] }
    pick  = rand(total)
    current = 0
    NIKU.each do |niku|
      current += niku[:weight]
      return niku if pick < current
    end
  end

  def update
    @y += @speed
  end


 def draw
    # 中心を @x, @y に合わせて描画
    scale = 0.7  # ← 倍率をここで調整
    @image.draw(@x - @radius, @y - @radius, 1, scale, scale)
  end

   # --- 追加 ---
  def score
    @score
  end

  def good_niku?
    @good
  end
  #def draw
    #@window.draw_rect(@x - @radius, @y - @radius, @radius * 2, @radius * 2, @color)
  #end

  # 座標・サイズを外から参照できるように
  attr_reader :x, :y, :radius
end


