require 'rainbow'

module GameOfLife
  class World
    attr_reader :size
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
      @grid ||= create_empty_grid
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

    def future_status(cell)
      x, y = [cell[:x], cell[:y]]
      current = current_status(x, y)
      neighbours = neighbours(cell)

      if current == :dead && neighbours.count != 3
        :dead
      elsif current == :crowded
        :dead
      elsif current == :happy
        :alive
      elsif current == :fertile
        :alive
      end
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

    def report_tomorrow
      table = {}
      key_index = 0
      column_key = ->(i) { i >= @size ? i % @size : i }

      grid.each_with_index do |cell, i|
        key_index = (i / @size) if (i % @size).zero?
        row = "row#{key_index}".to_sym
        table[row] ||= {}
        column = "col#{column_key.call(i)}".to_sym
        table[row][column] = future_status(cell)
      end

      table
    end

    def horizontal_border
      body = Array.new(@size) { '---' }.join('|')
      ['|', body, '|'].join + "\n"
    end

    def draw_row(columns)
      body = columns.map do |_k, v|
        empty = %i[dead fertile].include?(v)
        empty ? '   ' : ' x '
      end.join('|')

      ['|', body, '|'].join + "\n"
    end

    def draw_grid
      drawing = horizontal_border
      report_today.each do |_k, columns|
        row = draw_row(columns)
        drawing += row
        drawing += horizontal_border
      end
      drawing
    end

    def toggle_cell(x, y)
      cell = find_cell(x, y)
      cell[:life] = cell[:life] != true
      cell
    end

    def toggle_grid
      y = range.last + 1

      report_tomorrow.values.each do |hsh|
        y -= 1
        x = range.first - 1
        hsh.values.each do |status|
          x += 1
          cell = find_cell(x, y)
          death = cell[:life] && status == :dead
          rebirth = !cell[:life] && status == :alive
          toggle_cell(x, y) if death || rebirth
        end
      end
    end

    def seed_grid(n)
      cells = grid.sample(n)
      cells.each { |c| c[:life] = true }
    end

    def population
      grid.find_all { |c| c[:life] }.count
    end
  end
end
