class Scan
  attr_reader :x, :y
  MAX_DIST = 256

  def initialize(data, x, y)
    @data = data
    @x = @origin_x = x
    @y = y

    @positive = false

    @img = Gosu::Image.new 'media/scan.png'
    p @data # <<<<<<
  end

  def positive?
    @positive
  end

  def update(move_x)
    move_x.positive? && move_x.times do
      @x += 1 unless reached_limit?
      @positive = true if found_target?
    end
    move_x.negative? && (-move_x).times { @x -= 1 unless reached_origin? }
  end

  def draw
    @img.draw(x, y, 2) unless reached_limit? || reached_origin?
  end

  private

  def found_target?
    @data.any? { |target_x| x == target_x }
  end

  def reached_limit?
    x > @origin_x + MAX_DIST
  end

  def reached_origin?
    x == @origin_x
  end
end
