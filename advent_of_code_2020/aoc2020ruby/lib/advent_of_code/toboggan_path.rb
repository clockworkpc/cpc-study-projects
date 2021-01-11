module AdventOfCode
  class TobogganPath
    attr_accessor :map, :position, :status_log
    def initialize(lines)
      @map = lines
      @position = { x: 0, y: 0 }
      @status_log = [{ position: { x: 0, y: 0 }, status: :open }]
    end

    def current_map
      {
        height: @map.count,
        width: @map.first.length,
        map: @map
      }
    end

    def current_position
      x = @position[:x]
      y = @position[:y]
      { x: x, y: y }
    end

    def move(up: nil, down: nil, left: nil, right: nil)
      x = right || (left * -1)
      y = (down * -1) || up
      @position[:x] += x
      @position[:y] += y
      new_x = @position[:x]
      new_y = @position[:y]
      @status_log << { position: { x: new_x, y: new_y }, status: status_at_current_position }
      pp @status_log
    end

    def travel(moves:, up: nil, down: nil, left: nil, right: nil)
      pp @status_log
      moves.times { move(up: up, down: down, left: left, right: right) }
    end

    def move_straight_to_bottom(up: nil, down: nil, left: nil, right: nil)
      (@map.count - 1).times do
        x = right || (left * -1)
        y = (down * -1) || up
        move(x: x, y: y)
      end
    end

    def status_at_location(x:, y:)
      location_row = @map[y.abs]
      current_square = location_row[x]

      case current_square
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
