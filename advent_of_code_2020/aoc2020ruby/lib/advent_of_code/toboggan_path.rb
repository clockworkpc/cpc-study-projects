module AdventOfCode
  class TobogganPath
    def map(lines)
      ratio = lines.count / lines.first.length

      expanded_map = lines.map { |line| Array.new(ratio) { line }.join }
      require 'pry'; binding.pry
    end

    def expand_map(lines:, direction:, int:)
      additions = ->(line) { Array.new(int) { line }.join }
      if direction == :right
        lines.map { |line| line + additions[line] }
      elsif direction == :left
        lines.map { |line| additions[line] + line }
      end
    end
  end
end
