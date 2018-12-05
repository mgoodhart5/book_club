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
    
  end
end