module AdventOfCode
  class HandyHaversacks
    def symbolize_colour(string)
      string.strip.sub(/\s/, '_').to_sym
    end

    def inner_bags_predicate(sentence)
      sentence.last.sub('.', '')
              .sub('bags', '')
              .sub('bag', '')
              .split(',').map(&:strip)
    end

    def inner_bag_key_value(inner_bag_str)
      key_str = inner_bag_str.scan(/[a-z]+\s[a-z]+/).first
      key = symbolize_colour(key_str)
      value = inner_bag_str.scan(/\d+/).first.to_i

      [key, value]
    end

    def inner_bags_hash(inner_bag_str_ary)
      inner_bag_str_ary.each_with_object({}) do |inner_bag_str, hsh|
        next if inner_bag_str.match?('no other')

        key, value = inner_bag_key_value(inner_bag_str)
        hsh[key] = value
      end
    end

    def rule(line)
      bag_hsh = {}
      sentence = line.split('bags contain')
      outer_bag_key = symbolize_colour(sentence.first)
      inner_bag_str_ary = inner_bags_predicate(sentence)
      bag_hsh[outer_bag_key] = inner_bags_hash(inner_bag_str_ary)
      bag_hsh
    end

    def rules(text)
      lines = text.split("\n")
      lines.each_with_object({}) do |line, hsh|
        line_hsh = rule(line)
        line_hsh.each { |k, v| hsh[k] = v }
      end
    end

    def find_bags(text, colour, ary)
      rules(text).each do |k, hsh|
        next unless hsh.key?(colour)

        next if ary.include?(k)

        ary << k
      end
      ary
    end

    def deep_find_bags(text:, colour:, ary: [])
      running = true
      while running
        find_bags(text, colour, ary)
        current_colours = ary.dup
        ary.each { |c2| find_bags(text, c2, ary) }
        running = false if ary == current_colours
      end
      ary.count
    end
  end
end
