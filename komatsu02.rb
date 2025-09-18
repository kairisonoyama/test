require 'gosu'



class GameWindow < Gosu::Window
    def initialize
        super(1000,600,false)
        self.caption = "Gosu Tutorial Game"

        @background_image = Gosu::Image.new("media/yakinikuya.png",options = {window: self})
        @bgm = Gosu::Song.new("media/VSQSE_1044_grilling_meat_01.mp3")
        @bgm.play
        true
    end
    def update
    end
    def draw
        @background_image.draw(0,-200,0)
    end
    def button_down(id)
        if id == Gosu::KbEscape
            close
        end
    end
end

window = GameWindow.new
window.show