require './lib/advent_of_code/toboggan_trajectory'

RSpec.describe AdventOfCode::TobogganTrajectory do
  let(:sample_input) { File.readlines('./spec/fixtures/input_day_03.txt') }

  let(:sample_itinerary) do
    [
      { x: 1, y: 1 },
      { x: 4, y: 2 },
      { x: 7, y: 3 },
      { x: 10, y: 4 },
      { x: 13, y: 5 },
      { x: 16, y: 6 },
      { x: 19, y: 7 },
      { x: 22, y: 8 },
      { x: 25, y: 9 },
      { x: 28, y: 10 },
      { x: 31, y: 11 }
    ]
  end

  it 'returns coordinates for journey' do
    expect(subject.itinerary(down: 1, right: 3)).to eq(sample_itinerary)
  end
end
