module Codewars
  class Anagram
    def anagrams(word, words)
      ssort = ->(s) { s.split('').sort.join }
      words.select { |str| ssort[str].eql?(ssort[word]) }
    end
  end
end
