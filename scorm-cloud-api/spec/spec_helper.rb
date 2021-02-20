require 'json'
require 'scorm_cloud_api/set_up_project'
require 'dotenv/load'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
