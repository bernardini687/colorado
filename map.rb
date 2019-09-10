class Map
  attr_reader :width, :height, :targets

  def initialize(level)
    @tileset =
      Gosu::Image.load_tiles(
        'media/tileset.png', Tiles::SIZE, Tiles::SIZE, tileable: true
      )

    @targets = []

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
          when 'e'
            @targets << Target.new(self, x * 64 + 32, y * 64 + 32)
            nil
          end
        end
      end
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        @tileset[tile].draw(x * Tiles::SIZE, y * Tiles::SIZE, 0) if tile
      end
    end
    @targets.each(&:draw)
  end

  # solid at a given pixel position?
  def solid?(x, y)
    @tiles[x / Tiles::SIZE][y / Tiles::SIZE]
  end
end
