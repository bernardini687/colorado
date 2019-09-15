class BaseScan
  RANGE = 1024

  def initialize(origin, data, x, y)
    @origin = origin
    @data = data
    @x = x
    @y = y

    @response = false

    @img = Gosu::Image.new 'media/scan.png'
  end

  def draw
    @img.draw(@x, @y, 2)
  end

  def response?
    @response
  end

  def found_human?
    @data.any? { |human_x| @x == human_x }
  end

  def reached_origin?
    @x == @origin.x
  end
end
