module AdventOfCode
  class PassportProcessing
    DICTIONARY = {
      'byr' => :birth_year,
      'iyr' => :issue_year,
      'eyr' => :expiration_year,
      'hgt' => :height,
      'hcl' => :hair_colour,
      'ecl' => :eyes_colour,
      'pid' => :passport_id,
      'cid' => :country_id
    }.freeze

    def passport(line)
      details = line.split(/[\s\n]/)
      details.each_with_object({}) do |str, hsh|
        next if str.empty?

        k, value = str.split(':')
        key = DICTIONARY[k]
        hsh[key] = value
      end
    end

    def passports(text)
      lines = text.split("\n\n")
      lines.map { |line| passport(line) }
    end

    def valid_passport_keys?(passport)
      required_fields = DICTIONARY.values.reject { |n| n == :country_id }
      (required_fields - passport.keys).empty?
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
      %w[amb blu brn gry grn hzl oth].include?(str)
    end

    def valid_passport_id?(str)
      str.match?(/\A\d{9}\Z/)
    end

    def valid_passport?(passport)
      return false unless valid_passport_keys?(passport)

      valid_birth_year?(passport[:birth_year].to_i) &&
        valid_issue_year?(passport[:issue_year].to_i) &&
        valid_expiration_year?(passport[:expiration_year].to_i) &&
        valid_height?(passport[:height]) &&
        valid_hair_colour?(passport[:hair_colour]) &&
        valid_eye_colour?(passport[:eyes_colour]) &&
        valid_passport_id?(passport[:passport_id])
    end

    def valid_passports_count(passports)
      passports.count { |passport| valid_passport?(passport) }
    end
  end
end
