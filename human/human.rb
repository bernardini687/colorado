class Human < Actor
  attr_writer :marked

  def initialize(world, x, y)
    super(world, x, y)

    @marked = false

    @img  = Gosu::Image.new 'media/human.png'
    @glow = Gosu::Image.new 'media/glowing_human.png'
  end

  def update
    @seen = @world.humans.any? { |human| human.near?(self, 1024) }
  end

  def marked?
    @marked
  end

  def seen?
    @seen
  end

  def abduct!
    # introduce timer here?
    @world.humans.reject! { |human| human == self }
  end
end
