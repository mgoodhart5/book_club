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
end
