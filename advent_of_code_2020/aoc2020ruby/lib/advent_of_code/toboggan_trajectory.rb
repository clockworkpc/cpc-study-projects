module AdventOfCode
  class TobogganTrajectory
    def itinerary(moves:, down:, right:)
      x, y = [0, 0]
      itin = [{ x: x, y: y }]

      moves.times do
        x += right
        y += down
        itin << { x: x, y: y }
      end
      
      itin
    end

    def plotted_cells(lines:, moves:, down:, right:)
      itin = itinerary(moves: moves, down: down, right: right)
      width = lines.first.strip.length

      cell = lambda do |hsh|
        row = lines[hsh[:y]]
        first_leg = hsh[:x] <= width - 1
        cell_index = first_leg ? hsh[:x] : hsh[:x] % width
        row[cell_index]
      end

      itin.each_with_object([]) do |hsh, ary|
        ary << cell.call(hsh)
      end
    end

    def journey_cells(lines:, down:, right:)
      quotient = (lines.count.to_f / down).to_i
      moves = down > 1 ? quotient : quotient - 1

      cells = plotted_cells(lines: lines, moves: moves, down: down, right: right)
      trees = cells.count { |cell| cell.eql?('#') }

      {
        cells: cells,
        trees: trees
      }
    end

    def tree_count_product(lines:, journeys:)
      trees_ary = journeys.each_with_object([]) do |journey, ary|
        jc = journey_cells(lines: lines, down: journey[:down], right: journey[:right])
        ary << jc[:trees]
      end

      trees_ary.inject(&:*)
    end
  end
end
