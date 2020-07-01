# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  check_third_side = lambda do |x, y|
    if y > (x * 1.5)
      raise TriangleError
    else
      :isosceles
    end
  end

  raise TriangleError if (a <= 0) || (b <= 0) || (c <= 0)

  if (a == b) && (a == c) && (b == c)
    :equilateral
  elsif a == b
    check_third_side.call(b, c)
  elsif a == c
    check_third_side.call(c, b)
  elsif b == c
    check_third_side.call(c, a)
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
