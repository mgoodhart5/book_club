class Book < ApplicationRecord
  validates_presence_of :title, :pages, :publishing_year
  validates_uniqueness_of :title

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy

  def average_rating
    reviews.average(:rating)
  end

  def total_reviews
    reviews.count
  end

  def reviews_by_rating
    reviews.order(rating: :asc)
  end

  def top_review
    reviews.order(:rating).last
  end

  def self.sorted_books_rating
    select("books.*, avg(rating) as avg_rating")
    .joins(:reviews)
    .group(:id)
    .order("avg_rating ASC")
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

  def self.sort_by(params_string)
    sort_type, sort_direction = params_string.split('-')
    if sort_type == 'rating' && sort_direction == 'asc'
      sorted_books_rating
    elsif sort_type == 'rating' && sort_direction == 'desc'
      sorted_books_rating.reverse
    elsif sort_type == 'pages' && sort_direction == 'asc'
      sorted_by_pages
    elsif sort_type == 'pages' && sort_direction == 'desc'
      sorted_by_pages.reverse
    elsif sort_type == 'reviews' && sort_direction == 'asc'
      sorted_by_review_amount
    elsif sort_type == 'reviews' && sort_direction == 'desc'
      sorted_by_review_amount.reverse
    end
  end


end
