require 'json'
require 'advent_of_code/set_up_project'
require 'advent_of_code/expense_report'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
