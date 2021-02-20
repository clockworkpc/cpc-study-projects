FactoryBot.define do
  factory :account do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
  end
end
