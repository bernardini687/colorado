module ActorUtils
  def near?(actor, distance)
    return false if actor == self # only care for other actors

    Gosu.distance(x, y, actor.x, actor.y) < distance
  end

  def marked_human?
    human? && marked?
  end

  def known_cat?
    cat? && known?
  end

  def human?
    self.class == Human
  end

  def cat?
    self.class == Cat
  end
end
