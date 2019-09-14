class Actor
  attr_reader :x, :y

  def initialize(map, x, y)
    @map = map
    @x = x
    @y = y

    @darker = Gosu::Color.rgba(255, 255, 255, 159)
  end

  def draw
    @img.draw(x, y, 1)
  end

  def near?(obj, distance)
    return false if obj == self

    Gosu.distance(x, y, obj.x, obj.y) < distance
  end

  def target?
    self.class == Target && marked?
  end

  def player?
    self.class == Player && known?
  end
end
