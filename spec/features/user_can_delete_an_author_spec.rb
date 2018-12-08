require 'rails_helper'

describe 'When a user visits an author show page' do
  it 'should see a link to delete the author' do
    author = Author.create(name: "author_1")
    book = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    
    visit author_path(author) 
    
    click_link "Delete Author" 
    
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(author.name)
    expect(page).to_not have_content(book.title)
  end
end