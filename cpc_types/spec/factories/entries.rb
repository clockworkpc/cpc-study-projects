FactoryBot.define do
  factory :entry do
    account { nil }
    tags { "MyString" }
    entryable_type { "MyString" }
    entryable_id { 1 }
  end
end
