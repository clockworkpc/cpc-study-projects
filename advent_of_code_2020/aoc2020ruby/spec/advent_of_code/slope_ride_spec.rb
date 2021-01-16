require './lib/advent_of_code/slope_ride'

RSpec.describe AdventOfCode::SlopeRide do
  subject(:mini) { described_class.new(lines_3x3) }

  subject(:sample) { described_class.new(lines_sample) }

  subject(:puzzle) { described_class.new(day_03_input) }

  let(:day_03_input) { File.readlines('./spec/fixtures/day_03_input.txt') }

  let(:lines_3x3) do
    txt = <<~HEREDOC
      ..#
      .#.
      #..
    HEREDOC

    txt.split("\n")
  end

  let(:matrix_3x3) do
    {
      row0: [
        { x: 0, y: 0, value: '.', marker: 'O' },
        { x: 1, y: 0, value: '.' },
        { x: 2, y: 0, value: '#' }
      ],
      row1: [
        { x: 0, y: 1, value: '.' },
        { x: 1, y: 1, value: '#' },
        { x: 2, y: 1, value: '.' }
      ],
      row2: [
        { x: 0, y: 2, value: '#' },
        { x: 1, y: 2, value: '.' },
        { x: 2, y: 2, value: '.' }
      ]
    }
  end

  let(:row_3x3) do
    [
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' }
    ]
  end

  let(:row_3x3_initial) do
    [
      { x: 0, y: 0, value: '.' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' }
    ]
  end

  let(:expanded_row_6x) do
    [
      { x: -3, y: 0, value: '.' },
      { x: -2, y: 0, value: '.' },
      { x: -1, y: 0, value: '#' },
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' }
    ]
  end

  let(:expanded_row_9x) do
    [
      { x: -6, y: 0, value: '.' },
      { x: -5, y: 0, value: '.' },
      { x: -4, y: 0, value: '#' },
      { x: -3, y: 0, value: '.' },
      { x: -2, y: 0, value: '.' },
      { x: -1, y: 0, value: '#' },
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' }
    ]
  end

  let(:expanded_matrix_6x3) do
    {
      row0: [
        { x: -3, y: 0, value: '.' },
        { x: -2, y: 0, value: '.' },
        { x: -1, y: 0, value: '#' },
        { x: 0, y: 0, value: '.', marker: 'O' },
        { x: 1, y: 0, value: '.' },
        { x: 2, y: 0, value: '#' }
      ],
      row1: [
        { x: -3, y: 1, value: '.' },
        { x: -2, y: 1, value: '#' },
        { x: -1, y: 1, value: '.' },
        { x: 0, y: 1, value: '.' },
        { x: 1, y: 1, value: '#' },
        { x: 2, y: 1, value: '.' }
      ],
      row2: [
        { x: -3, y: 2, value: '#' },
        { x: -2, y: 2, value: '.' },
        { x: -1, y: 2, value: '.' },
        { x: 0, y: 2, value: '#' },
        { x: 1, y: 2, value: '.' },
        { x: 2, y: 2, value: '.' }
      ]
    }
  end

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

  context 'with 3x3 input' do
    it 'marks an empty square with "O"' do
      expect(mini.marker('.')).to eq('O')
    end

    it 'marks an empty square with "O"' do
      expect(mini.marker('.')).to eq('O')
    end

    it 'generates a matrix' do
      matrix = mini.generate_matrix_from_lines(lines: lines_3x3,
                                               position: { x: 0, y: 0 })
      expect(matrix).to eq(matrix_3x3)
    end

    it 'initial_matrix' do
      matrix = mini.initial_matrix
      expect(matrix).to eq(matrix_3x3)
    end

    it 'expands a low to the left by factor of one' do
      res = mini.expand_row_left(row_3x3, row_3x3_initial, 1)
      expect(res).to eq(expanded_row_6x)
    end

    it 'expands a low to the left by factor of one' do
      res = mini.expand_row_left(row_3x3, row_3x3_initial, 2)
      expect(res).to eq(expanded_row_9x)
    end

    it 'expands a low to the left by factor of one' do
      res = mini.expand_row(direction: :left, row: row_3x3, int: 2)
      expect(res).to eq(expanded_row_9x)
    end

    it 'expands the matrix to the left and keeps current position' do
      matrix = mini.generate_matrix_from_lines(lines: lines_3x3,
                                               position: { x: 0, y: 0 })

      expanded_matrix = mini.expand_matrix(matrix: matrix,
                                           direction: :left,
                                           int: 1)

      expect(expanded_matrix).to eq(expanded_matrix_6x3)
    end
  end
end
