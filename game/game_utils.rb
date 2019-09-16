module GameUtils
  private

  def action?
    return false unless @neighbour

    !(@neighbour.marked_human? || @neighbour.known_cat?)
  end

  def valid_neighbours?
    return false if @neighbours.empty?

    @neighbours.select(&:marked_human?).size == 1 &&
      @neighbours.select(&:known_cat?).size.positive? # don't count current cat
  end

  def counters
    "network: #{@cat.network_size}\n"\
    "marks: #{@world.marks.size}"
  end

  def filtered_actors
    if @actionable
      @world.actors - [@cat, @neighbour]
    elsif @abductable
      @world.actors - [@cat, *@neighbours]
    else
      @world.actors.reject { |actor| actor == @cat }
    end
  end
end
