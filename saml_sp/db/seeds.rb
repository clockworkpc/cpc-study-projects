require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

create(:user,
       email: 'member@chameleoncreator.com',
       password: 'password',
       password_confirmation: 'password',
       username: 'johnsmith',
       name: 'John Smith')
