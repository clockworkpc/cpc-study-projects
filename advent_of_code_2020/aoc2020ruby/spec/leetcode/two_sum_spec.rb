require './lib/leetcode/two_sum'

RSpec.describe Leetcode::TwoSum do
  let(:nums0) { [2, 7, 11, 15] }
  let(:nums1) { [3, 2, 4] }
  let(:nums2) { [3, 3] }

  it 'returns 0,1' do
    expect(subject.two_sum(nums0, 9)).to eq([0, 1])
  end

  it 'returns 1,2' do
    expect(subject.two_sum(nums1, 6)).to eq([1, 2])
  end

  it 'returns 0,1' do
    expect(subject.two_sum(nums2, 6)).to eq([0, 1])
  end
end
