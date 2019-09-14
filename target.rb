class Target < Actor
  attr_writer :marked

  def initialize(map, x, y)
    super(map, x, y)

    @marked = false

    @img = Gosu::Image.new 'media/target.png'
  end

  def draw
    marked? ? super : @img.draw(x, y, 1, 1, 1, @darker, :add)
  end

  def marked?
    @marked
  end
end
