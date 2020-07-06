require 'spec_helper'
require 'game_of_life/world'

RSpec.describe GameOfLife::World do
  let(:empty_grid) do
    [
      { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false }, { x: 2, y: 0, life: false },
      { x: 0, y: 1, life: false }, { x: 1, y: 1, life: false }, { x: 2, y: 1, life: false },
      { x: 0, y: 2, life: false }, { x: 1, y: 2, life: false }, { x: 2, y: 2, life: false }
    ]
  end

  let(:empty_world_report) do
    {
      cell_0_0: :dead, cell_1_0: :dead, cell_2_0: :dead,
      cell_0_1: :dead, cell_1_1: :dead, cell_2_1: :dead,
      cell_0_2: :dead, cell_1_2: :dead, cell_2_2: :dead
    }
  end

  let(:first_cell_original) { { x: 0, y: 0, life: false } }
  let(:first_cell_toggled) { { x: 0, y: 0, life: true } }

  let(:toggled_grid) do
    [
      { x: 0, y: 0, life: false }, { x: 1, y: 0, life: false }, { x: 2, y: 0, life: true },
      { x: 0, y: 1, life: true }, { x: 1, y: 1, life: true }, { x: 2, y: 1, life: false },
      { x: 0, y: 2, life: true }, { x: 1, y: 2, life: false }, { x: 2, y: 2, life: false }
    ]
  end

  describe '3x3 World' do
    before(:all) do
      @subject = described_class.new(3)
    end

    it 'generates an empty grid' do
      expect(@subject.create_empty_grid).to eq(empty_grid)
    end

    it 'returns an overview of the grid' do
      expect(@subject.report).to eq(empty_world_report)
    end

    it 'retrieves the details of a cell' do
      expect(@subject.cell(0, 0)).to eq(first_cell_original)
    end

    it 'returns that [0, 0] is NORTH [0, 1]' do
      cell = @subject.cell(0, 0)
      neighbour = @subject.cell(0, 1)
      expect(@subject.relative_position(cell, neighbour)).to eq(:north)
    end

    it 'returns that [0, 1] is SOUTH [0, 0]' do
      cell = @subject.cell(0, 1)
      neighbour = @subject.cell(0, 0)
      expect(@subject.relative_position(cell, neighbour)).to eq(:south)
    end

    it 'returns that [0, 0] is WEST [1, 0]' do
      cell = @subject.cell(0, 0)
      neighbour = @subject.cell(1, 0)
      expect(@subject.relative_position(cell, neighbour)).to eq(:west)
    end

    it 'returns that [1, 0] is EAST [0, 0]' do
      cell = @subject.cell(1, 0)
      neighbour = @subject.cell(0, 0)
      expect(@subject.relative_position(cell, neighbour)).to eq(:east)
    end

    it 'returns that [0, 0] is NORTHWEST [1, 1]' do
      cell = @subject.cell(0, 0)
      neighbour = @subject.cell(1, 1)
      expect(@subject.relative_position(cell, neighbour)).to eq(:north_west)
    end

    it 'returns that [1, 1] is SOUTHEAST [0,0]' do
      cell = @subject.cell(1, 1)
      neighbour = @subject.cell(0, 0)
      expect(@subject.relative_position(cell, neighbour)).to eq(:south_east)
    end

    it 'returns that [0,1] is SOUTHWEST [1,0]' do
      cell = @subject.cell(0, 1)
      neighbour = @subject.cell(1, 0)
      expect(@subject.relative_position(cell, neighbour)).to eq(:south_west)
    end

    it 'returns that [1,0] is NORTHEAST [0,1]' do
      cell = @subject.cell(1, 0)
      neighbour = @subject.cell(0, 1)
      expect(@subject.relative_position(cell, neighbour)).to eq(:north_east)
    end

    it 'toggles a cell' do
      expect(@subject.toggle(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle(0, 0)).to eq(first_cell_original)
      expect(@subject.toggle(0, 0)).to eq(first_cell_toggled)
      expect(@subject.toggle(0, 0)).to eq(first_cell_original)
    end
  end
end
