# frozen_string_literal: true

require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

authors = []
5.times { authors << create(:author) }

authors.each do |author|
  rand(1..3).times { create(:book, author: author) }
end

create(:user, email: 'test@cpc.com.au', password: 'password')
