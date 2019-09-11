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

  def near?(obj)
    return false if obj == self

    distance = Gosu.distance(x, y, obj.x, obj.y)
    self.class == Target ? distance < 128 : distance < 64
  end
end
