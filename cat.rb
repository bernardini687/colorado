class Cat < Actor
  attr_writer :known

  def initialize(map, x, y)
    super(map, x, y)

    @known = false
    @scanning = [false, false]

    @img = Gosu::Image.new 'media/cat.png'
  end

  def update(move_x)
    move_x.positive? && move_x.times    { @x += 1 if would_fit?(32) }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }

    return unless scanning?

    @lscan.response? ? @lscan.update(16) : @lscan.update(-16)
    @rscan.response? ? @rscan.update(-16) : @rscan.update(16)
  end

  def draw
    known? ? super : @img.draw(x, y, 1, 1, 1, @darker, :add)

    return unless scanning?

    @lscan.draw
    @rscan.draw
  end

  def known?
    @known
  end

  def scanning?
    @scanning[0] || @scanning[1]
  end

  def lscan=(value)
    @scanning[0] = value
  end

  def rscan=(value)
    @scanning[1] = value
  end

  def network
    @map.cats.select(&:known?).sort_by(&:x)
  end

  def network_size
    @map.cats.select(&:known?).size
  end

  def action
    neighbour = @map.actors.find { |a| a.near?(self, 64) }
    if neighbour.nil? && !scanning?
      @scanning = [true, true]
      start_scan
    end
    know!(neighbour) if neighbour.class == Cat
    mark!(neighbour) if neighbour.class == Human
  end

  def pull_request
    valid_neighbours? && puts('go ahead!')
  end

  private

  def start_scan
    @lscan = LeftScan.new(self, @map.marks_x, x, y + 128)
    @rscan = RightScan.new(self, @map.marks_x, x, y + 128)
  end

  def mark!(human)
    return if human.marked?

    human.marked = true
  end

  def know!(cat)
    return if cat.known?

    cat.known = true
  end

  def would_fit?(offs_x)
    !@map.solid?(x + offs_x, y)
  end

  def valid_neighbours?
    neighbours = @map.actors.select { |sqr| sqr.near?(self, 256) }
    neighbours.select(&:marked_human?).size == 1 &&
      neighbours.select(&:known_cat?).size.positive? # current cat doesn't count
  end
end