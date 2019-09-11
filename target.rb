class Target < Actor
  def initialize(map, x, y)
    super(map, x, y)

    # @color = Gosu::Color.rgba(255, 80, 80, 255)

    @color.red = 255
    @color.green = @color.blue = 80
  end
end
