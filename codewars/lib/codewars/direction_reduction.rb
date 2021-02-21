module Codewars
  class DirectionReduction
    def opposite?(dir, ary)
      (dir == 'NORTH' && ary.last == 'SOUTH') ||
        (dir == 'SOUTH' && ary.last == 'NORTH') ||
        (dir == 'EAST' && ary.last == 'WEST') ||
        (dir == 'WEST' && ary.last == 'EAST')
    end

    def dir_reduc(array)
      array.each_with_object([]) do |dir, ary|
        if opposite?(dir, ary)
          ary.pop
        else
          ary << dir
        end
      end
    end

    def dirReduc(a)
      dir_reduc(a)
    end
  end
end
