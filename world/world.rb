require_relative 'world_utils'

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

  include WorldUtils
end
