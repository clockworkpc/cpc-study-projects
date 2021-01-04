module AdventOfCode
  class ExpenseReport
    def initialize(expenses)
      @expenses = expenses
    end

    def special_expenses(count: 2, req: 2020)
      # start with first element in array
      # running total
      m = @expenses.each_with_object([]) do |n, ary|
        ary = []
        ary << n if (ary.sum + n) <= req
        rest = @expenses[(@expenses.index(n) + 1)..-1]
        next_int = rest.find { |x| n + x <= req }

        next if next_int.nil?

        ary << next_int

        break ary if ary.sum == req && ary.count == count
      end

      require 'pry'; binding.pry if count == 3

      m

      # m = @expenses.each_with_object([]) do |n, ary|

      #   rest = @expenses[(@expenses.index(n) + 1)..-1]
      #   next_int = rest.find { |x| n + x <= req }

      #   next if next_int.nil?

      #   sum_total = n + next_int
      #   n_count += 1

      #   if sum_total == req && n_count == count
      #     ary <<

      #   end

      #   ary << next_int

      #   next if ary.count == count

      #   break ary if ary.sum == req

      #   ary = []

      #         p next_int

      #         ary << next_int
      #         ary.compact.flatten!

      #         break ary if ary.sum == req && ary.count == count
      # end

      # require 'pry'; binding.pry

      # if count == 2
      #   @expenses.each_with_object([]) do |n, ary|
      #     others = @expenses.reject { |x| x == n }
      #     match = others.select { |x| n + x == req }.first
      #     next unless match

      #     ary << [n, match]
      #     ary.flatten!
      #     break ary if ary.sum == req && ary.count == count
      #   end
      # elsif count == 3

      #   @expenses.each_with_object([]) do |n, ary|
      #     rest = @expenses[(@expenses.index(n) + 1)..-1]
      #     potential_matches = rest.select {|x| n + x < count}
      #     potential
      #   end

      #   [979, 366, 675]
      # end
    end

    # def special_expenses_extra(count: 3, req: 2020)
    #   @expenses.each_with_object([]) do |n, _ary|
    #     next if n > req

    #     pass1 = @expenses.reject { |x| x == n }

    #     pass1.each_with_object([]) do |n1, _ary1|
    #       first_sum = n + n1
    #       next if first_sum > req

    #       pass2 = pass1.reject { |y| (y == n || y == n1) }
    #     end
    #   end
    # end

    def special_expenses_product(count: 2)
      special_expenses(count: count).reject(&:zero?).inject(:*)
     end
  end
end
