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

    @world.humans.each(&:update)

    @neighbour  = @cat.find_neighbour
    @neighbours = @cat.find_neighbours
    @actionable = action?
    @abductable = valid_neighbours?

    @countdown = @cat.find_target&.countdown if @abductable

    if @countdown
      @countdown.update
      return puts 'game over!' if @countdown.target.seen? # <<<<<<

      unless @abductable
        @countdown.target.reset!
        return @countdown = nil
      end

      if @countdown.ended?
        @countdown.target.abduct!
        @countdown = nil
      end
    end

    # camera follows
    @cam_x = [[(@cat.x - WIDTH / 2), 0].max, (@world.width * 64 - WIDTH)].min
  end

  def draw
    @font.draw_text(counters, 10, 10, 2)
    @font.draw_text(@countdown.log, 200, 10, 2) if @countdown

    Gosu.translate(-@cam_x, 0) do
      @world.draw
      filtered_actors.each(&:draw)
      if @actionable
        @neighbour.glow
        @cat.glow
      elsif @abductable
        @neighbours.each(&:glow)
        @cat.glow
      else
        @cat.draw
      end
    end
  end

  include GameActions
  include GameUtils
end
