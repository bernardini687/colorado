class Target < Actor
  def initialize(map, x, y)
    super(map, x, y)

    @img = Gosu::Image.new 'media/target.png'
  end
end
