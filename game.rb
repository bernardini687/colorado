require 'gosu'

# utility modules
require_relative 'tiles'

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
    @sqr = @map.players.find(&:known?)
    @sqrs = @map.network.cycle.each

    @cam_x = @cam_y = 0
    @font = Gosu::Font.new 20
  end

  def update
    self.caption = "s: #{Gosu.milliseconds / 1000}; #{info}"

    move_x = 0
    move_x -= 8 if button_down?(Gosu::KB_LEFT)
    move_x += 8 if button_down?(Gosu::KB_RIGHT)
    @sqr.update(move_x)

    @cam_x = [[@sqr.x - WIDTH / 2, 0].max, @map.width * 64 - WIDTH].min
    @cam_y = [[@sqr.y - HEIGHT / 2, 0].max, @map.height * 64 - HEIGHT].min
  end

  def draw
    Gosu.translate(-@cam_x, -@cam_y) do
      @map.draw
      @sqr.draw
    end
    @font.draw_text("network: #{@map.network.size}", 10, 10, 2)
  end

  def button_down(key)
    case key
    # when Gosu::KB_A then @sqr.action
    when Gosu::KB_UP then @sqr = @sqrs.next # need to update @sqrs
    when Gosu::KB_ESCAPE then close
    else super
    end
  end

  def info
    "x: #{@sqr.x}, y: #{@sqr.y}"
  end
end

Game.new.show
