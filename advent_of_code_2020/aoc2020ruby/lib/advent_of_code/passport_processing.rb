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

    def valid_passport_keys?(passport)
      required_fields = DICTIONARY.values.reject {|n| n == :country_id}
      ( required_fields - passport.keys ).empty?
    end

    def passports_with_valid_keys(text)
      res = passports(text).each_with_object([]) do |passport, ary|
        ary << true if valid_passport_keys?(passport)
      end
      res.count
    end

    def valid_birth_year?(int)
      int >= 1920 && int <= 2002 
    end

    def valid_issue_year?(int)
      int >= 2010 && int <= 2020 
    end

    def valid_expiration_year?(int)
      int >= 2020 && int <= 2030 
    end

    def valid_metric_height?(int)
      int >= 150 && int <= 193 
    end

    def valid_imperial_height?(int)
      int >= 59 && int <= 76 
    end

    def valid_height?(str)
      int = str.scan(/\d+/).first.to_i
      system = 'metric' if str.match?(/\d+cm/)
      system = 'imperial' if str.match?(/\d+in/)

      return false if system.nil?

      send("valid_#{system}_height?", int)
    end

    def valid_hair_colour?(str)
      str.match?(/#[0-9abcdef]{6}/)
    end

    def valid_eye_colour?(str)
      str.match?(/(amb|blu|brn|gry|grn|hzl|oth)/)
    end
  end
end
