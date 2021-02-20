class Entry < ApplicationRecord
  belongs_to :account

  delegated_type :entryable, types: %w[Post Comment Repost]
end
