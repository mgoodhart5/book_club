class Author < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors
end
