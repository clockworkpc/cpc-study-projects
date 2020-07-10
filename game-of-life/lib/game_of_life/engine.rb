require './lib/game_of_life/world'

module GameOfLife
  class Engine
    attr_reader :world

    def create_world
      size = 22
      @world = World.new(size)
    end

    def seed_world
      n = (@world.size..(@world.size**2)).to_a.sample
      @world.seed_grid(n)
    end

    def display_statistics
      puts Rainbow("Day: #{@counter}").orange
      puts Rainbow("Population: #{@world.population}").orange

      diff = @population.last - @population[-2].to_i
      diff_colour = diff < 0 ? :red : :green
      puts Rainbow("Difference: #{diff}").send(diff_colour)
      puts @world.draw_grid.gsub('x', Rainbow('x').green)
    end

    def start
      @counter = 0
      running = true
      @population = []
      while running
        system('clear')
        @counter += 1
        @population << @world.population
        display_statistics

        @world.toggle_grid
        sleep 0.5
      end
    end

    def play
      create_world
      seed_world
      start
    end
  end
end
