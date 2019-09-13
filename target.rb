class Target < Actor
  attr_writer :marked

  def initialize(map, x, y)
    super(map, x, y)

    @marked = false

    @img = Gosu::Image.new 'media/target.png'
  end

  def marked?
    @marked
  end
end
