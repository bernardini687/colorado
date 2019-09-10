class Map
  attr_reader :width, :height

  def initialize(level)
    @tileset =
      Gosu::Image.load_tiles('media/tileset.png', 64, 64, tileable: true)

    lines = File.readlines(level).map(&:chomp)
    @height = lines.size
    @width = lines.first.size

    @tiles =
      Array.new @width do |x|
        Array.new @height do |y|
          case lines[y][x]
          when 'x' then Tiles::BLACK
          when '^' then Tiles::GREEN
          when '-' then Tiles::WHITE
          end
        end
      end
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        @tileset[tile].draw(x * 64, y * 64, 0) if tile
      end
    end
  end

  # solid at a given pixel position?
  def solid?(x, y)
    y.negative? || @tiles[x / 64][y / 64]
  end
end
