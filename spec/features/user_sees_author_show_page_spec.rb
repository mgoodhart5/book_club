require 'rails_helper'

describe 'When a user visits an author show page' do
  it 'sees a list of books by that author' do
    author = Author.create(name: "Author One")
    book_1 = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_2 = author.books.create(title: "Book 2", pages: 2, publishing_year: 2002)
    
    visit author_path(author)
    
    expect(page).to have_content(author.name)
    within "#book-#{book_1.id}" do
      expect(page).to have_content(book_1.title)
      expect(page). to have_content("Pages: #{book_1.pages}")
      expect(page). to have_content("Published in: #{book_1.publishing_year}")
    end
    within "#book-#{book_2.id}" do
      expect(page).to have_content(book_2.title)
      expect(page). to have_content("Pages: #{book_2.pages}")
      expect(page). to have_content("Published in: #{book_2.publishing_year}")
    end
  end
  it 'should see a list of other authors of a book' do
    author_1 = Author.create(name: "Author One")
    author_2 = Author.create(name: "Author Two")
    author_3 = Author.create(name: "Author Three")
    
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001, authors: [author_1, author_2, author_3])
    
    visit author_path(author_1)
    
    within "#book-#{book.id}" do
      expect(page).to have_content(author_2.name)
      expect(page).to have_content(author_3.name)
      expect(page).to_not have_content(author_1.name)
    end
  end
end