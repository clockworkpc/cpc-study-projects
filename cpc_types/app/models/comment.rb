class Comment < ApplicationRecord
  belongs_to :post
  has_one :entry, as: :entryable
end
