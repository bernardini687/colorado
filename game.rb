require 'gosu'

require_relative 'tiles'
require_relative 'map'

WIDTH = 800
HEIGHT = 480

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @map = Map.new 'media/level_0.txt'
  end

  def update
    self.caption = "s: #{Gosu.milliseconds / 1000}"
  end

  def draw
    @map.draw
  end

  def button_down(key)
    case key
    # when Gosu::KB_UP then @cptn.try_to_jump
    when Gosu::KB_ESCAPE then close
    else super
    end
  end
end

Game.new.show
