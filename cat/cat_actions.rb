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
    target = find_target
    if target.nil?
      puts 'no marked human within range!'
    elsif target.seen?
      puts "you've been spotted!"
    else
      puts 'trying to abduct!'
      target.abduct!
    end
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
