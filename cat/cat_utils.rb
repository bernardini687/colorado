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

  def special_action?
    neighbour = find_neighbour
    return false unless neighbour

    !(neighbour.marked_human? || neighbour.known_cat?)
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

  private

  def would_fit?(offs_x)
    !@world.solid?(x + offs_x, y)
  end

  def valid_neighbours?
    neighbours = @world.actors.select { |a| a.near?(self, 256) }

    neighbours.select(&:marked_human?).size == 1 &&
      neighbours.select(&:known_cat?).size.positive? # current cat doesn't count
  end
end
