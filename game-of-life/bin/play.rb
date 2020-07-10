require './lib/game_of_life/world.rb'
require './lib/game_of_life/engine.rb'

g = GameOfLife::Engine.new
pp g
g.play
