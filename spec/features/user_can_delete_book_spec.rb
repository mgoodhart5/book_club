require 'rails_helper'

describe 'As a visitor to a book show page' do
  it 'has a link to delete the book' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 2", pages: 2, publishing_year: 2001)
    book_id = book.id
    
    visit book_path(book)
    
    click_link 'Delete Book'
    
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_css("#book-#{book_id}")
    expect(page).to have_content(book_2.title)
  end
  it 'can delete a book with an author' do
    author = Author.create(name: "Author 1")
    book = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_id = book.id
    
    visit book_path(book)
    
    click_link 'Delete Book'
    
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_content(author.name)
    expect(page).to_not have_css("#book-#{book_id}")
  end
end