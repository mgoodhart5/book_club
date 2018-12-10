require 'rails_helper'

describe 'When I visit the books index page' do
  it 'should be able to sort the books by average rating in ascending order' do
    book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
    book_3 = Book.create(title: "Book 33", pages: 3, publishing_year: 2003)
    book_4 = Book.create(title: "Book 44", pages: 4, publishing_year: 2004)
    user = User.create(name: "Steve")
    book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user)
    book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here", user: user)
    book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here", user: user)
    book_3.reviews.create(title: "Review 5", rating: 5, review_text: "Review 5 here", user: user)
    book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here", user: user)
    
    visit books_path
    
    within "#sort-bar" do
      click_link "Reviews Ascending"
    end
    
    expect(all('.book-section')[0]).to have_content(book_3.title)
    expect(all('.book-section')[1]).to have_content(book_2.title)
    expect(all('.book-section')[2]).to have_content(book_4.title)
    expect(all('.book-section')[3]).to have_content(book_1.title)
  end
  it 'should be able to sort the books by average rating in descending order' do
    book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
    book_3 = Book.create(title: "Book 33", pages: 3, publishing_year: 2003)
    book_4 = Book.create(title: "Book 44", pages: 4, publishing_year: 2004)
    user = User.create(name: "Steve")
    book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user)
    book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here", user: user)
    book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here", user: user)
    book_3.reviews.create(title: "Review 5", rating: 5, review_text: "Review 5 here", user: user)
    book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here", user: user)
    
    visit books_path
    
    within "#sort-bar" do
      click_link "Reviews Descending"
    end
    
    expect(all('.book-section')[0]).to have_content(book_1.title)
    expect(all('.book-section')[1]).to have_content(book_4.title)
    expect(all('.book-section')[2]).to have_content(book_2.title)
    expect(all('.book-section')[3]).to have_content(book_3.title)
  end
end