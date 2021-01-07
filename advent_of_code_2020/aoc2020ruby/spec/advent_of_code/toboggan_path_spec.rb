require './lib/advent_of_code/toboggan_path'

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
      ##...##....#...##....#
      .#..#...#.#.#..#...#.#
    HEREDOC

    txt.split("\n")
  end

  it 'should expand the map to the right' do
    res = subject.expand_map(lines: sample_lines,
                             direction: :right,
                             int: 1)
    res.each_with_index do |line, i|
      puts "index: #{i}"
      puts line
      puts sample_lines_expanded[i]
    end

    expect(res).to eq(sample_lines_expanded)
  end
end
