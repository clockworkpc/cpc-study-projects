module Codewars
  class RomanNumerals
    DICT = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000
    }

    CHARS = /I[VXLCDM]|V[XLCDM]|X[LCDM]|L[CDM]|C[DM]|DM|I+|V+|X+|L+|C+|D+|M+/.freeze

    def char_values(char)
      str_to_int = -> { char.split('').map { |c| DICT[c.upcase] } }

      single_char = char.length == 1 && char.split('').uniq.count == 1
      same_chars = char.length > 1 && char.split('').uniq.count == 1
      diff_chars = char.length > 1 && char.split('').uniq.count > 1

      if single_char
        DICT[char.upcase]
      elsif same_chars
        str_to_int.call.sum
      elsif diff_chars
        values = str_to_int.call
        values.last - values.first
      end
    end

    def solution(str)
      chars = str.scan(CHARS)

      values = chars.each_with_object([]) do |char, ary|
        value = char_values(char)
        ary << value
      end

      values.sum
    end
  end
end

DICT = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}

CHARS = /I[VXLCDM]|V[XLCDM]|X[LCDM]|L[CDM]|C[DM]|DM|I+|V+|X+|L+|C+|D+|M+/.freeze

def char_values(char)
  str_to_int = -> { char.split('').map { |c| DICT[c.upcase] } }

  single_char = char.length == 1 && char.split('').uniq.count == 1
  same_chars = char.length > 1 && char.split('').uniq.count == 1
  diff_chars = char.length > 1 && char.split('').uniq.count > 1

  if single_char
    DICT[char.upcase]
  elsif same_chars
    str_to_int.call.sum
  elsif diff_chars
    values = str_to_int.call
    values.last - values.first
  end
end

def solution(str)
  chars = str.scan(CHARS)

  values = chars.each_with_object([]) do |char, ary|
    value = char_values(char)
    ary << value
  end

  values.sum
end
