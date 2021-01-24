module AdventOfCode
  class CustomCustoms
    QUESTIONS = ('a'..'z').to_a

    def res_individual(line)
      line.split('')
          .find_all { |char| QUESTIONS.include?(char) }
          .uniq
    end

    def yes_individual(line)
      res_individual(line).count
    end

    def res_group(lines)
      lines.split("\n").map { |line| res_individual(line) }
    end

    def res_groups(text)
      lines_ary = text.split("\n\n").reject(&:empty?)
      lines_ary.map { |lines| res_group(lines).flatten }
    end

    ## Part 1

    def yes_group_any(lines)
      res_group(lines).flatten.uniq.count
    end

    def yes_groups_any(text)
      lines_ary = text.split("\n\n").reject(&:empty?)
      lines_ary.sum { |lines| yes_group_any(lines) }
    end

    ## Part 2

    def yes_group_all(lines)
      res_ary = res_group(lines)
      size = res_ary.size
      string = res_ary.flatten.sort.join
      QUESTIONS.map { |q| string.scan(/#{q}{#{size}}/) }
               .count { |str| !str.empty? }
    end

    def yes_groups_all(text)
      lines_ary = text.split("\n\n").reject(&:empty?)
      yess = lines_ary.map { |line| yes_group_all(line) }
      yess.sum
    end
  end
end
