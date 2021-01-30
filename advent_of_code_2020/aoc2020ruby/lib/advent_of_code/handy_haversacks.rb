require 'tty-box'
require 'set'
module AdventOfCode
  class HandyHaversacks
    PARENTS = Hash.new { |k, v| k[v] = [] }
    CONTENTS = Hash.new { |k, v| k[v] = [] }

    def parse_rule(rule)
      parent = rule.scan(/\w+ \w+/).first

      rule.scan(/(\d+) (\w+ \w+)/).each do |quantity, child|
        PARENTS[child].push(parent)
        CONTENTS[parent].push(quantity.to_i)
      end
      require 'pry'; binding.pry
    end

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

    def find_outer_bags(rules, colour, ary)
      rules.each do |k, hsh|
        next unless hsh.key?(colour)

        next if ary.include?(k)

        ary << k
        rules.delete(k)
      end

      ary
    end

    def deep_find_outer_bags(colour:, rules: nil, text: nil, ary: [])
      rules = rules(text) if rules.nil?

      running = true
      while running
        find_outer_bags(rules, colour, ary)
        current_colours = ary.dup
        ary.each { |c2| find_outer_bags(rules, c2, ary) }
        running = false if ary == current_colours
      end
      ary.count
    end

    # def find_inner_bags(rules, colour, ary, int = 1)
    #   rules.each do |k, hsh|
    #     next unless k == colour

    #     next if ary.include?(hsh)

    #     ary << hsh
    #     rules.delete(k)
    #   end
    #   ary
    # end

    def new_rule(line)
      bag_hsh = {}
      sentence = line.split('bags contain')
      outer_bag_key = symbolize_colour(sentence.first)
      inner_bag_str_ary = inner_bags_predicate(sentence)
      bag_hsh[outer_bag_key] = inner_bags_hash(inner_bag_str_ary)
                               .map { |k, v| { k => v } }
      bag_hsh
    end

    def new_rules(text)
      lines = text.split("\n")
      res = lines.each_with_object({}) do |line, hsh|
        line_hsh = new_rule(line)
        line_hsh.each { |k, v| hsh[k] = v }
      end
    end

    # def find_inner_bags(rules, colour, array)
    #   return if rules[colour].nil? || rules[colour].empty?

    #   rules[colour].each_with_object([]) do |hsh, ary|
    #     pp hsh
    #     k = hsh.keys.first
    #     v = hsh.values.first
    #     ary << v
    #     array << ary
    #     pp array
    #     find_inner_bags(rules, k, array)
    #   end
    # end

    def find_inner_bags(rules:, colour:, array:, int: 1)
      return if rules[colour].empty? || rules[colour].nil?

      rules[colour].each do |kolour, value|
        array << [int, value]
        pp kolour
        pp array

        find_inner_bags(rules: rules,
                        colour: kolour,
                        array: array,
                        int: value)
      end

      array
    end

    def deep_find_inner_bags(text:, colour:, array: [])
      find_inner_bags(rules: rules(text),
                      colour: colour,
                      array: array)
    end

    def deep_find_inner_bags_total(text:, colour:)
      res = deep_find_inner_bags(text: text,
                                 colour: colour)

      res.sum { |ary| ary.inject(&:*) }
    end

    # def deep_find_inner_bags(colour:, rules: nil, text: nil, ary: [])
    #   # # Example [[2], [2, 4], [2, 4, 8]] => [2, 8, 64] => 74
    #   # ary.map { |n| n.inject(&:*) }.inject(&:+)

    #   # nested_values = ary.map(&:values).flatten.each_with_object([]) do |n, ar2|
    #   #   ar2 << (ar2.empty? ? n : n * ar2.last)
    #   # end

    #   # nested_values.inject(&:+)
    # end
  end
end
