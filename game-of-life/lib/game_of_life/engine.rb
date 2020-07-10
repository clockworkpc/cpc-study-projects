require './lib/game_of_life/world'

module GameOfLife
  class Engine
    attr_reader :world

    def create_world
      puts 'How many cells long and wide should the world be? '
      p '> '
      size = gets.chomp.to_i
      @world = World.new(size)
    end

    def seed_world
      puts 'How many cells do you want to seed? '
      p '> '
      n = gets.chomp.to_i
      @world.seed_grid(n)
    end

    def start
      running = true
      while running
        system('clear')
        @world.draw_grid
        @world.toggle_grid
        sleep 0.1
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
