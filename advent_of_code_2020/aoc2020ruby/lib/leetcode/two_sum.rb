module Leetcode
  class TwoSum
    def two_sum(nums, target)
      res = []
      nums.each do |n|
        others = nums[( nums.index(n) + 1 )..-1]
        others.find {|o| n + o == target}
        unless others.empty?
          res << nums.index(n)
          res << nums.index( others.first )
          break
        end
      end
      res
    end
  end
end
