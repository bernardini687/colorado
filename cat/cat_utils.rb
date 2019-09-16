module CatUtils
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

  # public filters

  def network
    @world.cats.select(&:known?).sort_by(&:x)
  end

  def network_size
    @world.cats.select(&:known?).size
  end

  def find_neighbour
    @world.actors.find { |a| a.near? self }
  end

  def find_neighbours
    @world.actors.select { |a| a.near?(self, 256) }
  end

  def find_target
    find_neighbours.find(&:marked_human?)
  end

  private

  def would_fit?(offs_x)
    !@world.solid?(x + offs_x, y)
  end
end
