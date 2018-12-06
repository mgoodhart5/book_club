require 'rails_helper'

describe 'as a visitor to the book index page' do
  it 'should let me navigate to a new book page' do

    visit books_path

    click_link "Add New Book"

    expect(current_path).to eq(new_book_path)
  end

  it 'should let fill out a form and create a new book' do
    book_title = "New Book"
    book_authors = "New Author"
    book_pages = 100
    book_publishing_year = 2000

    visit new_book_path

    fill_in :book_title, with: book_title
    fill_in :book_authors, with: book_authors
    fill_in :book_pages, with: book_pages
    fill_in :book_publishing_year, with: book_publishing_year

    click_button "Create Book"

    expect(current_path).to eq(book_path(Book.last.id))
    expect(page).to have_content(book_title)
  end
  it 'should ensure book and author titles are in title case' do
    book_title = "new book"
    title_case_book_title = "New Book"
    book_authors = "new author"
    title_case_book_authors = "New Author"
    book_pages = 100
    book_publishing_year = 2000

    visit new_book_path

    fill_in :book_title, with: book_title
    fill_in :book_authors, with: book_authors
    fill_in :book_pages, with: book_pages
    fill_in :book_publishing_year, with: book_publishing_year

    click_button "Create Book"

    expect(current_path).to eq(book_path(Book.last.id))
    expect(page).to have_content(title_case_book_title)
    expect(page).to have_content(title_case_book_authors)
  end
  it 'should ensure book titles are unique in the system' do
    Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    book_title = "Book 1"
    book_authors = "New Author"
    book_pages = 100
    book_publishing_year = 2000

    visit new_book_path

    fill_in :book_title, with: book_title
    fill_in :book_authors, with: book_authors
    fill_in :book_pages, with: book_pages
    fill_in :book_publishing_year, with: book_publishing_year

    click_button "Create Book"

    expect(current_path).to eq(new_book_path)
  end
  it 'should ensure author names are unique in the system' do
    author = Author.create(name: "New Author")
    book_title = "Book 1"
    book_authors = "New Author"
    book_pages = 100
    book_publishing_year = 2000

    visit new_book_path

    fill_in :book_title, with: book_title
    fill_in :book_authors, with: book_authors
    fill_in :book_pages, with: book_pages
    fill_in :book_publishing_year, with: book_publishing_year

    click_button "Create Book"

    expect(current_path).to eq(book_path(Book.last.id))
    expect(author.id).to eq(Author.last.id)
  end
end
