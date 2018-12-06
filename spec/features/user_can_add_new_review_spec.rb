require 'rails_helper'

describe 'When a user visits a book show page' do
  it 'can go to new review page' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    
    visit book_path(book)
    
    click_on 'New Review' 
    
    expect(current_path).to eq(new_book_review_path(book))
  end
  
  it 'can create a new review' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    review_title = "Enjoyed it"
    user_name = "Me"
    rating = 5
    review_text = "Fabulous book loved every minute"
    
    visit new_book_review_path(book)
    
    fill_in :review_title, with: review_title
    fill_in :review_username, with: user_name
    fill_in :review_rating, with: rating
    fill_in :review_text, with: review_text
    click_button "Create Review"
    
    expect(current_path).to eq(book_path(book))
    expect(User.last.name).to eq(user_name)
    
    within "#review-#{Review.last.id}" do
      expect(page).to have_content(user_name)
      expect(page).to have_content(review_text)
      expect(page).to have_content(rating)
      expect(page).to have_content(review_title)
    end
  end
end