require './lib/advent_of_code/handy_haversacks'

RSpec.describe AdventOfCode::HandyHaversacks do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_07.txt') }

  let(:sample_input) do
    txt = <<~HEREDOC
      light red bags contain 1 bright white bag, 2 muted yellow bags.
      dark orange bags contain 3 bright white bags, 4 muted yellow bags.
      bright white bags contain 1 shiny gold bag.
      muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
      shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
      dark olive bags contain 3 faded blue bags, 4 dotted black bags.
      vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
      faded blue bags contain no other bags.
      dotted black bags contain no other bags.
    HEREDOC
  end

  let(:sample_hash) do
    {
      light_red: { bright_white: 1, muted_yellow: 2 },
      dark_orange: { bright_white: 3, muted_yellow: 4 },
      bright_white: { shiny_gold: 1 },
      muted_yellow: { shiny_gold: 2, faded_blue: 9 },
      shiny_gold: { dark_olive: 1, vibrant_plum: 2 },
      dark_olive: { faded_blue: 3, dotted_black: 4 },
      vibrant_plum: { faded_blue: 5, dotted_black: 6 },
      faded_blue: {},
      dotted_black: {}
    }
  end

  let(:sample_hash2) do
    {
      shiny_gold: { dark_red: 2 },
      dark_red: { dark_orange: 2 },
      dark_orange: { dark_yellow: 2 },
      dark_yellow: { dark_green: 2 },
      dark_green: { dark_blue: 2 },
      dark_blue: { dark_violet: 2 },
      dark_violet: {}
    }
  end

  let(:rules_nested_ary) do
    [
      { dark_red: 2 }, [
        { dark_orange: 2 }, [
          { dark_yellow: 2 }, [
            { dark_green: 2 }, [
              { dark_blue: 2 }, [
                { dark_violet: 2 }
              ]
            ]
          ]
        ]
      ]
    ]
  end

  describe 'Part 2' do
    <<~'HEREDOC'

      Here's another example:

      In this example, a single shiny gold bag must contain 126 other bags.

      How many individual bags are required inside your single shiny gold bag?
    HEREDOC

    it 'finds 32 bags for :shiny_gold from sample input' do
      # require 'pry'; binding.pry
      res = subject.deep_find_inner_bags(rules: sample_hash, colour: :shiny_gold)
      expect(res).to eq(32)
    end

    it 'finds 126 bags for :shiny_gold from sample_hash2' do
      res = subject.deep_find_inner_bags(rules: sample_hash2, colour: :shiny_gold)
      expect(res).to eq(126)
    end
  end

  describe 'Part 1' do
    it 'defines a rule for a light red bag' do
      line = 'light red bags contain 1 bright white bag, 2 muted yellow bags.'
      rule = {
        light_red: {
          bright_white: 1,
          muted_yellow: 2
        }
      }
      expect(subject.rule(line)).to eq(rule)
    end

    it 'defines a rule for a faded blue bag' do
      line = 'faded blue bags contain no other bags.'
      rule = { faded_blue: {} }
      expect(subject.rule(line)).to eq(rule)
    end

    it 'generates a dictionary of bag rules' do
      expect(subject.rules(sample_input)).to eq(sample_hash)
    end

    it 'returns 4 for valid_outermost_bags' do
      res = subject.deep_find_outer_bags(text: sample_input, colour: :shiny_gold)
      expect(res).to eq(4)
    end

    it 'returns 185 valid_outermost_bags for puzzle_input' do
      res = subject.deep_find_outer_bags(text: puzzle_input, colour: :shiny_gold)
      expect(res).to eq(185)
    end
  end
end
