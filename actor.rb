class Actor
  attr_reader :x, :y

  def initialize(map, x, y)
    @map = map
    @x = x
    @y = y
  end

  def draw
    @img.draw(@x, @y, 1)
  end
end
