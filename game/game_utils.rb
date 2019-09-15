module GameUtils
  private

  def counters
    "network: #{@cat.network_size}\n"\
    "marks: #{@world.marks.size}"
  end

  def filtered_actors
    @world.actors.reject { |a| [@cat, @neighbour].include? a }
  end
end
