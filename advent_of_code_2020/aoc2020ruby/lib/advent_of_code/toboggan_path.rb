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

    def expand_map(map_ary:, direction:, int:)
      additions = ->(line) { Array.new(int) { line }.join }
      res = if direction == :right
              map_ary.map { |line| line + additions[line] }
            elsif direction == :left
              map_ary.map { |line| additions[line] + line }
      end
      res
    end

    def expand_current_map(direction:, int:)
      expanded_map = expand_map(map_ary: @map, direction: direction, int: int)
      @map = expanded_map
    end

    def approaching_edge?(map_ary:, right: nil, left: nil)
      new_y = current_position[:y].abs + (right || left).abs
      current_map[:width] <= new_y
    end

    def move(up: nil, down: nil, left: nil, right: nil)
      if approaching_edge?(map_ary: @map, right: right, left: left)
        direction = right ? :right : :left
        expand_current_map(direction: direction, int: 1)
      end
      x = right || (left * -1)
      y = (down * -1) || up
      @position[:x] += x
      @position[:y] += y
      new_x = @position[:x]
      new_y = @position[:y]
      @status_log << { position: { x: new_x, y: new_y }, status: status_at_current_position }
    end

    def travel(moves:, up: nil, down: nil, left: nil, right: nil)
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
  end
end
