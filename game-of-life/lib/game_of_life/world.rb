module GameOfLife
  class World
    attr_reader :grid

    def initialize(size)
      @size = size
    end

    def create_empty_grid
      grid = []
      @size.times do |y|
        @size.times do |x|
          grid << { x: x, y: y, life: false }
        end
      end
      @grid = grid
    end

    def grid
      @grid ||= create_grid
    end

    def relative_position(cell, neighbour)
      north_of = ->(a, b) { a[:y] == (b[:y] - 1) }
      south_of = ->(a, b) { a[:y] == (b[:y] + 1) }
      west_of = ->(a, b) { a[:x] == (b[:x] - 1) }
      east_of = ->(a, b) { a[:x] == (b[:x] + 1) }

      north = 'north' if north_of.call(cell, neighbour)
      south = 'south' if south_of.call(cell, neighbour)
      east = 'east' if east_of.call(cell, neighbour)
      west = 'west' if west_of.call(cell, neighbour)

      [north, south, east, west].compact.join('_').to_sym
    end

    def status(_x, _y)
      :dead
    end

    def report
      @grid.map do |hsh|
        key = ['cell', hsh[:x], hsh[:y]].join('_').to_sym
        status = status(hsh[:x], hsh[:y])
        [key, status]
      end.to_h
    end

    def cell(x, y)
      @grid.find { |hsh| hsh[:x] == x && hsh[:y] == y }
    end

    def toggle(x, y)
      cell = cell(x, y)
      cell[:life] = cell[:life] != true
      cell
    end
  end
end
