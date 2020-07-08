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
      expect(@subject.toggle(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle(0, 0)).to eq(first_cell_original)
      expect(@subject.toggle(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle(0, 0)).to eq(first_cell_original)
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
  end
end
