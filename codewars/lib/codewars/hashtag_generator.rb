module Codewars
  class HashtagGenerator
    def generateHashtag(string) # rubocop:disable Naming/MethodName
      scan = string.scan(/[\w\d]+/)
      return false if scan.empty? || scan.join.length > 139

      ['#', scan.map(&:capitalize)].join
    end
  end
end
