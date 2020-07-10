require 'json'
require 'game_of_life/set_up_project'
require 'game_of_life/world'
require 'game_of_life/engine'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
