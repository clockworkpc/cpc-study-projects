module AdventOfCode
  class SledPasswordChecker
    def valid_password?(instance_range:, substring:, password:)
      instances = password.scan(substring)
      instance_range.include?(instances.count)
    end

    def instance_range(string)
      ints = string.scan(/\d+/).map(&:to_i)

      case ints.count
      when 2
        (ints.first..ints.last)
      when 1
        (ints.first..ints.first)
      end
    end

    def password_array(line)
      split = line.split
      instance_range = instance_range(split[0])
      substring = split[1].delete_suffix(':')
      password = split[2]
      [instance_range, substring, password]
    end

    def valid_passwords(line_ary)
      password_ary_ary = line_ary.map { |line| password_array(line) }

      password_ary_ary.each_with_object([]) do |pw_ary, ary|
        instance_range = pw_ary[0]
        substring = pw_ary[1]
        password = pw_ary[2]
        ary << password if valid_password?(instance_range: instance_range,
                                           substring: substring,
                                           password: password)
      end
    end
  end
end
