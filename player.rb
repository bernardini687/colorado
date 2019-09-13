class Player < Actor
  attr_writer :known, :scanning

  def initialize(map, x, y)
    super(map, x, y)

    @known = false
    @scanning = false

    @img = Gosu::Image.new 'media/player.png'
  end

  def update(move_x)
    move_x.positive? && move_x.times    { @x += 1 if would_fit?(32) }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }

    return unless scanning?

    @scan.positive? ? @scan.update(-16) : @scan.update(16)
  end

  def draw
    super
    @scan.draw if scanning?
  end

  def known?
    @known
  end

  def scanning?
    @scanning
  end

  def network
    @map.players.select(&:known?).sort_by(&:x)
  end

  def network_size
    @map.players.select(&:known?).size
  end

  def action
    neighbour = @map.actors.find { |e| e.near?(self) }
    if neighbour.nil? && !scanning?
      start_scan
      self.scanning = true
    end
    add_to_network!(neighbour) if neighbour.class == Player
    mark_the_target! neighbour if neighbour.class == Target
  end

  private

  def start_scan
    @scan = Scan.new(self, @map.marked_targets_x, x, y + 128)
  end

  def mark_the_target!(target)
    return if target.marked?

    target.marked = true
  end

  def add_to_network!(player)
    return if player.known?

    player.known = true
  end

  def would_fit?(offs_x)
    !@map.solid?(x + offs_x, y)
  end
end
