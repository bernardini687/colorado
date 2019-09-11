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
    @map.players.select(&:known?)
  end

  private

  def would_fit?(offs_x)
    !@map.solid?(@x + offs_x, @y)
  end
end
