require 'set'
module AdventOfCode
  class HandyHaversacksAlt
    def parse_line(line)
      m = line.match(/(.*) bags contain (.*)/)

      require 'pry'; binding.pry

      parent = m[1]
      contents = m[2].split(', ').map do |bag|
        (m2 = bag.match(/(\d+) (.*) bag.*/)) ? { m2[2] => m2[1].to_i } : {}
      end

      children = contents.inject({}, :merge)

      { parent => children }
    end

    def parse_rules(text)
      text.strip.split("\n\n").map do |l|
        l.split("\n").map do |s|
          s.chars.to_set
        end
      end
    end

    def call(text:)
      input = parse_rules(text)
      res = input.map do |sl|
        x = sl.reduce(:|)
        pp x
        c = x.count
        pp c
      end
      pp res
      res.sum
    end
  end
end
