require 'tty-box'
require 'set'
module AdventOfCode
  class HandyHaversacks
    LINE_REGEX = /(\w+\s\w+ bag|\d+ \w+\s\w+ bag)/.freeze
    def symbolize_colour(string)
      string.strip.sub(/\s/, '_').to_sym
    end

    def rule(line)
      bags = line.scan(LINE_REGEX).flatten
                 .map { |str| str.delete_suffix('bag').strip }

      parent = bags[0].sub(' ', '_').to_sym

      return { parent => {} } if line.match?('no other')

      children = bags[1..-1].each_with_object({}) do |str, hsh|
        key = str.scan(/[a-z]+ [a-z]+/).first.sub(' ', '_').to_sym
        value = str.scan(/\d+/).first.to_i
        hsh[key] = value
      end
      { parent => children }
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

    def find_inner_bags(rules:, colour:, total:, current:)
      rules[colour].each do |k, v|
        ary = (current.dup << v)
        total << ary

        next if rules[k].nil? || rules[k].empty?

        find_inner_bags(colour: k, rules: rules, total: total, current: ary)
      end

      total
    end

    def deep_find_inner_bags(text:, colour:)
      find_inner_bags(rules: rules(text), colour: colour, total: [], current: [1])
    end

    def inner_bags_sum_total(text:, colour:)
      deep_find_inner_bags(text: text, colour: colour)
        .sum { |ary| ary.inject(&:*) }
    end
  end
end
