module Leetcode
  class ThreeSum
    def three_sum(nums)
      nums.each_with_object([]).with_index do |(n, ary), i|
        nums[(i + 1)..-1].each_with_index do |o, i2|
          next unless n + o == target

          ary.push(i, i + i2 + 1)
          break
        end
      end
    end
  end
end
