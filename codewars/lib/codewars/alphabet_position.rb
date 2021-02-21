module Codewars
  class AlphabetPosition
    ALPHABET = ('a'..'z').to_a.each_with_index.each_with_object({}) do |pair, hsh|
      char, index = pair
      hsh[char] = index + 1
    end

    def alphabet_position(string)
      string.downcase.scan(/[a-z]/).map { |char| ALPHABET[char] }.join(' ').strip
    end
  end
end
