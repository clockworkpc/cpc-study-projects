module AdventOfCode
  class TobogganPath
    def map(lines)
      ratio = lines.count / lines.first.length

      expanded_map = lines.map { |line| Array.new(ratio) { line }.join }
      require 'pry'; binding.pry
    end
  end
end
