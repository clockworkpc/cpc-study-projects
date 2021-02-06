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

    def run(command, index, accumulator)
      case command[:cmd]
      when :acc
        accumulator << command[:value]
        index += 1
      when :jmp
        index += command[:value]
      when :nop
        index += 1
      end
    end

    def execute(instructions)
      index = 0
      log = []
      accumulator = []

      loop do
        command = instructions.find { |hsh| hsh[:index] == index }

        break if log.include?(command)

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

    def toggle_command(command)
      command[:cmd] = :nop if command[:cmd] == :jmp
      command[:cmd] = :jmp if command[:cmd] == :nop
      command
    end

    def meta_execute(text)
      instructions = instructions(text)
      jmp_nop_entries = instructions.find_all { |hsh| %i[jmp nop].include?(hsh[:cmd]) }

      res = execute(instructions)
      return res if res[:index] == instructions.count

      loop do
        dup_instructions = instructions.map(&:dup)
        error= jmp_nop_entries.last
        pp error
        error_index = error[:index]
        toggle_command( dup_instructions[error_index] )
        jmp_nop_entries.pop
        res = execute(dup_instructions)
        puts "Index: #{res[:index]}"
      pp res[:accumulator].sum
        break res if res[:index] == instructions.count

        break if jmp_nop_entries.empty?
      end

      # pp res[:accumulator].sum
      res
    end

    def accumulator_sum(text)
      res = execute(instructions(text))
      res[:accumulator].sum
    end
  end
end
