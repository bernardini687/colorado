class Map
  attr_reader :width, :height, :targets, :players

  def initialize(level)
    @tileset =
      Gosu::Image.load_tiles('media/tileset.png', 64, 64, tileable: true)

    @targets = []
    @players = []

    lines = File.readlines(level).map(&:chomp)
    @width = lines.first.size
    @height = lines.size

    @tiles =
      Array.new @width do |x|
        Array.new @height do |y|
          case lines[y][x]
          when 'x' then Tiles::EMPTY
          when '^' then Tiles::FIELD
          when '-' then Tiles::HOUSE
          when 'h'
            @targets << Target.new(self, x * 64, y * 64)
            nil
          when 'c'
            @players << Player.new(self, x * 64, y * 64 + 48)
            nil
          end
        end
      end

    @players.sample.known = true
  end

  def draw
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        @tileset[tile].draw(x * 64, y * 64, 0) if tile
      end
    end
    @targets.each(&:draw)
    @players.each(&:draw)
  end

  def network
    @players.select(&:known?)
  end

  # solid at a given pixel position?
  def solid?(x, y)
    @tiles[x / 64][y / 64]
  end
end
