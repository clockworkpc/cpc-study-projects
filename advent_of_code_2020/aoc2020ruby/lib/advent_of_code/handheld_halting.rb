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

    def execute_instructions(text)
      index = 0
      log = []
      accumulator = []
      instructions = instructions(text)

      running = true
      while running
        command = instructions.find { |hsh| hsh[:index] == index }
        if log.include?(command)
          puts 'Repeated command'
          pp command
          puts 'Previous command'
          pp log.last
          break

        end
        # break if log.include?(command)

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
      pp log
      accumulator
    end

    def accumulator_sum(text)
      execute_instructions(text).sum
    end

    # def execute_instructions(text, start_key = 0)
    #   log = []
    #   accumulator = []
    #   instructions = instructions(text)

    #   # require 'pry'; binding.pry
    #   instructions[start_key..-1].each do |key, hsh|
    #     pp log
    #     break if log.include?(key)

    #     log << key

    #     key_int = key.to_s.scan(/\d+/).first.to_i
    #     cmd = hsh.keys.first
    #     v = hsh.values.first

    #     case cmd
    #     when :acc
    #       accumulator << v
    #     when :jmp
    #       new_start_key = key_int + v
    #       execute_instructions(text, new_start_key)
    #     end
    #   end
    # end
  end
end
