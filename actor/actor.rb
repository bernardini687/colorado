require_relative 'actor_utils'

class Actor
  attr_reader :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y
  end

  def draw
    @img.draw(x, y, 1)
  end

  def glow
    @glow.draw(x, y, 2)
  end

  include ActorUtils
end
