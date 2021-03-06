require './lib/leetcode/two_sum.rb'

RSpec.describe Leetcode::TwoSum do
  let(:nums1) { [2,7,11,15] }  

  it 'returns 0,1' do
    expect(subject.two_sum(nums1, 9)).to eq([0,1])
  end
end
