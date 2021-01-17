require './lib/advent_of_code/slope_ride'
# rubocop:disable Metrics/BlockLength
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

  let(:map_3x3) do
    txt = <<~HEREDOC
      O.#
      .#.
      #..
    HEREDOC
    txt.strip
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

  let(:expanded_row_6x_left) do
    [
      { x: -3, y: 0, value: '.' },
      { x: -2, y: 0, value: '.' },
      { x: -1, y: 0, value: '#' },
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' }
    ]
  end

  let(:expanded_row_9x_left) do
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

  let(:expanded_matrix_6x3_left) do
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

  let(:expanded_row_6x_right) do
    [
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' },
      { x: 3, y: 0, value: '.' },
      { x: 4, y: 0, value: '.' },
      { x: 5, y: 0, value: '#' }
    ]
  end

  let(:expanded_row_9x_right) do
    [
      { x: 0, y: 0, value: '.', marker: 'O' },
      { x: 1, y: 0, value: '.' },
      { x: 2, y: 0, value: '#' },
      { x: 3, y: 0, value: '.' },
      { x: 4, y: 0, value: '.' },
      { x: 5, y: 0, value: '#' },
      { x: 6, y: 0, value: '.' },
      { x: 7, y: 0, value: '.' },
      { x: 8, y: 0, value: '#' }
    ]
  end

  let(:expanded_matrix_6x3_right) do
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

    it 'generates an initial matrix if @matrix is nil' do
      expect(mini.matrix).to eq(matrix_3x3)
    end

    it 'draws a map from initial matrix' do
      matrix = mini.matrix
      expect(mini.draw_map(matrix)).to eq(map_3x3)
    end

    it 'returns current position' do
      expect(mini.current_position).to eq({ x: 0, y: 0 })
    end

    it 'updates current position' do
      m = mini
      expect(m.current_position).to eq({ x: 0, y: 0 })
      m.update_current_position(x: 1, y: -1)
      expect(m.current_position).to eq({ x: 1, y: -1 })
    end

    it 'returns cell at current position' do
      first_cell = { x: 0, y: 0, value: '.', marker: 'O' }
      cell = mini.cell_at_position(x: 0, y: 0)
      expect(cell).to eq(first_cell)
    end

    it 'moves and updates the matrix' do
      m = mini
      m.move(down: 1, right: 1)
      new_map = <<~HEREDOC
        O.#
        .X.
        #..
      HEREDOC
      expect(m.draw_map(m.matrix)).to eq(new_map.strip)
      expect(m.log).to eq({ open: 1, trees: 1 })
    end

    it 'travels twice and updates the matrix and log' do
      m = mini
      m.travel(int: 2, down: 1, right: 1)

      new_map = <<~HEREDOC
        O.#
        .X.
        #.O
      HEREDOC

      expect(m.draw_map(m.matrix)).to eq(new_map.strip)
      expect(m.log).to eq({ open: 2, trees: 1 })
    end

    it 'travels to the bottom without expanding the map' do
      m = mini
      m.journey(down: 1, right: 1)

      new_map = <<~HEREDOC
        O.#
        .X.
        #.O
      HEREDOC

      boundaries = {
        min_x: 0,
        min_y: 0,
        max_x: 2,
        max_y: 2
      }

      expect(m.draw_map(m.matrix)).to eq(new_map.strip)
      expect(m.log).to eq({ open: 2, trees: 1 })
      expect(m.matrix_boundaries).to eq(boundaries)
    end

    # it 'travels to the bottom and logs the number of trees' do
    #   mini.travel(right: 1, down: 1)
    #   expect(mini.log[:trees]).to eq(1)
    # end

    it 'expands a row to the left by factor of one' do
      res = mini.expand_row_left(row_3x3, row_3x3_initial, 1)
      expect(res).to eq(expanded_row_6x_left)
    end

    it 'expands a row to the left by factor of two' do
      res = mini.expand_row_left(row_3x3, row_3x3_initial, 2)
      expect(res).to eq(expanded_row_9x_left)
    end

    it 'expands a row to the left by factor of two' do
      res = mini.expand_row(direction: :left, row: row_3x3, int: 2)
      expect(res).to eq(expanded_row_9x_left)
    end

    it 'expands a row to the right by factor of one' do
      res = mini.expand_row_right(row_3x3, row_3x3_initial, 1)
      expect(res).to eq(expanded_row_6x_right)
    end

    it 'expands a row to the right by factor of two' do
      res = mini.expand_row_right(row_3x3, row_3x3_initial, 2)
      expect(res).to eq(expanded_row_9x_right)
    end

    it 'expands a row to the right by factor of one' do
      res = mini.expand_row(direction: :right, row: row_3x3, int: 2)
      expect(res).to eq(expanded_row_9x_right)
    end

    it 'expands the matrix to the left and keeps current position' do
      matrix = mini.generate_matrix_from_lines(lines: lines_3x3,
                                               position: { x: 0, y: 0 })

      expanded_matrix = mini.expand_matrix(matrix: matrix,
                                           direction: :left,
                                           int: 1)

      expect(expanded_matrix).to eq(expanded_matrix_6x3_left)
    end
  end
end
# rubocop:enable Metrics/BlockLength
