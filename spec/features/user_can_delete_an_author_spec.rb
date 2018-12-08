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
  it 'should delete all books associated with the author' do
    author = Author.create(name: "author_1")
    book = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_2 = author.books.create(title: "Book 2", pages: 1, publishing_year: 2001)
    
    visit author_path(author) 
    
    click_link "Delete Author" 
    
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(author.name)
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_content(book_2.title)
  end
  it 'should delete its own co-authored books but not the co-author' do
    author = Author.create(name: "author_1")
    author_2 = Author.create(name: "Author 2")
    book = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_2 = Book.create(authors: [author, author_2], title: "Book 2", pages: 1, publishing_year: 2001)
    book_3 = author_2.books.create(title: "Book 3", pages: 1, publishing_year: 2001)
    
    visit author_path(author) 
    
    click_link "Delete Author" 
    
    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(author.name)
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_content(book_2.title)
    expect(page).to have_content(author_2.name)
    expect(page).to have_content(book_3.title)
  end
end