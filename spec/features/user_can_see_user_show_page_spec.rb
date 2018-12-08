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
end
