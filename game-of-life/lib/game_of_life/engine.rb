require './lib/game_of_life/world'

module GameOfLife
  class Engine
    attr_reader :world

    def create_world
      # size = (3..22).to_a.sample
      # puts 'How many cells long and wide should the world be? '
      # p '> '
      # size = gets.chomp.to_i
      size = 22
      @world = World.new(size)
    end

    def seed_world
      n = (@world.size..(@world.size**2)).to_a.sample
      # puts 'How many cells do you want to seed? '
      # p '> '
      # n = gets.chomp.to_i
      @world.seed_grid(n)
    end

    def start
      counter = 0
      running = true
      while running
        system('clear')
        counter += 1
        puts Rainbow("Day: #{counter}").orange
        puts Rainbow("Population: #{@world.population}").orange
        puts "\n"
        puts @world.draw_grid.gsub('x', Rainbow('x').green)
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

# puts 'starting game'
# g = GameOfLife::Engine.new
# g.play
