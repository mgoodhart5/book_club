require 'rails_helper'

describe 'when a user clicks on a users name for any book review' do
  it 'is taken to that users show page' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    user = User.create(name: "Steve")
    review = Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: book)

    visit book_path(book)

    click_link "#{user.name}"

    expect(page).to have_content(review.title)
    expect(current_path).to eq(user_path(user))
  end
  it 'is able to delete a review' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    user = User.create(name: "Steve")
    review = Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: book)
    review_2 = Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: book)
    review_3 = Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: book)

    visit user_path(user)

    expect(page).to have_content(review.title)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_3.title)

    within "#review-#{review.id}" do
      click_link "Delete Review"
    end

    expect(current_path).to eq(user_path(user))
    expect(page).to_not have_content(review.title)
    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_3.title)
  end
  it 'should have book titles be links to the book show page' do
    user = User.create(name: "Steve")
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: book)

    visit user_path(user)

    click_link(book.title)

    expect(current_path).to eq(book_path(book))
    expect(page).to have_content(book.title)
  end
end
describe 'when a user visits a user show page' do
  it 'should be able to click on a link and sort the reviews newest to oldest' do
    user = User.create(name: "Steve")
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_1 = Book.create(title: "Book 2", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 3", pages: 1, publishing_year: 2001)
    review_1 = Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: book, created_at: "2018-11-09 22:44:45")
    review_2 = Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: book_1, created_at: "2018-12-09 22:44:45")
    review_3 = Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: book_2, created_at: "2018-08-09 22:44:45")

    visit user_path(user)

    within "#sort-bar" do
      click_link "Ascending Chronological Order"
    end

    expect(all('.single-review-section')[0]).to have_content(review_3.title)
    expect(all('.single-review-section')[1]).to have_content(review_1.title)
    expect(all('.single-review-section')[2]).to have_content(review_2.title)
  end
  it 'should be able to click on a link and sort the reviews oldest to newest' do
    user = User.create(name: "Steve")
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_1 = Book.create(title: "Book 2", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 3", pages: 1, publishing_year: 2001)
    review_1 = Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: book, created_at: "2018-11-09 22:44:45")
    review_2 = Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: book_1, created_at: "2018-12-09 22:44:45")
    review_3 = Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: book_2, created_at: "2018-08-09 22:44:45")

    visit user_path(user)

    within "#sort-bar" do
      click_link "Descending Chronological Order"
    end

    expect(all('.single-review-section')[0]).to have_content(review_2.title)
    expect(all('.single-review-section')[1]).to have_content(review_1.title)
    expect(all('.single-review-section')[2]).to have_content(review_3.title)
  end
end
