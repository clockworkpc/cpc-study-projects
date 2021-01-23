require './lib/advent_of_code/toboggan_trajectory'

RSpec.describe AdventOfCode::TobogganTrajectory do
  let(:puzzle_input) { File.readlines('./spec/fixtures/input_day_03.txt') }

  let(:sample_input) do
    txt = <<~HEREDOC
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    HEREDOC

    txt.split("\n")
  end

  let(:sample_plotted_cells) do
    [
      sample_input[0][0],
      sample_input[1][3],
      sample_input[2][6],
      sample_input[3][9],
      sample_input[4][1],
      sample_input[5][4],
      sample_input[6][7],
      sample_input[7][10],
      sample_input[8][2],
      sample_input[9][5],
      sample_input[10][8]
    ]
  end

  let(:sample_itinerary) do
    [
      { x: 0, y: 0 },
      { x: 3, y: 1 },
      { x: 6, y: 2 },
      { x: 9, y: 3 },
      { x: 12, y: 4 },
      { x: 15, y: 5 },
      { x: 18, y: 6 },
      { x: 21, y: 7 },
      { x: 24, y: 8 },
      { x: 27, y: 9 },
      { x: 30, y: 10 }
    ]
  end

  let(:sample_journeys) do
    [
      { right: 1, down: 1 },
      { right: 3, down: 1 },
      { right: 5, down: 1 },
      { right: 7, down: 1 },
      { right: 1, down: 2 }
    ]
  end

  describe 'Part 1' do
    it 'returns coordinates for journey' do
      expect(subject.itinerary(moves: 10, down: 1, right: 3)).to eq(sample_itinerary)
    end

    it 'returns cell value for each row' do
      expect(subject.plotted_cells(lines: sample_input, moves: 10, down: 1, right: 3))
        .to eq(sample_plotted_cells)
    end

    it 'returns cell value for each row of full journey' do
      expect(subject.journey_cells(lines: sample_input, down: 1, right: 3))
        .to eq({ cells: sample_plotted_cells, trees: 7 })
    end

    it 'returns tree count for puzzle input' do
      journey = subject.journey_cells(lines: puzzle_input, down: 1, right: 3)
      expect(journey[:trees]).to eq(223)
    end
  end

  describe 'Part 2' do
    it 'returns 2 trees for Right 1, Down 1' do
      journey = subject.journey_cells(lines: sample_input, down: 1, right: 1)
      expect(journey[:trees]).to eq(2)
    end

    it 'returns 7 trees for Right 3, Down 1' do
      journey = subject.journey_cells(lines: sample_input, down: 1, right: 3)
      expect(journey[:trees]).to eq(7)
    end

    it 'returns 3 trees for Right 5, Down 1' do
      journey = subject.journey_cells(lines: sample_input, down: 1, right: 5)
      expect(journey[:trees]).to eq(3)
    end

    it 'returns 4 trees for Right 7, Down 1' do
      journey = subject.journey_cells(lines: sample_input, down: 1, right: 7)
      expect(journey[:trees]).to eq(4)
    end

    it 'returns 2 trees for Right 1, Down 2' do
      journey = subject.journey_cells(lines: sample_input, down: 2, right: 1)
      expect(journey[:trees]).to eq(2)
    end

    it 'returns tree-count product of 336 for sample input' do
      tcp = subject.tree_count_product(lines: sample_input, journeys: sample_journeys)
      expect(tcp).to eq(336)
    end

    it 'returns tree-count product of 3_517_401_300 for puzzle input' do
      tcp = subject.tree_count_product(lines: puzzle_input, journeys: sample_journeys)
      expect(tcp).to eq(3_517_401_300)
    end
  end
end
