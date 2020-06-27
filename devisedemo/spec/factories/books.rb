# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    title { Faker::Book.unique.title }
    author { create(:author) }
  end
end
