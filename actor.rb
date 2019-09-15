require_relative 'actor_utils'

class Actor
  attr_reader :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y

    @darker = Gosu::Color.rgba(255, 255, 255, 159)
  end

  def draw
    @img.draw(x, y, 1)
  end

  include ActorUtils
end
