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
