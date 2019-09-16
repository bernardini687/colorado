module GameActions
  def button_down(key)
    case key
    when Gosu::KB_ESCAPE then close
    when Gosu::KB_A      then @cat.dispatch_action
    when Gosu::KB_F      then @cat.abduction_request if @abductable
    when Gosu::KB_DOWN   then @cat = next_cat to: :left
    when Gosu::KB_J      then @cat = next_cat to: :left
    when Gosu::KB_UP     then @cat = next_cat to: :right
    when Gosu::KB_K      then @cat = next_cat to: :right
    else super
    end
  end

  private

  # network is sorted by x axis
  # select the nearest neighbour to the given direction
  def next_cat(to:)
    return @cat if @cat.scanning?

    current = @cat.network.index @cat

    if to == :left
      current.zero?                   ? @cat : @cat.network[current.pred]
    else
      current + 2 > @cat.network_size ? @cat : @cat.network[current.succ]
    end
  end
end
