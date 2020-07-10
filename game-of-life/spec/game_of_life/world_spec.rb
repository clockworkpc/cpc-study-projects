require 'spec_helper'
require 'game_of_life/world'

RSpec.describe GameOfLife::World do
  let(:range_size_3) { [-1, 0, 1] }
  let(:range_size_4) { [-1, 0, 1, 2] }
  let(:range_size_5) { [-2, -1, 0, 1, 2] }
  let(:range_size_6) { [-2, -1, 0, 1, 2, 3] }

  let(:empty_grid) do
    [
      { x: -1, y: 1, life: false }, { x: 0, y: 1, life: false }, { x: 1, y: 1, life: false },
      { x: -1, y: 0, life: false }, { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false },
      { x: -1, y: -1, life: false }, { x: 0, y: -1, life: false }, { x: 1, y: -1, life: false }
    ]
  end

  let(:populated_grid) do
    [
      { x: -1, y: 1, life: false }, { x: 0, y: 1, life: true }, { x: 1, y: 1, life: true },
      { x: -1, y: 0, life: false }, { x: 0, y: 0, life: true }, { x: 1, y: 0, life: true },
      { x: -1, y: -1, life: false }, { x: 0, y: -1, life: true }, { x: 1, y: -1, life: false }
    ]
  end

  let(:empty_grid_drawing) do
    <<~HEREDOC
      |---|---|---|
      |   |   |   |
      |---|---|---|
      |   |   |   |
      |---|---|---|
      |   |   |   |
      |---|---|---|
    HEREDOC
  end

  let(:populated_grid_drawing) do
    <<~HEREDOC
      |---|---|---|
      |   | x | x |
      |---|---|---|
      |   | x | x |
      |---|---|---|
      |   | x |   |
      |---|---|---|
    HEREDOC
  end

  let(:empty_world_report) do
    {
      row0: { col0: :dead, col1: :dead, col2: :dead },
      row1: { col0: :dead, col1: :dead, col2: :dead },
      row2: { col0: :dead, col1: :dead, col2: :dead }
    }
  end

  let(:first_generation_report) do
    {
      row0: { col0: :dead, col1: :happy, col2: :happy },
      row1: { col0: :fertile, col1: :crowded, col2: :crowded },
      row2: { col0: :dead, col1: :happy, col2: :fertile }
    }
  end

  let(:second_generation_report) do
    {
      row0: { col0: :dead, col1: :alive, col2: :alive },
      row1: { col0: :alive, col1: :dead, col2: :dead },
      row2: { col0: :dead, col1: :alive, col2: :alive }
    }
  end

  let(:second_generation_grid_drawing) do
    <<~HEREDOC
      |---|---|---|
      |   | x | x |
      |---|---|---|
      | x |   |   |
      |---|---|---|
      |   | x | x |
      |---|---|---|
    HEREDOC
  end

  let(:grid_second_generation) do
    [
      { x: -1, y: 1, life: false }, { x: 0, y: 1, life: true }, { x: 1, y: 1, life: true },
      { x: -1, y: 0, life: true }, { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false },
      { x: -1, y: -1, life: false }, { x: 0, y: -1, life: true }, { x: 1, y: -1, life: true }
    ]
  end
  # let(:second_generation_report) do
  #   {
  #     row0: { col0: :dead, col1: :happy, col2: :happy },
  #     row1: { col0: :happy, col1: :dead, col2: :happy },
  #     row2: { col0: :dead, col1: :happy, col2: :happy }
  #   }
  # end

  let(:first_cell_original) { { x: 0, y: 0, life: false } }
  let(:first_cell_toggled) { { x: 0, y: 0, life: true } }

  let(:cell_centre_neighbours) do
    [
      { x: -1, y: 1, life: false }, { x: 0, y: 1, life: false }, { x: 1, y: 1, life: false },
      { x: -1, y: 0, life: false }, { x: 1, y: 0, life: false },
      { x: -1, y: -1, life: false }, { x: 0, y: -1, life: false }, { x: 1, y: -1, life: false }
    ]
  end

  let(:north_west_cell_neighbours) do
    [
      { x: 0, y: 1, life: false },
      { x: -1, y: 0, life: false }, { x: 0, y: 0, life: false }
    ]
  end

  let(:north_east_cell_neighbours) do
    [
      { x: 0, y: 1, life: false },
      { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false }
    ]
  end

  let(:south_west_cell_neighbours) do
    [
      { x: -1, y: 0, life: false }, { x: 0, y: 0, life: false },
      { x: 0, y: -1, life: false }
    ]
  end

  let(:south_east_cell_neighbours) do
    [
      { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false },
      { x: 0, y: -1, life: false }
    ]
  end

  let(:toggled_grid) do
    [
      { x: -1, y: 1, life: false }, { x: 0, y: 1, life: false }, { x: 1, y: 1, life: true },
      { x: -1, y: 0, life: true }, { x: 0, y: 0, life: true }, { x: 1, y: 0, life: false },
      { x: -1, y: -1, life: true }, { x: 0, y: -1, life: false }, { x: 1, y: -1, life: false }
    ]
  end

  describe 'New Worlds' do
    it 'returns the correct range size' do
      execute_range_test(3, range_size_3)
      execute_range_test(4, range_size_4)
      execute_range_test(5, range_size_5)
      execute_range_test(6, range_size_6)
    end

    def execute_range_test(size, expectation)
      puts "Range should be #{expectation}"
      expect(described_class.new(size).range).to eq(expectation)
    end
  end

  describe 'New 3x3 World' do
    before(:all) do
      @subject = described_class.new(3)
    end

    it 'generates an empty grid' do
      expect(@subject.create_empty_grid).to eq(empty_grid)
    end

    it 'returns an overview of the grid' do
      expect(@subject.report_today).to eq(empty_world_report)
    end

    it 'retrieves the details of a cell' do
      expect(@subject.find_cell(0, 0)).to eq(first_cell_original)
    end

    it 'returns nil for out-of-bounds cell coordinates' do
      expect(@subject.find_cell(100, 100)).to eq(nil)
    end

    it 'returns the coordinates of the neighbour' do
      execute_relative_position_test([0, 0], [0, 1], :south)
      execute_relative_position_test([0, 1], [0, 0], :north)
      execute_relative_position_test([0, 0], [1, 0], :west)
      execute_relative_position_test([1, 0], [0, 0], :east)
      execute_relative_position_test([0, 0], [1, 1], :south_west)
      execute_relative_position_test([1, 1], [0, 0], :north_east)
      execute_relative_position_test([0, 1], [1, 0], :north_west)
      execute_relative_position_test([1, 0], [0, 1], :south_east)
    end

    def execute_relative_position_test(cell_xy, neighbour_xy, expectation)
      puts "Relation of #{cell_xy} to #{neighbour_xy} is #{expectation}"
      cx, cy = cell_xy
      nx, ny = neighbour_xy
      cell = @subject.find_cell(cx, cy)
      neighbour = @subject.find_cell(nx, ny)
      expect(@subject.relative_position_to_cell(cell, neighbour)).to eq(expectation)
    end

    it 'toggles a cell' do
      expect(@subject.toggle_cell(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle_cell(0, 0)).to eq(first_cell_original)
      expect(@subject.toggle_cell(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle_cell(0, 0)).to eq(first_cell_original)
    end

    it 'returns current_status' do
      expect(@subject.current_status(0, 0)).to eq(:dead)
    end

    it 'returns neighbours of south_east cell' do
      cell = @subject.find_cell(1, -1)
      expect(@subject.adjacent_cells(cell)).to eq(south_east_cell_neighbours)
    end

    it 'returns the neighbours of a given cell' do
      execute_neighbouring_cells_test([0, 0], cell_centre_neighbours)
      execute_neighbouring_cells_test([-1, 1], north_west_cell_neighbours)
      execute_neighbouring_cells_test([1, 1], north_east_cell_neighbours)
      execute_neighbouring_cells_test([-1, -1], south_west_cell_neighbours)
      execute_neighbouring_cells_test([1, -1], south_east_cell_neighbours)
    end

    def execute_neighbouring_cells_test(xy_ary, expectation)
      x, y = xy_ary
      neighbour_coordinates = expectation.map { |hsh| [hsh[:x], hsh[:y]] }
      puts "Neighbouring cells of #{xy_ary} should be #{neighbour_coordinates}"
      cell = @subject.find_cell(x, y)
      expect(@subject.adjacent_cells(cell)).to eq(expectation)
    end

    it 'draws an empty grid' do
      expect(@subject.draw_grid).to eq(empty_grid_drawing)
    end
  end

  describe 'Populated 3x3 World' do
    before(:all) do
      @subject = described_class.new(3)
      @subject.create_empty_grid
    end

    it 'starts with an empty grid' do
      expect(@subject.grid).to eq(empty_grid)
    end

    it 'vivifies [0, -1], [0,0], [0,1], [1,1], [1,0]' do
      coordinates = [[0, - 1], [0, 0], [0, 1], [1, 1], [1, 0]]
      @subject.populate_grid(coordinates)
      expect(@subject.grid).to eq(populated_grid)
    end

    it 'reports on the current status of the cells' do
      report = @subject.report_today
      expect(report).to eq(first_generation_report)
    end

    it 'draws a populated grid' do
      drawing = @subject.draw_grid
      expect(drawing).to eq(populated_grid_drawing)
    end

    it 'keeps a cell dead if does not have three living neighbours' do
      north_west = @subject.find_cell(-1, 1)
      south_west = @subject.find_cell(-1, -1)
      expect(@subject.future_status(north_west)).to eq(:dead)
      expect(@subject.future_status(south_west)).to eq(:dead)
    end

    it 'kills a cell that has more than three neighbours' do
      centre = @subject.find_cell(0, 0)
      expect(@subject.future_status(centre)).to eq(:dead)
    end

    it 'keeps a cell alive if it has 2-3 neighbours' do
      north = @subject.find_cell(0, 1)
      north_east = @subject.find_cell(0, 1)
      south = @subject.find_cell(0, -1)
      expect(@subject.future_status(north)).to eq(:alive)
      expect(@subject.future_status(north_east)).to eq(:alive)
      expect(@subject.future_status(south)).to eq(:alive)
    end

    it 'vivifies a dead cell if it has three neighbours' do
      west = @subject.find_cell(-1, 0)
      south_east = @subject.find_cell(-1, 0)
      expect(@subject.future_status(south_east)).to eq(:alive)
    end

    it 'delivers a report for tomorrow' do
      expect(@subject.report_tomorrow).to eq(second_generation_report)
    end

    it 'toggles the grid according to the report for tomorrow' do
      @subject.toggle_grid
      expect(@subject.grid).to eq(grid_second_generation)
    end

    it 'draws the second generation grid' do
      drawing = @subject.draw_grid
      expect(drawing).to eq(second_generation_grid_drawing)
    end
  end

  describe 'Randomly populated 3x3 World' do
    before(:all) do
      @subject = described_class.new(3)
      @subject.create_empty_grid
    end

    it 'vivifies 4 random cells' do
      @subject.seed_grid(4)
      living_cells = @subject.grid.find_all { |cell| cell[:life] }
      expect(living_cells.count).to eq(4)
      @subject.draw_grid
    end
  end
end
