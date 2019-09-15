require_relative 'cat_utils'
require_relative 'cat_actions'

class Cat < Actor
  attr_writer :known

  def initialize(world, x, y)
    super(world, x, y)

    @known = false
    @scanning = [false, false]

    @img = Gosu::Image.new 'media/cat.png'
  end

  def update(move_x)
    move_x.positive? && move_x.times    { @x += 1 if would_fit?(32) }
    move_x.negative? && (-move_x).times { @x -= 1 if would_fit?(-1) }

    return unless scanning?

    @lscan.response? ? @lscan.update(16)  : @lscan.update(-16)
    @rscan.response? ? @rscan.update(-16) : @rscan.update(16)
  end

  def draw
    known? ? super : @img.draw(x, y, 1, 1, 1, @darker, :add)

    return unless scanning?

    @lscan.draw
    @rscan.draw
  end

  include CatUtils
  include CatActions
end
