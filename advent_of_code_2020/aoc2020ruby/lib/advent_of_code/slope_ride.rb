module AdventOfCode
  class SlopeRide
    attr_reader :matrix

    def initialize(lines)
      @initial_lines = lines
      @initial_position = { x: 0, y: 0 }
    end

    def marker(cell)
      case cell
      when '.'
        'O'
      when '#'
        'X'
      else
        cell
      end
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

    # def expand_row_left(row, initial_row)
    #   expanded = row.map(&:dup)
    #   new_x = row.first[:x] - 1

    #     initial_row.map(&:dup).reverse.each do |hsh|
    #       hsh[:x] = new_x
    #       expanded.unshift(hsh)
    #       new_x -= 1
    #     end

    #     expanded
    # end

    # def expand_row( direction:, row:, initial_row:, int:)
    #   case direction
    # end

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

    def expand_row(direction:, row:, int:)
      initial_row = initial_matrix.values.find { |r| r == row }
      marker_row = initial_row.find { |hsh| hsh[:marker] }
      marker_row&.delete(:marker)

      send("expand_row_#{direction}", row, initial_row, int)
    end

    def expand_matrix(matrix:, direction:, int:)
      new_matrix = {}
      matrix.each do |key, row|
        new_matrix[key] = []
        new_row = send('expand_row', direction: direction, row: row, int: int)
        new_matrix[key] = new_row
      end
      new_matrix
    end

    # def call
    #   matrix = generate_matrix_from_lines(lines: @initial_lines,
    #                                       position: @initial_position)
    # end
  end
end
