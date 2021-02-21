module Codewars
  class PeterBaker
    def cakes(recipe, available)
      return 0 if available.empty?

      div = ->(have, need) { have.nil? || have.zero? ? false : have / need }
      res = recipe.map { |k, v| div.call(available[k], v) }

      return 0 if res.include?(false)

      res.compact.min
    end
  end
end
