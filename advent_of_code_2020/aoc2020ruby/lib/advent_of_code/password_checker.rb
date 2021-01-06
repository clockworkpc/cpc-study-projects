module AdventOfCode
  class PasswordChecker
    def valid_password?(instance_range:, substring:, password:)
      instances = password.scan(substring)
      instance_range.include?(instances.count)
    end

    def convert_string_to_instance_range(string)
      # ints = string.split(/+d/)
    end

    def convert_line_to_password_ary(line)
      # instance_range = line.split[0].scan(/+d/)
    end

    def call(password_ary_ary)
      password_ary_ary.each_with_object([]) do |pw_ary, _ary|
        instance_range = pw_ary[0]
      end
    end
  end
end
