module WorldUtils
  # solid at a given pixel position?
  def solid?(x, y)
    @tiles[x / 64][y / 64]
  end

  def actors
    @actors ||= @humans + cats
  end

  def marks
    @humans.select(&:marked?)
  end

  def marks_x
    marks.map(&:x)
  end

  private

  def cast(actor, x, y)
    actors = instance_variable_get("@#{actor.to_s.downcase}s")
    actors << actor.new(self, x * 64, y * 64)
    nil
  end
end
