require './lib/codewars/direction_reduction'

RSpec.describe Codewars::DirectionReduction do
  let(:ary1) { %w[NORTH SOUTH SOUTH EAST WEST NORTH WEST] }

  let(:ary2) { %w[NORTH WEST SOUTH EAST] }

  it "returns ['WEST']" do
    expect(subject.dir_reduc(ary1)).to eq(%w[WEST])
  end

  it 'returns the same array' do
    expect(subject.dir_reduc(ary2)).to eq(ary2)
  end
end
