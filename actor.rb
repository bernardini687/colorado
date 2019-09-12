class Actor
  attr_reader :x, :y

  def initialize(map, x, y)
    @map = map
    @x = x
    @y = y
  end

  def draw
    @img.draw(x, y, 1)
  end

  def near?(obj)
    return false if obj == self

    Gosu.distance(x, y, obj.x, obj.y) < 64
  end
end
