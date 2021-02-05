module AdventOfCode
  class HandheldHalting
    def instructions(text)
      counter = 0
      text.split("\n").each_with_object([]) do |line, ary|
        cmd = line.scan(/[a-z]{3}/).first.to_sym
        value = line.scan(/[\+\-]\d+/).first.to_i
        ary << { index: counter, cmd: cmd, value: value }
        counter += 1
      end
    end

    def execute(instructions)
      index = 0
      log = []
      accumulator = []

      loop do
        command = instructions.find { |hsh| hsh[:index] == index }
        # require 'pry'; binding.pry if log.include?(command)
        break if log.include?(command)

        # break if log.find_all { |cmd| cmd[:index] == command[:index] }.count > 1

        break if index == instructions.count

        case command[:cmd]
        when :acc
          accumulator << command[:value]
          index += 1
        when :jmp
          index += command[:value]
        when :nop
          index += 1
        end

        log << command
      end

      {
        accumulator: accumulator,
        log: log,
        index: index
      }
    end

    def accumulator_sum(text)
      res = execute(instructions(text))
      res[:accumulator].sum
    end
  end
end
