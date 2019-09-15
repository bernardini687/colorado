class LeftScan < BaseScan
  def initialize(origin, data, x, y)
    super(origin, data, x, y)
  end

  def update(move_x)
    # move foreword to the left
    move_x.negative? && (-move_x).times do
      @x -= 1 unless reached_limit?
      @response = true if found_human?
    end
    # go back right
    move_x.positive? && move_x.times { @x += 1 unless reached_origin? }
  end

  def draw
    @origin.lscan = false if reached_limit? || reached_origin?
    super
  end

  private

  def reached_limit?
    @x < @origin.x - RANGE
  end
end
