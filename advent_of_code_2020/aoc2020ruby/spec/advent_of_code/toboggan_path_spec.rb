require './lib/advent_of_code/toboggan_path'
require 'rainbow'

RSpec.describe AdventOfCode::TobogganPath do
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

  context 'Sample lines' do
    subject { described_class.new(sample_lines) }

    it 'should expand the map to the right' do
      res = subject.expand_map(lines: sample_lines,
                               direction: :right,
                               int: 1)

      expect(res.count).to eq(sample_lines_expanded.count)
      expect(res).to eq(sample_lines_expanded)
      expect(res).to eq(sample_lines_expanded)
    end

    it 'returns the dimensions of the current map' do
      res = subject.current_map(lines: sample_lines)
      expect(res[:height]).to eq(11)
      expect(res[:width]).to eq(11)
    end
  end
end
