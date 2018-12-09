require 'rails_helper'

describe 'as a visitor to the app' do
  before(:each) do
    @book_1 = Book.create(title: "book_1", pages: 1, publishing_year: 2001)
    @book_2 = Book.create(title: "book_2", pages: 2, publishing_year: 2002)
  end
  it 'should show a list of the books' do

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Pages: #{@book_1.pages}")
      expect(page).to have_content("Published in: #{@book_1.publishing_year}")
    end
    within "#book-#{@book_2.id}" do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content("Pages: #{@book_2.pages}")
      expect(page).to have_content("Published in: #{@book_2.publishing_year}")
    end
  end

  it 'should show each books authors' do
    author_1 = Author.create(name: "author_1")
    author_2 = Author.create(name: "author_2")
    author_3 = Author.create(name: "author_3")
    BookAuthor.create(book_id: @book_1.id, author_id: author_1.id)
    BookAuthor.create(book_id: @book_2.id, author_id: author_2.id)
    BookAuthor.create(book_id: @book_2.id, author_id: author_3.id)

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(author_1.name)
    end
    within "#book-#{@book_2.id}" do
      expect(page).to have_content(author_2.name)
      expect(page).to have_content(author_3.name)
    end
  end

  it 'should be able to click on any authors name to see its show page' do
    author_1 = Author.create(name: "author 1")
    BookAuthor.create(book_id: @book_1.id, author_id: author_1.id)

    visit books_path

    within "#book-#{@book_1.id}" do
      click_link("#{author_1.name}")
    end
    expect(current_path).to eq(author_path(author_1))
  end
  it  'should have all book titles be links to the book show page' do
    visit books_path
    
    click_link(@book_1.title)
    
    expect(current_path).to eq(book_path(@book_1))
    expect(page).to have_content(@book_1.title)
  end
end
