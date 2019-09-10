class Target < Square
  def initialize(map, x, y)
    super(map, x, y)

    @color.red = 238
    @color.green = 133
    @color.blue = 133
  end
end
