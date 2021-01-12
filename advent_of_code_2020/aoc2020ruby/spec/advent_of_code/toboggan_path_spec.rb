require './lib/advent_of_code/toboggan_path'
require 'rainbow'

RSpec.describe AdventOfCode::TobogganPath do
  subject(:sample) { described_class.new(sample_lines) }

  let(:day_03_input) { File.readlines('./spec/fixtures/day_03_input.txt') }

  let(:sample_lines) do
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
  let(:sample_lines_expanded) do
    txt = <<~HEREDOC
      ..##.........##.......
      #...#...#..#...#...#..
      .#....#..#..#....#..#.
      ..#.#...#.#..#.#...#.#
      .#...##..#..#...##..#.
      ..#.##.......#.##.....
      .#.#.#....#.#.#.#....#
      .#........#.#........#
      #.##...#...#.##...#...
      #...##....##...##....#
      .#..#...#.#.#..#...#.#
    HEREDOC

    txt.split("\n")
  end

  let(:status_log_2_moves) do
    [
      { position: { x: 0, y: 0 }, status: :open },
      { position: { x: 3, y: -1 }, status: :open },
      { position: { x: 6, y: -2 }, status: :tree }
    ]
  end

  context 'Sample lines' do
    it 'returns the dimensions of the current map' do
      res = sample.current_map
      expect(res[:height]).to eq(11)
      expect(res[:width]).to eq(11)
    end

    it 'returns a starting position of {x: 0, y: 0}' do
      expect(sample.current_position).to eq({ x: 0, y: 0 })
    end

    it 'moves along the X and Y axes' do
      s = sample
      s.move(right: 3, down: 1)
      expect(s.current_position).to eq(x: 3, y: -1)
    end

    it 'returns :open at {x: 3, y: -1}' do
      expect(sample.status_at_location(x: 3, y: -1)).to eq(:open)
    end

    it 'returns the status at current position after move' do
      s = sample
      s.move(right: 3, down: 1)
      expect(s.status_at_current_position).to eq(:open)
    end

    it 'moves right and down twice' do
      s = sample
      s.travel(moves: 2, right: 3, down: 1)
      expect(s.current_position).to eq({ x: 6, y: -2 })
      expect(s.status_log).to eq(status_log_2_moves)
    end

    it 'expands the map to the right' do
      s = sample
      s.expand_current_map(direction: :right, int: 1)
      expect(s.current_map[:width]).to eq(22)
    end

    it 'expands the map to the right by 1 when approaching the edge' do
      s = sample
      s.move(right: 10, down: 1)
      expect(s.current_position).to eq(x: 10, y: -1)
      expect(s.map.count).to eq(11)
      expect(s.map.first.length).to eq(22)
    end

    it 'expands the map to the right by 2 when approaching the edge with a big jump' do
      s = sample
      s.move(right: 21, down: 1)
      expect(s.current_position).to eq(x: 10, y: -1)
      expect(s.map.count).to eq(11)
      expect(s.map.first.length).to eq(33)
    end

    # it 'travels a trajectory to the bottom' do
    #   s = sample
    #   expect(s.follow_trajectory(right: 3, down: 1)).to eq()
    #   s.move_straight_to_bottom(down: 1, right: 3)
    #   expect(s.current_position).to eq([10, -30])
    # end
  end
end
