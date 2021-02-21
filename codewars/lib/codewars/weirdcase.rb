module Codewars
  class Weirdcase
    def weirdcase(string)
      set_case = ->(char, i) { i.zero? || i.even? ? char.upcase : char.downcase }

      chars_ary_ary = string.split.map { |word| word.scan(/\w/) }

      collection = chars_ary_ary.each_with_object([]) do |chars_ary, ary|
        chars_ary.each_with_index { |char, i| ary << set_case.call(char, i) }
        ary << ' '
      end

      collection.join.strip
    end
  end
end
