require './lib/leetcode/three_sum'

RSpec.describe Leetcode::TwoSum do
  let(:nums) { [-1, 0, 1, 2, -1, -4] }

  it 'returns 0,1' do
    expect(subject.three_sum(nums0, 9)).to eq([0, 1])
  end
end
