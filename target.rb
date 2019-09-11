class Target < Actor
  def initialize(map, x, y)
    super(map, x, y)

    @img = Gosu::Image.new 'media/target.png'
    @color = Gosu::Color.rgba(*Skin::COLORS.sample, 255)
  end
end
