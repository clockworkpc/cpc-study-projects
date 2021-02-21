module Codewars
  class PyramidSlide
    def max_values(pyramid)
      pyramid.each_with_object([]) do |n_ary, main_ary|
        main_ary << n_ary.max
      end
    end

    def longest_slide_down(pyramid)
      max_values = max_values(pyramid)
      require 'pry'; binding.pry

      collection = pyramid.each_with_object([]).with_index do |(n_ary, main_ary), index|
        if index.zero?
          main_ary << { int: n_ary.first, index: index, position: 0 }
          next
        end

        last_position = main_ary.last[:position]
        int = n_ary[last_position..last_position + 1].max
        position = n_ary[last_position] == int ? last_position : last_position + 1
        main_ary << { int: int, index: index, position: position }
      end

      collection.sum { |hsh| hsh[:int] }
    end
  end
end
