class Human < Actor
  attr_writer :marked

  def initialize(world, x, y)
    super(world, x, y)

    @marked = false

    @img = Gosu::Image.new 'media/human.png'
  end

  def draw
    marked? ? super : @img.draw(x, y, 1, 1, 1, @darker, :add)
  end

  def marked?
    @marked
  end
end
