class Book < ApplicationRecord
  validates_presence_of :title, :pages, :publishing_year
  validates_uniqueness_of :title

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews

  def average_rating
    reviews.average(:rating)
  end

  def total_reviews
    reviews.count
  end

  def self.sorted_books_rating
    select("books.*, avg(rating) as avg_rating").joins(:reviews).group(:id).order("avg_rating DESC")
  end
end
