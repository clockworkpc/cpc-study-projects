FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_str = Faker::Internet.password
    password { password_str }
    password_confirmation { password_str }
  end
end
