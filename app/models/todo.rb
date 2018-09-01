class Todo < ApplicationRecord
  has_many :notes
  
  validates :title, presence: true
end
