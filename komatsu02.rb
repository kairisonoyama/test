require 'gosu'



class GameWindow < Gosu::Window
    def initialize
        #画面の設定
        super(640,480,false)
        self.caption = "Gosu Test Game"

        #画像を読み込む
        @haikei  = Gosu::Image.new("media/yakinikuya2.png", retro: false)
        
        #読み込んだ画像のスケールを計算
        @scale_x = width / @haikei.width.to_f
        @scale_y = height / @haikei.height.to_f
        
        #BGMの読み込み
        @bgm = Gosu::Song.new("media/VSQSE_1044_grilling_meat_01.mp3")
        
        #BGMの再生
        @bgm.play
        true
    end

    #ゲームの主要ロジック
    def update
    end

    #画像をうつす
    def draw
        @haikei.draw(0,0,0,@scale_x,@scale_y)
    end

    #エスケープキーで終了
    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = GameWindow.new
window.show