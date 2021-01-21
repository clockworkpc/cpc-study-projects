module AdventOfCode
  class TobogganPasswordChecker
    def valid_password?(positions:, substring:, password:)
      characters = positions.map { |i| password[i - 1] }
      matches = characters.find_all { |c| c.eql?(substring) }
      matches.count == 1
    end

    def positions(string)
      string.scan(/\d+/).map(&:to_i)
    end

    def password_array(line)
      split = line.split
      positions = positions(split[0])
      substring = split[1].delete_suffix(':')
      password = split[2]
      [positions, substring, password]
    end

    def valid_passwords(line_ary)
      password_ary_ary = line_ary.map { |line| password_array(line) }

      password_ary_ary.each_with_object([]) do |pw_ary, ary|
        positions = pw_ary[0]
        substring = pw_ary[1]
        password = pw_ary[2]
        ary << password if valid_password?(positions: positions,
                                           substring: substring,
                                           password: password)
      end
    end
  end
end
