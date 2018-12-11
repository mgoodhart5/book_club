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
  it 'should show all book titles as links' do
    author = Author.create(name: "Author One")
    book = author.books.create(title: "Book 1", pages: 1, publishing_year: 2001)

    visit author_path(author)

    click_link(book.title)

    expect(current_path).to eq(book_path(book))
    expect(page).to have_content(book.title)
  end
  it 'should show top review next to each book' do
    author = Author.create(name: "Author One")
    book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001, author: author)
    book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
    user_1 = User.create(name: "Steve")
    user_2 = User.create(name: "Bob")
    review_1 = book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user_1)
    review_2 = book_2.reviews.create(title: "Review 2", rating: 1, review_text: "Review 1 here", user: user_1)
    review_3 = book_2.reviews.create(title: "Review 3", rating: 4, review_text: "Review 2 here", user: user_2)
    review_4 = book_2.reviews.create(title: "Review 44", rating: 5, review_text: "Review 2 here", user: user_2)
    
    visit author_path(author)
    
    within "book-#{book_1.id}" do
      expect(page).to have_content(review_1.title)
      expect(page).to have_content("Rating: #{review_1.rating}")
      expect(page).to have_content("By: #{review_1.user.name}")
    end
    within "book-#{book_2.id}" do
      expect(page).to have_content(review_4.title)
      expect(page).to have_content("Rating: #{review_4.rating}")
      expect(page).to have_content("By: #{review_4.user.name}")
    end
  end
end
