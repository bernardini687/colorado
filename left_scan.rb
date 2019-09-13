class LeftScan
  RANGE = 1024

  def initialize(scanner, data, x, y)
    @scanner = scanner
    @data = data
    @x = x
    @y = y

    @found = false

    @img = Gosu::Image.new 'media/scan.png'
  end

  def found?
    @found
  end

  def update(move_x)
    move_x.negative? && (-move_x).times do
      @x -= 1 unless reached_limit?
      @found = true if found_target?
    end
    move_x.positive? && move_x.times { @x += 1 unless reached_scanner? }
  end

  def draw
    @scanner.lscanning = false if reached_limit? || reached_scanner?
    @img.draw(@x, @y, 2)
  end

  private

  def found_target?
    @data.any? { |target_x| @x == target_x }
  end

  def reached_limit?
    @x < @scanner.x - RANGE
  end

  def reached_scanner?
    @x == @scanner.x
  end
end
