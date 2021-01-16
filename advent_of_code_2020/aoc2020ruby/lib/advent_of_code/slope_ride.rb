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

    def add_cell_to_matrix(matrix, key, cell, x, y, position) # rubocop:disable Metrics/ParameterLists
      current_position = (x == position[:x] && y == position[:y])
      hsh = { x: x, y: y, value: cell }
      hsh[:marker] = marker(cell) if current_position
      matrix[key] << hsh
    end

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

    def expand_row_left(row, int)
      expanded = []
      (int + 1).times { expanded << row }
      expanded.flatten!
      hsh_with_marker = row.find { |hsh| hsh[:marker] }
      index = expanded.index(hsh_with_marker)
      require 'pry'; binding.pry
      expanded[index].delete(:marker)
      expanded
    end

    def expand_matrix(matrix:, direction:, int:)
      new_matrix = {}
      matrix.each do |key, row|
        new_matrix[key] = []
        new_row = send("expand_row_#{direction}", row, int)
        new_matrix[key] = new_row
      end
      new_matrix
    end

    def call
      matrix = generate_matrix_from_lines(lines: @initial_lines,
                                          position: @initial_position)
    end
  end
end
