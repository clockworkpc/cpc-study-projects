module AdventOfCode
  class TobogganPath
    attr_accessor :map, :position, :status_log

    def initialize(lines)
      @original_map = lines

      @map_dimensions = {
        left: 0,
        right: lines.first.length,
        top: 0,
        bottom: lines.count
      }

      @map = lines

      @position = { x: 0, y: 0 }
      @status_log = [{ position: { x: 0, y: 0 }, status: :open }]
    end

    def current_map
      {
        height: @map.bottom - @map.top,
        width: @map.right - @map.left,
        map: @map
      }
    end

    def current_position
      x = @position[:x]
      y = @position[:y]
      { x: x, y: y }
    end

    def expand_row(direction, row, i)
      if direction == :right
        row + @original_map[i]
      elsif direction == :left
        @original_map[i] + row
      end
    end

    def update_map_dimensions(**kwargs)
      update_value = ->(k, v) { @map_dimensions[k] += v }
      kwargs.each {|k,v| update_value.call(k, v)}
      # update_value[:left, left]
      # update_value[:right, right]
      # update_value[:top, top]
      # update_value[:bottom, bottom]
    end

    def expand_map(map_ary:, direction:, int:)
      new_map = []
      expand_row = lambda do |direction, row, i|
      end

      if direction == :right
        map_ary.each_with_index { |row, i| new_map << row + @original_map[i] }

        each_with_object
        map_ary.map { |line| line + additions[line] }
      elsif direction == :left
        map_ary.map { |line| additions[line] + line }
      end

      new_map
    end

    def expand_current_map(direction:, int:)
      expanded_map = expand_map(map_ary: @map, direction: direction, int: int)
      update_map_dimensions({ direction => } )
      @map = expanded_map
    end

    def approaching_edge?(map_ary:, right: nil, left: nil)
      new_x = current_position[:x].abs + (right || left).abs
      current_map[:width] - 1 <= new_x
    end

    def expansion_factor(x)
      post_move_x = current_position[:x] + x
      post_move_x / current_map[:width]
    end

    def move(up: nil, down: nil, left: nil, right: nil)
      if approaching_edge?(map_ary: @map, right: right, left: left)
        direction = right ? :right : :left
        int = expansion_factor((right || left).abs)
        expand_current_map(direction: direction, int: int) unless int <= 0
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

    def travel_all_the_way(up: nil, down: nil, left: nil, right: nil)
      (@map.count - 1).times do
        move(right: right, down: down, left: left, up: up)
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
