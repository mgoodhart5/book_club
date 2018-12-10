class User < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :reviews

  def self.sorted_users_reviews
    select("users.*, count(reviews.id) as number_reviews").joins(:reviews).group(:id).order("number_reviews DESC")
  end

end
