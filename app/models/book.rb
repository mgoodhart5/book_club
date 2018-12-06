class Book < ApplicationRecord
  validates_presence_of :title, :pages, :publishing_year
  validates_uniqueness_of :title
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews
end
