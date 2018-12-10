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

  it 'should see average book rating next to book title' do
    user = User.create(name: "Steve")
    Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: @book_1)
    Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: @book_1)
    Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: @book_1)

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content("Average Rating: #{@book_1.average_rating.to_f.round(1)}")
    end
  end

  it 'should see total number of reviews next to each book' do
    user = User.create(name: "Steve")
    Review.create(title: "Hated it", rating: 1, review_text: "Would never read again.", user: user, book: @book_1)
    Review.create(title: "Fine", rating: 5, review_text: "It's okay.", user: user, book: @book_1)
    Review.create(title: "Genius", rating: 2, review_text: "Loved it!.", user: user, book: @book_1)

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content("Total Number of Reviews: #{@book_1.total_reviews}")
    end
    within "#book-#{@book_2.id}" do
      expect(page).to have_content("Total Number of Reviews: #{@book_2.total_reviews}")
    end
  end

  it "should see an area showing statistics of three highest rated books with title and score" do
    book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
    book_3 = Book.create(title: "Book 33", pages: 3, publishing_year: 2003)
    book_4 = Book.create(title: "Book 44", pages: 4, publishing_year: 2004)
    user = User.create(name: "Steve")
    book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user)
    book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here", user: user)
    book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here", user: user)
    book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here", user: user)

    visit books_path

    within "#stats-high" do
      expect(page).to have_content(book_3.title)
      expect(page).to have_content("Average Rating: #{book_3.average_rating}")
      expect(page).to have_content(book_2.title)
      expect(page).to have_content("Average Rating: #{book_2.average_rating}")
      expect(page).to have_content(book_4.title)
      expect(page).to have_content("Average Rating: #{book_4.average_rating}")
      expect(page).to_not have_content(book_1.title)
    end
  end
  it "should see an area showing statistics of three lowest rated books with title and score" do
    book_1 = Book.create(title: "Book 11", pages: 1, publishing_year: 2001)
    book_2 = Book.create(title: "Book 22", pages: 2, publishing_year: 2002)
    book_3 = Book.create(title: "Book 33", pages: 3, publishing_year: 2003)
    book_4 = Book.create(title: "Book 44", pages: 4, publishing_year: 2004)
    user = User.create(name: "Steve")
    book_1.reviews.create(title: "Review 1", rating: 2, review_text: "Review 1 here", user: user)
    book_2.reviews.create(title: "Review 2", rating: 4, review_text: "Review 2 here", user: user)
    book_3.reviews.create(title: "Review 3", rating: 5, review_text: "Review 3 here", user: user)
    book_4.reviews.create(title: "Review 4", rating: 3, review_text: "Review 4 here", user: user)

    visit books_path

    within "#stats-low" do
      expect(page).to have_content(book_1.title)
      expect(page).to have_content("Average Rating: #{book_1.average_rating}")
      expect(page).to have_content(book_2.title)
      expect(page).to have_content("Average Rating: #{book_2.average_rating}")
      expect(page).to have_content(book_4.title)
      expect(page).to have_content("Average Rating: #{book_4.average_rating}")
      expect(page).to_not have_content(book_3.title)
    end
  end
end
