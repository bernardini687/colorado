class Square
  attr_reader :x, :y

  def initialize(map, x, y)
    @map = map
    @x = x
    @y = y

    @img = Gosu::Image.new 'media/square.png'
    @color = Gosu::Color::BLACK.dup
  end

  def draw
    @img.draw(@x, @y, 1, 1, 1, @color, :add)
  end
end
