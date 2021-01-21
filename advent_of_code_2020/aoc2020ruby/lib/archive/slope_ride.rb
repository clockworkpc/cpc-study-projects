module AdventOfCode
  class SlopeRide
    def initialize(lines)
      @initial_lines = lines
      @initial_position = { x: 0, y: 0 }
      @initial_log = { open: 1, trees: 0 }
    end

    def marker(cell)
      hsh = {
        '.' => 'O',
        '#' => 'X'
      }

      hsh.keys.include?(cell) ? hsh[cell] : cell
    end

    # rubocop:disable Metrics/ParameterLists
    # rubocop:disable Naming/MethodParameterName
    def add_cell_to_matrix(matrix, key, cell, x, y, position)
      current_position = (x == position[:x] && y == position[:y])
      hsh = { x: x, y: y, value: cell }
      hsh[:marker] = marker(cell) if current_position
      matrix[key] << hsh
    end
    # rubocop:enable Metrics/ParameterLists
    # rubocop:enable Naming/MethodParameterName

    def generate_matrix_from_lines(lines:, position:)
      matrix = {}

      lines.each_with_index do |line, y|
        key = "row#{y}".to_sym
        matrix[key] = []
        line.split('').each_with_index do |cell, x|
          add_cell_to_matrix(matrix, key, cell, x, y, position)
        end
      end

      matrix
    end

    def initial_matrix
      generate_matrix_from_lines(lines: @initial_lines,
                                 position: @initial_position)
    end

    def matrix
      @matrix ||= initial_matrix
    end

    def current_position
      @position ||= @initial_position
    end

    def cell_at_position(x:, y:)
      row = matrix.values.find do |ary|
        ary.find { |hsh| hsh[:x] == x && hsh[:y] == y }
      end

      row.find { |hsh| hsh[:x] == x && hsh[:y] == y }
    end

    def cell_at_current_position
      cell_at_position(current_position)
    end

    def draw_map(matrix)
      matrix.values.map do |ary|
        ary.map { |hsh| hsh[:marker] || hsh[:value] }.join
      end.join("\n")
    end

    def draw_current_map
      draw_map(matrix)
    end

    def expand_row_left(row, initial_row, int) # rubocop:disable Metrics/MethodLength
      expanded = row.map(&:dup)
      new_x = row.first[:x] - 1

      expand_left = lambda do
        initial_row.map(&:dup).reverse.each do |hsh|
          hsh[:x] = new_x
          expanded.unshift(hsh)
          new_x -= 1
        end
      end

      int.times { expand_left.call }
      expanded
    end

    def expand_row_right(row, initial_row, int) # rubocop:disable Metrics/MethodLength
      expanded = row.map(&:dup)
      new_x = row.last[:x] + 1

      expand_right = lambda do
        initial_row.map(&:dup).each do |hsh|
          hsh[:x] = new_x
          expanded << hsh
          new_x += 1
        end
      end

      puts 'EXPANDING...'
      int.times { expand_right.call }
      expanded
    end

    def expand_row(direction:, row:, int:)
      initial_row = initial_matrix.values.find { |r| r.first[:y] == row.first[:y] }
      marker_row = initial_row.find { |hsh| hsh[:marker] }
      marker_row&.delete(:marker)

      send("expand_row_#{direction}", row, initial_row, int)
    end

    def expand_matrix(matrix:, direction:, int:)
      new_matrix = {}
      matrix.each do |key, row|
        new_matrix[key] = []
        new_row = send('expand_row', { direction: direction, row: row, int: int })
        new_matrix[key] = new_row
      end
      new_matrix
    end

    def expand_current_matrix(direction)
      initial_width = @initial_lines.map(&:length).max
      int = (current_position[:x].abs + 1) / initial_width
      puts "INT = #{int}"
      @matrix = expand_matrix(matrix: matrix, direction: direction, int: int)
    end

    def matrix_boundaries # rubocop:disable Metrics/AbcSize
      min_value = ->(k) { matrix.values.map { |ary| ary.map { |hsh| hsh[k] } }.min.min }
      max_value = ->(k) { matrix.values.map { |ary| ary.map { |hsh| hsh[k] } }.max.max }

      {
        min_x: min_value[:x],
        max_x: max_value[:x],
        min_y: min_value[:y],
        max_y: max_value[:y]
      }
    end

    def update_current_position(x:, y:)
      current_position[:x] += x
      current_position[:y] += y

      if current_position[:x] > matrix_boundaries[:max_x]
        puts 'EXPAND RIGHT'
        expand_current_matrix(:right)
      elsif current_position[:x] < matrix_boundaries[:min_x]
        puts 'EXPAND LEFT'
        expand_current_matrix(:left)
      end
    end

    def log
      @log ||= @initial_log
    end

    def update_log(marker)
      log[:open] += 1 if marker.eql?('O')
      log[:trees] += 1 if marker.eql?('X')
      log[:total] = log[:open] + log[:trees]
    end

    def move(down:, right: nil, left: nil)
      matrix
      x = right || (left * -1)
      update_current_position(x: x, y: down)
      marker = marker(cell_at_current_position[:value])
      cell = cell_at_current_position[:marker] = marker
      update_log(marker)
      pp cell
      pp log
    end

    def travel(int:, down:, right: nil, left: nil)
      int.times { move(down: down, right: right, left: left) }
    end

    def journey(down:, right: nil, left: nil)
      int = matrix.count - 1
      travel(int: int, down: down, right: right, left: left)
    end

    # def travel(right: nil, down: nil, left: nil)
    #   (matrix.count - 1).times do
    #     move(right: right, down: down, left: left)
    #   end
    # end

    # def call
    #   matrix = generate_matrix_from_lines(lines: @initial_lines,
    #                                       position: @initial_position)
    # end
  end
end
