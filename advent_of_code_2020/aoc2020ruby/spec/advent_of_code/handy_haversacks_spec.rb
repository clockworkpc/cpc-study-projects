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

  describe 'Part 2' do
    <<~'HEREDOC'
      --- Part Two ---
      It's getting pretty expensive to fly these days - not because of ticket prices, but because of the ridiculous number of bags you need to buy!
      
      Consider again your shiny gold bag and the rules from the above example:
      
      faded blue bags contain 0 other bags.
      dotted black bags contain 0 other bags.
      vibrant plum bags contain 11 other bags: 5 faded blue bags and 6 dotted black bags.
      dark olive bags contain 7 other bags: 3 faded blue bags and 4 dotted black bags.
      So, a single shiny gold bag must contain 1 dark olive bag (and the 7 bags within it) plus 2 vibrant plum bags (and the 11 bags within each of those): 1 + 1*7 + 2 + 2*11 = 32 bags!
      
      Of course, the actual rules have a small chance of going several levels deeper than this example; be sure to count all of the bags, even if the nesting becomes topologically impractical!
      
      Here's another example:
      
      shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.
      In this example, a single shiny gold bag must contain 126 other bags.
      
      How many individual bags are required inside your single shiny gold bag?
    HEREDOC
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
      res = subject.deep_find_bags(text: sample_input, colour: :shiny_gold)
      expect(res).to eq(4)
    end

    it 'returns X valid_outermost_bags for puzzle_input' do
      puts subject.deep_find_bags(text: puzzle_input, colour: :shiny_gold)
    end
  end
end
