module AdventOfCode
  class BinaryBoarding
    def median_left(ary)
      if ary[0].zero?
        (ary[-1].to_f / 2).to_i
      else
        diff = (ary[-1] + 1) - ary[0]
        (ary[0] + (diff / 2)) - 1
      end
    end

    def median_right(ary)
      median_left(ary) + 1
    end

    def binary_parse(ary, substring, upper_key, lower_key)
      lower = -> { (ary[0]..median_left(ary)).to_a }
      upper = -> { (median_right(ary)..ary[-1]).to_a }

      substring.split('').each do |c|
        ary = upper.call if c.eql?(upper_key)
        ary = lower.call if c.eql?(lower_key)
      end

      ary.first
    end

    def row(str)
      ary = (0..127).to_a
      substring = str[0..6]
      upper_key = 'B'
      lower_key = 'F'
      binary_parse(ary, substring, upper_key, lower_key)
    end

    def column(str)
      ary = (0..7).to_a
      substring = str[7..-1]
      upper_key = 'R'
      lower_key = 'L'
      binary_parse(ary, substring, upper_key, lower_key)
    end

    def seat_id(str)
      (row(str) * 8) + column(str)
    end

    def boarding_pass(str)
      {
        row: row(str),
        column: column(str),
        seat_id: seat_id(str)
      }
    end

    def boarding_passes(text)
      lines = text.split("\n")
      lines.map { |str| boarding_pass(str) }
    end

    def highest_seat_id(text)
      boarding_passes(text).map { |bp| bp[:seat_id] }.max
    end
  end
end
