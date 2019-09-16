class Countdown
  attr_reader :end, :target

  def initialize(start, target)
    @start = start + 6000
    @target = target
  end

  def update
    @ended = log.negative?
  end

  def log
    increment = Gosu.milliseconds
    (@start - increment) / 1000
  end

  def ended?
    @ended
  end
end
