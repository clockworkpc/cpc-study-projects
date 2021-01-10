module AdventOfCode
  class TobogganPath
    attr_accessor :map, :position, :status_log
    def initialize(lines)
      @map = lines
      @position = { x: 0, y: 0 }
      @status_log = [{ position: @position, status: :open }]
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

    def move(up: nil, down: nil, left: nil, right: nil)
      x = right || (left * -1)
      y = (down * -1) || up
      @position[:x] += x
      @position[:y] += y
      current_position
    end

    def travel(moves:, up: nil, down: nil, left: nil, right: nil)
      require 'pry'; binding.pry
      moves.times do
        move(up: up, down: down, left: left, right: right)
        @status_log << { position: @position, status: status_at_current_position }
        require 'pry'; binding.pry
      end
    end

    def move_straight_to_bottom(up: nil, down: nil, left: nil, right: nil)
      (@map.count - 1).times do
        x = right || (left * -1)
        y = (down * -1) || up
        move(x: x, y: y)
      end
    end

    def status_at_location(x:, y:)
      location_row = @map[y]

      case location_row[x]
      when '.'
        :open
      when '#'
        :tree
      end
    end

    def status_at_current_position
      status_at_location(x: current_position[:x], y: current_position[:y])
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
