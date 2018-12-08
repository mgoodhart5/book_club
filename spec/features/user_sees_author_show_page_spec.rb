# As a Visitor,
# When I visit an author's show page
# I see all book titles by that author
# Each book should show its year of publication
# Each book should show its number of pages
# Each book should show a list of any other authors
# (exclude this show page's author from that list)

require 'rails_helper'

describe 'When a user visits an author show page' do
  it 'sees a list of books by that author' do
    author = Author.create(name: "Author One")
    book_1 = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_2 = author.books.create(title: "Book 2", pages: 2, publishing_year: 2002)
    
    visit author_path(author)
    
    expect(page).to have_content(author.name)
    within "book-#{book_1.id}" do
      expect(page).to have_content(book_1.title)
      expect(page). to have_content("Pages: #{book_1.pages}")
      expect(page). to have_content("Published in: #{book_1.pages}")
    end
    within "book-#{book_2.id}" do
      expect(page).to have_content(book_2.title)
      expect(page). to have_content("Pages: #{book_2.pages}")
      expect(page). to have_content("Published in: #{book_2.pages}")
    end
  end
end