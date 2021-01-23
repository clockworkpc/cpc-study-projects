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
           .sort_by { |t| [t[:row], t[:column]] }
    end

    def highest_seat_id(text)
      boarding_passes(text).map { |bp| bp[:seat_id] }.max
    end

    def missing_seat(text)
      bp = boarding_passes(text)
      not_found = ->(n) { bp.find { |pass| pass[:seat_id] == n }.nil? }
      ary = (bp.first[:seat_id]..bp.last[:seat_id]).to_a
      missing_id = ary.find { |n| n if not_found[n] }

      before = bp.find { |pass| pass[:seat_id] == missing_id - 1 }
      after = bp.find { |pass| pass[:seat_id] == missing_id + 1 }

      {
        row: before[:row],
        column: before[:column] + 1,
        seat_id: before[:seat_id] + 1
      }
    end
  end
end
