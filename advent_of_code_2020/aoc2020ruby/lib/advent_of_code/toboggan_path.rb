module AdventOfCode
  class TobogganPath
    def initialize(lines)
      @map = lines
      @position = [0, 0]
    end

    def current_map
      {
        height: @map.count,
        width: @map.first.length,
        map: @map
      }
    end

    def current_position
      @position
    end

    def move(x:, y:)
      @position[0] += x
      @position[1] += y
      current_position
    end

    def expand_map(lines:, direction:, int:)
      additions = ->(line) { Array.new(int) { line }.join }
      if direction == :right
        lines.map { |line| line + additions[line] }
      elsif direction == :left
        lines.map { |line| additions[line] + line }
      end
    end

    def expand_current_map(direction:, int:)
      expand_map(map: @map, direction: direction, int: int)
    end
  end
end
