class Human < Actor
  attr_writer :marked
  attr_reader :countdown

  def initialize(world, x, y)
    super(world, x, y)

    @marked = false

    @img  = Gosu::Image.new 'media/human.png'
    @glow = Gosu::Image.new 'media/glowing_human.png'
  end

  def update
    @seen = @world.humans.any? { |human| human.near?(self, 1024) }
  end

  def marked?
    @marked
  end

  def seen?
    @seen
  end

  def start_countdown
    @countdown ||= Countdown.new(Gosu.milliseconds, self)
  end

  def abduct!
    @world.humans.reject! { |human| human == self }
    reset!
  end

  def reset!
    @countdown = nil
    puts "countdown killed: #{countdown.nil?}"
  end
end
