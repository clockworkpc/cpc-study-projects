# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    first_name { Faker::Name.unique.name.split.first }
    surname { Faker::Name.unique.name.split.last }
  end
end
