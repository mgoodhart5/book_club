require 'rails_helper'

describe 'When a user visits a book show page' do
  it 'can go to new review page' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    
    visit book_path(book)
    
    click_on 'New Review' 
    
    expect(current_path).to eq(new_book_review_path(book))
  end
end