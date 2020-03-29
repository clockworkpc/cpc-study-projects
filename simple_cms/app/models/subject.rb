class Subject < ApplicationRecord

  has_one :page

  scope :visible, -> { where(visible: true) }
  scope :invisible, -> { where(visible: false) }
  scope :sorted, -> { order('position ASC') } 
  scope :search, lambda { |query| where(["name LIKE ?", "%#{query}%"]) }
end
