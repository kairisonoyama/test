require 'gosu'



class GameWindow < Gosu::Window
    def initialize
        super(1000,600,false)
        self.caption = "Gosu Tutorial Game"

        @background_image = Gosu::Image.new(self,"media/yakinikuya.png",true)
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