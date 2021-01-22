module AdventOfCode
  class PassportProcessing
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)

    DICTIONARY = {
      'byr' => :birth_year,
      'iyr' => :issue_year,
      'eyr' => :expiration_year,
      'hgt' => :height,
      'hcl' => :hair_colour,
      'ecl' => :eyes_colour,
      'pid' => :passport_id,
      'cid' => :country_id
    }

    def passports(text)
      lines = text.split("\n\n")

      hsh_ary = lines.map do |line|
         details = line.split(/[\s\n]/)
         hsh = details.each_with_object({}) do |str, hsh|
           k,value = str.split(':')
           key = DICTIONARY[k]
           hsh[key] = value
         end
      end
    end

    def valid?(passport)
      required_fields = DICTIONARY.values.reject {|n| n == :country_id}
      ( required_fields - passport.keys ).empty?
    end

    def valid_passports(text)
      res = passports(text).each_with_object([]) do |passport, ary|
        ary << true if valid?(passport)
      end

      res.count
    end
  end
end
