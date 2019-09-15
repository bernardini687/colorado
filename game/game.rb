require_relative 'game_actions'
require_relative 'game_utils.rb'

class Game < Gosu::Window
  WIDTH = 800
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT

    @world = World.new 'media/level_0.txt'
    @cat = @world.cats.find(&:known?)

    @font = Gosu::Font.new 20
    @cam_x = 0
  end

  def update
    self.caption = "x: #{@cat.x}, y: #{@cat.y}; fps: #{Gosu.fps}"

    # cat movement
    move_x = 0
    move_x -= 8 if Input.left?  && !@cat.scanning?
    move_x += 8 if Input.right? && !@cat.scanning?
    @cat.update(move_x)

    @neighbour = @cat.find_neighbour

    # camera follows
    @cam_x = [[(@cat.x - WIDTH / 2), 0].max, (@world.width * 64 - WIDTH)].min
  end

  def draw
    @font.draw_text(counters, 10, 10, 2)

    Gosu.translate(-@cam_x, 0) do
      filtered_actors.each(&:draw)
      @world.draw
      if @cat.special_action?
        @neighbour.glow
        @cat.glow
      else
        @neighbour&.draw
        @cat.draw
      end
    end
  end

  include GameUtils
  include GameActions
end
