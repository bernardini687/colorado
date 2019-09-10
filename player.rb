class Player
  attr_reader :x, :y

  def initialize(map, x, y)
    @map = map
    @x = x
    @y = y

    @img = Gosu::Image.new 'media/hero.png'
  end

  def update(move_x)
    move_x.positive? && move_x.times { @x += 1 if would_fit? 32 }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }
  end

  def draw
    @img.draw(@x, @y, 1)
  end

  def would_fit?(offs_x)
    !@map.solid?(@x + offs_x, @y)
  end
end
