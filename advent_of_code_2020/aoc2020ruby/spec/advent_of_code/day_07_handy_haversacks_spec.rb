require './lib/advent_of_code/handy_haversacks'

RSpec.describe AdventOfCode::HandyHaversacks do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_07.txt') }

  let(:sample_input) do
    <<~HEREDOC
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

  let(:sample_input2) do
    <<~HEREDOC
      shiny gold bags contain 2 dark red bags.
      dark red bags contain 2 dark orange bags.
      dark orange bags contain 2 dark yellow bags.
      dark yellow bags contain 2 dark green bags.
      dark green bags contain 2 dark blue bags.
      dark blue bags contain 2 dark violet bags.
      dark violet bags contain no other bags.
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

  describe 'Part 2' do
    it 'finds 32 bags for :shiny_gold from sample input' do
      res1 = subject.deep_find_inner_bags(text: sample_input, colour: :shiny_gold)
      array = [[1, 1], [1, 1, 3], [1, 1, 4], [1, 2], [1, 2, 5], [1, 2, 6]]
      expect(res1).to eq(array)
      res2 = subject.inner_bags_sum_total(text: sample_input, colour: :shiny_gold)
      expect(res2).to eq(32)
    end

    it 'finds 126 bags for :shiny_gold from sample_hash2' do
      res = subject.inner_bags_sum_total(
        text: sample_input2,
        colour: :shiny_gold
      )
      expect(res).to eq(126)
    end

    it 'inner bag sum total for puzzle_input returns 89_084' do
      res = subject.inner_bags_sum_total(
        text: puzzle_input,
        colour: :shiny_gold
      )

      expect(res).to eq(89_084)
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
      res = subject.rules(sample_input)
      expect(res).to eq(sample_hash)
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
