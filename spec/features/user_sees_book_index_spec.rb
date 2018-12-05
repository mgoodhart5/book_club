require 'rails_helper'

describe 'as a visitor to the app' do
  it 'should show a list of the books' do
    book_1 = Book.create(title: "book_1", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "book_2", pages: 2, publishing_year: 2002)

    visit '/books'

    expect(page).to have_content(book_1.title)
    expect(page).to have_content("Pages: #{book_1.pages}")
    expect(page).to have_content("Published in: #{book_1.publishing_year}")
    expect(page).to have_content(book_2.title)
    expect(page).to have_content("Pages: #{book_2.pages}")
    expect(page).to have_content("Published in: #{book_2.publishing_year}")
  end

  it 'should show each books authors' do
    book_1 = Book.create(title: "book_1", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "book_2", pages: 2, publishing_year: 2002)
    author_1 = Author.create(name: "author_1")
    author_2 = Author.create(name: "author_2")
    BookAuthor.create(book_id: book_1.id, author_id: author_1.id)
    BookAuthor.create(book_id: book_2.id, author_id: author_2.id)

    visit '/books'

    within "#book-#{book_1.id}" do
      expect(page).to have_content(author_1.name)
    end
    within "#book-#{book_2.id}" do
      expect(page).to have_content(author_2.name)
    end
  end
end
