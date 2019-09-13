# frozen_string_literal: true

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

    @font = Gosu::Font.new 20
    @cam_x = 0
  end

  def update
    self.caption = "s: #{Gosu.milliseconds / 1000}; #{info}"

    move_x = 0
    move_x -= 8 if button_down? Gosu::KB_LEFT
    move_x += 8 if button_down? Gosu::KB_RIGHT
    @sqr.update(move_x)

    @cam_x = [[(@sqr.x - WIDTH / 2), 0].max, (@map.width * 64 - WIDTH)].min
  end

  def draw
    Gosu.translate(-@cam_x, 0) do
      @map.draw
      @sqr.draw
    end
    @font.draw_text("network: #{@sqr.network_size}", 10, 10, 2)
  end

  def button_down(key)
    case key
    when Gosu::KB_ESCAPE then close
    when Gosu::KB_A then @sqr.action
    when Gosu::KB_UP then @sqr = succ
    when Gosu::KB_DOWN then @sqr = pred
    else super
    end
  end

  private

  # network is sorted by x, select the nearest neighbour to the right
  def succ
    curr_index = @sqr.network.index @sqr
    return @sqr if curr_index + 2 > @sqr.network_size

    @sqr.network[curr_index.succ]
  end

  # select the nearest neighbour to the left
  def pred
    curr_index = @sqr.network.index @sqr
    return @sqr if curr_index.zero?

    @sqr.network[curr_index.pred]
  end

  def info
    "x: #{@sqr.x}, y: #{@sqr.y}"
  end
end

Game.new.show
