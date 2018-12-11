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
    select("books.*, avg(rating) as avg_rating").joins(:reviews).group(:id).order("avg_rating ASC")
  end
  
  def self.sorted_by_pages
    order(pages: :asc)
  end
  
  def self.sorted_by_review_amount
    select("books.*, count(reviews.id) as review_count")
    .left_joins(:reviews)
    .group(:id)
    .order("review_count ASC")
  end
end
