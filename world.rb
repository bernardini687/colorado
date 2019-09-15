class World
  attr_reader :width, :height, :cats

  def initialize(level)
    @tileset =
      Gosu::Image.load_tiles('media/tileset.png', 64, 64, tileable: true)

    @humans = []
    @cats = []

    lines = File.readlines(level).map(&:chomp)
    @width = lines[0].size
    @height = lines.size

    @tiles =
      Array.new @width do |x|
        Array.new @height do |y|
          case lines[y][x]
          when 'x' then Tiles::EMPTY
          when '^' then Tiles::FIELD
          when '-' then Tiles::HOUSE
          when 'h' then cast(Human, x, y)
          when 'c' then cast(Cat, x, y)
          end
        end
      end

    @cats.sample.known = true
  end

  def draw
    height.times do |y|
      width.times do |x|
        tile = @tiles[x][y]
        tile && @tileset[tile].draw(x * 64, y * 64, 0)
      end
    end
    @humans.each(&:draw)
    cats.each(&:draw)
  end

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
