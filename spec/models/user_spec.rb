require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
  describe 'relationships' do
    it { should have_many(:reviews) }
  end
  describe 'class methods' do
    describe '.sorted_users_reviews' do
      it 'should return a list of users sorted by number of reviews' do
        book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001)
        book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
        book_3 = Book.create(title: "Book 33", pages: 3, publishing_year: 2003)
        book_4 = Book.create(title: "Book 44", pages: 4, publishing_year: 2004)
        user_1 = User.create(name: "Steve")
        user_2 = User.create(name: "Brenna")
        user_3 = User.create(name: "Leigh")
        user_4 = User.create(name: "Logan")
        book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user_3)
        book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here", user: user_3)
        book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here", user: user_2)
        book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here", user: user_2)
        book_1.reviews.create(title: "Review 11", rating: 2, review_text: "Review 11 here", user: user_2)
        book_1.reviews.create(title: "Review 1111", rating: 2, review_text: "Review 11 here", user: user_2)
        book_2.reviews.create(title: "Review 22", rating: 4, review_text: "Review 22 here", user: user_1)
        book_3.reviews.create(title: "Review 33", rating: 5, review_text: "Review 3 here", user: user_3)
        book_4.reviews.create(title: "Review 44", rating: 3, review_text: "Review 4 here", user: user_4)
        book_1.reviews.create(title: "Review 111", rating: 2, review_text: "Review 11 here", user: user_4)
        sorted_users = [user_2, user_3, user_4, user_1]

        expect(User.sorted_users_reviews).to eq(sorted_users)
      end
    end
  end
end
