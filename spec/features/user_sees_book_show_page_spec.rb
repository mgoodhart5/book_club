require 'rails_helper'

describe 'As a visitor to the book show page' do
  before(:each) do
    @book_1 = Book.create(title: "book_1", pages: 1, publishing_year: 2001)
    @book_2 = Book.create(title: "book_2", pages: 2, publishing_year: 2002)
    @author_1 = @book_1.authors.create(name: "Author 1")
  end
  it 'should show the book title, authors, and number of pages' do
    visit book_path(@book_1)
    
    expect(page).to have_content(@book_1.title)
    expect(page).to have_content("Pages: #{@book_1.pages}")
    expect(page).to have_content("Published in: #{@book_1.publishing_year}")
    expect(page).to have_content(@author_1.name)
    
    expect(page).to_not have_content(@book_2.title)
    expect(page).to_not have_content("Pages: #{@book_2.pages}")
  end
  it 'should see a list of reviews for that book' do
    user_1 = User.create(name: "User 1")
    review_1 = user_1.reviews.create(title: "Review 1", rating: 4, review_text: "It was pretty good.", book: @book_1) 
    user_2 = User.create(name: "User 2")
    review_2 = user_2.reviews.create(title: "Review 2", rating: 3, review_text: "It was pretty ok.", book: @book_1) 
    
    visit book_path(@book_1)
    
    within "#review-#{review_1.id}" do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content("Reviewed By: #{review_1.user.name}")
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content("Review: #{review_1.review_text}")
    end
    within "#review-#{review_2.id}" do
      expect(page).to have_content(review_2.title)
      expect(page).to have_content("Reviewed By: #{review_2.user.name}")
      expect(page).to have_content("Rating: #{review_2.rating}")
      expect(page).to have_content("Review: #{review_2.review_text}")
    end
  end
end