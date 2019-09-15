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

  def network
    @world.cats.select(&:known?).sort_by(&:x)
  end

  def network_size
    @world.cats.select(&:known?).size
  end

  private

  def would_fit?(offs_x)
    !@world.solid?(x + offs_x, y)
  end

  def valid_neighbours?
    neighbours = @world.actors.select { |sqr| sqr.near?(self, 256) }
    neighbours.select(&:marked_human?).size == 1 &&
      neighbours.select(&:known_cat?).size.positive? # current cat doesn't count
  end
end
