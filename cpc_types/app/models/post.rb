class Post < ApplicationRecord
  has_one :entry, as: :entryable
end
