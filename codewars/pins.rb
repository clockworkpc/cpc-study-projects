module Codewars
  class Pins
    LAYOUT = {
      '0' => %w[0 8],
      '1' => %w[1 2 4],
      '2' => %w[1 2 3 5],
      '3' => %w[2 3 6],
      '4' => %w[1 4 5 7],
      '5' => %w[2 4 5 6 8],
      '6' => %w[3 5 6 9],
      '7' => %w[4 7 8],
      '8' => %w[5 7 8 9 0],
      '9' => %w[6 8 9]
    }

    def get_pins(observed)
      # res = observed.chars.map { |c| LAYOUT[c] }

      res = observed.chars.each_with_object([]) do |char, ary|
        ary << char
      end

      return res.flatten if res.count == 1

      require 'pry'; binding.pry
    end
  end
end
