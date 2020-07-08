module GameOfLife
  class World
    def initialize(size)
      @size = size
    end

    def odd_value_range
      calc = ->(a) { (@size / 2) * a }
      first = calc.call(-1)
      last = calc.call(1)
      (first..last).to_a
    end

    def even_value_range
      calc = ->(a, b) { ((@size / 2) + a) * b }
      first = calc.call(-1, -1)
      last = calc.call(0, 1)
      (first..last).to_a
    end

    def range
      @range ||= @size.odd? ? odd_value_range : even_value_range
    end

    def create_empty_grid
      grid = []

      range.reverse_each do |y|
        range.each do |x|
          grid << { x: x, y: y, life: false }
        end
      end
      @grid = grid
    end

    def populate_grid(*coordinates)
      coordinates.flatten(1).each do |xy|
        x, y = xy
        cell = find_cell(x, y)
        cell[:life] = true
      end
    end

    def create_grid
      create_empty_grid
      populate_grid(*coordinates)
    end

    def grid
      @grid ||= create_grid
    end

    def relative_position_to_cell(cell, neighbour)
      direction = ->(a, b, k, n) { a[k] == b[k] + n }

      north = 'north' if direction.call(cell, neighbour, :y, 1)
      south = 'south' if direction.call(cell, neighbour, :y, -1)
      east = 'east' if direction.call(cell, neighbour, :x, 1)
      west = 'west' if direction.call(cell, neighbour, :x, -1)

      [north, south, east, west].compact.join('_').to_sym
    end

    def find_cell(x, y)
      @grid.find { |hsh| hsh[:x] == x && hsh[:y] == y }
    end

    def neighbouring_coordinates(cell)
      x, y = [cell[:x], cell[:y]]
      {
        north_west: [x - 1, y + 1],
        north: [x, y + 1],
        north_east: [x + 1, y + 1],
        west: [x - 1, y],
        east: [x + 1, y],
        south_west: [x - 1, y - 1],
        south: [x, y - 1],
        south_east: [x + 1, y - 1]
      }
    end

    def adjacent_cells(cell)
      neighbouring_coordinates(cell)
        .values.map { |v| find_cell(v[0], v[1]) }.compact
    end

    def neighbours(cell)
      adjacent_cells(cell).select { |c| c[:life] }
    end

    def populated_status(cell)
      count = neighbours(cell).count

      lonely = :lonely if count < 2
      happy = :happy if (2..3).include?(count)
      crowded = :crowded if count >= 4

      [lonely, happy, crowded].compact.join.to_sym
    end

    def empty_status(cell)
      count = neighbours(cell).count
      count == 3 ? :fertile : :dead
    end

    def current_status(x, y)
      cell = find_cell(x, y)
      status = cell[:life] ? populated_status(cell) : empty_status(cell)
    end

    def future_status(x, y)
      :dead
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def report_today
      table = {}
      key_index = 0
      column_key = ->(i) { i >= @size ? i % @size : i }

      grid.each_with_index do |cell, i|
        key_index = (i / @size) if (i % @size).zero?
        row = "row#{key_index}".to_sym
        table[row] ||= {}
        column = "col#{column_key.call(i)}".to_sym
        table[row][column] = current_status(cell[:x], cell[:y])
      end

      table
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def toggle(x, y)
      cell = find_cell(x, y)
      cell[:life] = cell[:life] != true
      cell
    end

    def draw_grid
      # TODO
    end
  end
end
