class Player < Actor
  attr_writer :known

  def initialize(map, x, y)
    super(map, x, y)

    @known = false

    @img = Gosu::Image.new 'media/player.png'
  end

  def update(move_x)
    move_x.positive? && move_x.times    { @x += 1 if would_fit?(32) }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }

    return unless @scan

    @scan.positive? ? @scan.update(-16) : @scan.update(16)
  end

  def draw
    super
    @scan&.draw
  end

  def known?
    @known
  end

  def network
    @map.players.select(&:known?).sort_by(&:x)
  end

  def network_size
    @map.players.select(&:known?).size
  end

  def action
    neighbour = @map.actors.find { |e| e.near?(self) }
    scan_for_marked if neighbour.nil?
    add_to_network!(neighbour) if neighbour.class == Player
    mark_the_target! neighbour if neighbour.class == Target
  end

  private

  def scan_for_marked
    @scan = Scan.new(@map.marked_targets_x, x, y + 128)
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
