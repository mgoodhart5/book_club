require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:publishing_year)}
    it {should validate_uniqueness_of(:title)}
  end

  describe 'relationships' do
    it {should have_many(:book_authors)}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many(:reviews)}
  end

  describe 'class methods' do
    describe '.sorted_books_rating' do
      book_1 = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
      book_2 = Book.create(title: "Book 2", pages: 2, publishing_year: 2002)
      book_3 = Book.create(title: "Book 3", pages: 3, publishing_year: 2003)
      book_4 = Book.create(title: "Book 4", pages: 4, publishing_year: 2004)
      book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here")
      book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here")
      book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here")
      book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here")
      sorted_books = [book_3, book_2, book_4, book_1]

      expect(Book.sorted_books_rating).to eq(sorted_books)
    end
  end

  describe 'instance methods' do
    describe '#average_rating' do
      it 'should return the average review rating for a book' do
        book = Book.new(title: "Book 1", pages: 234, publishing_year: 2002)
        user = User.create(name: "Steve")
        Review.create(title: "Hated it", rating: 2, review_text: "Would never read again.", user: user, book: book)
        Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: book)
        Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: book)
        average = 3

        expect(book.average_rating).to eq(average)
      end
    end
    describe '#total_reviews' do
      it 'should return the number of total reviews for a book' do
        book = Book.new(title: "Book 1", pages: 234, publishing_year: 2002)
        book_2 = Book.new(title: "Book 2", pages: 234, publishing_year: 2002)
        user = User.create(name: "Steve")
        Review.create(title: "Hated it", rating: 2, review_text: "Would never read again.", user: user, book: book)
        Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: book)
        Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: book)
        book_total_reviews = 3
        book_2_total_reviews = 0

        expect(book.total_reviews).to eq(book_total_reviews)
        expect(book_2.total_reviews).to eq(book_2_total_reviews)
      end
    end
  end
end
