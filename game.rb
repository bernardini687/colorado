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

    # camera follows
    @cam_x = [[(@cat.x - WIDTH / 2), 0].max, (@world.width * 64 - WIDTH)].min
  end

  def draw
    Gosu.translate(-@cam_x, 0) do
      @world.draw
      @cat.draw
    end
    @font.draw_text(
      "network: #{@cat.network_size}\nmarks: #{@world.marks.size}",
      10, 10, 2
    )
  end

  include GameActions
end
