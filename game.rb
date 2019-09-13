# frozen_string_literal: true

require 'gosu'

# utility modules
require_relative 'tiles'
require_relative 'keys'

# entities
require_relative 'map'
require_relative 'actor'
require_relative 'target'
require_relative 'player'
require_relative 'scan'

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
    move_x -= 8 if Keys.left?
    move_x += 8 if Keys.right?
    @sqr.update(move_x)

    @cam_x = [[(@sqr.x - WIDTH / 2), 0].max, (@map.width * 64 - WIDTH)].min
  end

  def draw
    Gosu.translate(-@cam_x, 0) do
      @map.draw
      @sqr.draw
    end
    @font.draw_text(counters, 10, 10, 2)
  end

  def button_down(key)
    case key
    when Gosu::KB_ESCAPE then close
    when Gosu::KB_A      then @sqr.action
    when Gosu::KB_DOWN   then @sqr = select_nearest_sqr to: :left
    when Gosu::KB_J      then @sqr = select_nearest_sqr to: :left
    when Gosu::KB_UP     then @sqr = select_nearest_sqr to: :right
    when Gosu::KB_K      then @sqr = select_nearest_sqr to: :right
    else super
    end
  end

  private

  # network is sorted by x, select the nearest neighbour to the given direction
  def select_nearest_sqr(to:)
    return @sqr if @sqr.scanning?

    curr_index = @sqr.network.index @sqr

    if to == :left
      return @sqr if curr_index.zero?

      @sqr.network[curr_index.pred]
    else
      return @sqr if curr_index + 2 > @sqr.network_size

      @sqr.network[curr_index.succ]
    end
  end

  def info
    "x: #{@sqr.x}, y: #{@sqr.y}; fps: #{Gosu.fps}"
  end

  def counters
    "network: #{@sqr.network_size}\n"\
    "targets: #{@map.marked_targets.size}"
  end
end

Game.new.show
