class Review < ApplicationRecord
  
  validates_presence_of :title, :rating, :review_text
  
  belongs_to :book
  belongs_to :user
end