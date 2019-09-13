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
    puts 'scan!' if neighbour.nil?
    add_to_network!(neighbour) if neighbour.class == Player
    mark_as_target!(neighbour) if neighbour.class == Target
  end

  private

  def mark_as_target!(target)
    puts target
  end

  def add_to_network!(player)
    return if player.known?

    player.known = true
  end

  def would_fit?(offs_x)
    !@map.solid?(x + offs_x, y)
  end
end
