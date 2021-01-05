module AdventOfCode
  class ExpenseReport
    def initialize(expenses)
      @expenses = expenses
    end

    def add_up_elements_to_req(array: [], count: 2, req: 2020)
      array = array.empty? ? @expenses : array

      array.each_with_object([]) do |n, ary|
        ary << n
        pp n
        puts 'before'
        pp ary

        rest = array[(array.index(n) + 1)..-1]

        rest.each do |n1|
          ary << n1 if ary.sum + n1 <= req
          break ary if ary.count == count && ary.sum == req
        end

        puts 'after'
        pp ary
        ary = []
        pp ary
      end
    end

    def special_expenses(count: 2, req: 2020)
      if count == 2
        @expenses.each_with_object([]) do |n, ary|
          ary << n if (ary.sum + n) <= req
          rest = @expenses[(@expenses.index(n) + 1)..-1]
          next_int = rest.find { |x| n + x <= req }

          next if next_int.nil?

          ary << next_int

          break ary if ary.sum == req && ary.count == count

          ary = [] if @expenses[-1] == @expenses[@expenses.index(n)]
        end
      else
        add_up_elements_to_req(count: 3)
      end
    end

    def special_expenses_product(count: 2)
      special_expenses(count: count).reject(&:zero?).inject(:*)
    end
  end
end
