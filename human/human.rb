class Human < Actor
  attr_writer :marked

  def initialize(world, x, y)
    super(world, x, y)

    @marked = false

    @img  = Gosu::Image.new 'media/human.png'
    @glow = Gosu::Image.new 'media/glowing_human.png'
  end

  def marked?
    @marked
  end
end
