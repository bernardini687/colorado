require 'gosu'

# utility modules
require_relative 'tiles'
require_relative 'skin'

# entities
require_relative 'map'
require_relative 'actor'
require_relative 'target'
require_relative 'player'

WIDTH = 800
HEIGHT = 480

class Game < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    @map = Map.new 'media/level_0.txt'
    @sqr = Player.new(@map, WIDTH / 2, HEIGHT - 128) # 64 + 32 + 32

    @cam_x = @cam_y = 0
  end

  def update
    self.caption = "s: #{Gosu.milliseconds / 1000}; #{info}"

    move_x = 0
    move_x -= @sqr.speed if button_down?(Gosu::KB_LEFT)
    move_x += @sqr.speed if button_down?(Gosu::KB_RIGHT)
    @sqr.update(move_x)

    @cam_x = [[@sqr.x - WIDTH / 2, 0].max, @map.width * 64 - WIDTH].min
    @cam_y = [[@sqr.y - HEIGHT / 2, 0].max, @map.height * 64 - HEIGHT].min
  end

  def draw
    Gosu.translate(-@cam_x, -@cam_y) do
      @map.draw
      @sqr.draw
    end
  end

  def button_down(key)
    case key
    # when Gosu::KB_UP then @sqr.scan
    when Gosu::KB_ESCAPE then close
    else super
    end
  end

  def info
    "x: #{@sqr.x}, y: #{@sqr.y}"
  end
end

Game.new.show
