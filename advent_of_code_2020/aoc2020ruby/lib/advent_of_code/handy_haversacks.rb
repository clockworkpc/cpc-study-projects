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

    def find_bags(rules, bag, ary)
      rules.each do |k, hsh|
        ary << k if hsh.key?(bag)
      end
    end

    def find_all_bags(text:, bag:, ary: [])
      rules(text).each do |k, hsh|
        next unless hsh.key?(bag)

        ary << k
      end

      inner = ary.each_with_object([]) do |colour, ary2|
        rules(text).each do |k, hsh|
          next unless (ary2 & hsh.keys).empty?

          ary2 << k if hsh.keys.include?(colour)
        end
      end

      require 'pry'; binding.pry

      # indirect_bags = ->(ary) do
      #   rules(text).each do |k, hsh|
      #     next unless ary.include?()

      #   end
      # end

      # ary.each

      # ary = rules(text) if ary.empty?
      # ary.each do |k, hsh|
      #   next unless hsh.key?(bag)

      #   ary << k
      #   # hsh.keys.each do |new_bag|
      #   #   find_all_bags(text: text, bag: new_bag, ary: ary)
      #   # end
      # end
      # ary
    end

    # TODO: Must be recursive, not just two passes
    # def valid_outermost_bags(text:, bag:)
    #   find_bags = lambda do |outer_bag|
    #     rules(text).map do |k, hsh|
    #       k if hsh.key?(outer_bag)
    #     end
    #   end

    #   direct = find_bags.call(bag)
    #                     .flatten.compact.uniq

    #   puts "\nDIRECT OUTER BAGS: #{direct}\n\n"

    #   indirect = direct.map { |b| find_bags.call(b) }
    #                    .flatten.compact.uniq

    #   (direct + indirect).count
    # end
  end
end
