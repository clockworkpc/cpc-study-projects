require './lib/advent_of_code/handy_haversacks_alt'

RSpec.describe AdventOfCode::HandyHaversacksAlt do
  let(:puzzle_input) { File.read('./spec/fixtures/input_day_07.txt') }

  it 'parses a line' do
    line = 'shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.'
    subject.parse_line(line)
  end

  # it 'parses text' do
  #   subject.parse_rules(puzzle_input)
  # end

  # it 'provides solution' do
  #   subject.call(text: puzzle_input)
  # end
end
