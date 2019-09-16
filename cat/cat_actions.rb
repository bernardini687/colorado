module CatActions
  def dispatch_action
    neighbour = find_neighbour
    case neighbour
    when NilClass then start_scan
    when Human    then mark! neighbour
    when Cat      then know! neighbour
    end
  end

  def abduction_request
    if valid_neighbours?
      msg = 'go ahead!'
      target = find_target
    else
      msg = 'not there yet!'
    end
    p msg, target&.seen? # <<<<<<
  end

  private

  def start_scan
    return if scanning?

    @scanning = [true, true]
    @lscan =  LeftScan.new(self, @world.marks_x, x, y + 128)
    @rscan = RightScan.new(self, @world.marks_x, x, y + 128)
  end

  def mark!(human)
    human.marked = true unless human.marked?
  end

  def know!(cat)
    cat.known = true unless cat.known?
  end
end
