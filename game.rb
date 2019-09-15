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

    move_x = 0
    move_x -= 8 if Keys.left? && !@cat.scanning?
    move_x += 8 if Keys.right? && !@cat.scanning?
    @cat.update(move_x)

    @cam_x = [[(@cat.x - WIDTH / 2), 0].max, (@world.width * 64 - WIDTH)].min
  end

  def draw
    Gosu.translate(-@cam_x, 0) do
      @world.draw
      @cat.draw
    end
    @font.draw_text(counters, 10, 10, 2)
  end

  def button_down(key)
    case key
    when Gosu::KB_ESCAPE then close
    when Gosu::KB_A      then @cat.action
    when Gosu::KB_F      then @cat.pull_request
    when Gosu::KB_DOWN   then @cat = select_nearest_cat to: :left
    when Gosu::KB_J      then @cat = select_nearest_cat to: :left
    when Gosu::KB_UP     then @cat = select_nearest_cat to: :right
    when Gosu::KB_K      then @cat = select_nearest_cat to: :right
    else super
    end
  end

  private

  # network is sorted by x, select the nearest neighbour to the given direction
  def select_nearest_cat(to:)
    return @cat if @cat.scanning?

    curr_index = @cat.network.index @cat

    if to == :left
      return @cat if curr_index.zero?

      @cat.network[curr_index.pred]
    else
      return @cat if curr_index + 2 > @cat.network_size

      @cat.network[curr_index.succ]
    end
  end

  def counters
    "network: #{@cat.network_size}\n"\
    "marks: #{@world.marks.size}"
  end
end
