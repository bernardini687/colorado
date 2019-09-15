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
    @font.draw_text(counters, 10, 10, 2)
  end

  def button_down(key)
    case key
    when Gosu::KB_ESCAPE then close
    when Gosu::KB_A      then @cat.action
    when Gosu::KB_F      then @cat.pull_request
    when Gosu::KB_DOWN   then @cat = next_cat to: :left
    when Gosu::KB_J      then @cat = next_cat to: :left
    when Gosu::KB_UP     then @cat = next_cat to: :right
    when Gosu::KB_K      then @cat = next_cat to: :right
    else super
    end
  end

  private

  # network is sorted by x axis
  # select the nearest neighbour to the given direction
  def next_cat(to:)
    return @cat if @cat.scanning?

    current = @cat.network.index @cat

    if to == :left
      current.zero?                   ? @cat : @cat.network[current.pred]
    else
      current + 2 > @cat.network_size ? @cat : @cat.network[current.succ]
    end
  end

  def counters
    "network: #{@cat.network_size}\n"\
    "marks: #{@world.marks.size}"
  end
end
