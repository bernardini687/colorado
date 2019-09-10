require 'gosu'

require_relative 'tiles'
require_relative 'map'
require_relative 'player'

WIDTH = 800
HEIGHT = 480

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @map = Map.new 'media/level_0.txt'
    @sqr = Player.new(@map, WIDTH / 2, HEIGHT - 256)
  end

  def update
    self.caption = "s: #{Gosu.milliseconds / 1000}; #{info}"

    move_x = 0
    button_down?(Gosu::KB_LEFT)  && move_x -= 4
    button_down?(Gosu::KB_RIGHT) && move_x += 4
    @sqr.update(move_x)
  end

  def draw
    @map.draw
    @sqr.draw
  end

  def button_down(key)
    case key
    # when Gosu::KB_UP then @sqr.try_to_run
    when Gosu::KB_ESCAPE then close
    else super
    end
  end

  def info
    "x: #{@sqr.x}, y: #{@sqr.y}"
  end
end

Game.new.show
