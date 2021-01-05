module AdventOfCode
  class ExpenseReport
    def initialize(expenses)
      @expenses = expenses.sort.reverse
    end

    def find_next_int(ary, array_remainder, req_sum, req_count)
      array_remainder.find do |x|
        x_sum = ary.sum + x
        next if x_sum > req_sum

        last_int = ary.count == req_count - 1
        last_int ? x_sum == req_sum : x_sum <= req_sum
      end
    end

    def add_up_remaining_elements(ary, array_remainder, req_sum, req_count)
      array_remainder.count.times do
        next_int = find_next_int(ary, array_remainder, req_sum, req_count)
        next if next_int.nil?

        break if ary.sum == req_sum && ary.count == req_count

        ary << next_int
        array_remainder.shift
      end
    end

    def special_expenses(req_count: 2, req_sum: 2020)
      @expenses.each_with_object([]) do |n, ary|
        ary << n
        array_remainder = @expenses[(@expenses.index(n) + 1)..-1]
        add_up_remaining_elements(ary, array_remainder, req_sum, req_count)

        break ary if ary.sum == req_sum && ary.count == req_count

        ary.count.times { ary.shift }
      end
    end

    def special_expenses_product(req_count: 2, req_sum: 2020)
      special_expenses(req_count: req_count, req_sum: req_sum)
        .reject(&:zero?).inject(:*)
    end
  end
end
