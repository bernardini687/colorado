class Player < Square
  attr_reader :speed

  def initialize(map, x, y)
    super(map, x, y)

    @speed = 8

    @color.red = 238
    @color.green = 185
    @color.blue = 133
  end

  def update(move_x)
    move_x.positive? && move_x.times { @x += 1 if would_fit? 32 }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }
  end

  private

  def would_fit?(offs_x)
    !@map.solid?(@x + offs_x, @y)
  end
end
