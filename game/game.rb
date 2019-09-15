require_relative 'game_actions'

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
    Gosu.translate(-@cam_x, 0) do
      @world.draw
      @world.actors.reject { |a| [@cat, @neighbour].include? a }.each(&:draw)
      if @cat.special_action?
        @cat.glow
        @neighbour.glow
      else
        @cat.draw
        @neighbour&.draw
      end
    end
    @font.draw_text(counters, 10, 10, 2)
  end

  def counters
    "network: #{@cat.network_size}\n"\
    "marks: #{@world.marks.size}"
  end

  include GameActions
end
