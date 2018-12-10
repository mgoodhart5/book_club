require 'rails_helper'

describe 'When a user visits a book show page' do
  it 'can go to new review page' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)

    visit book_path(book)

    click_on 'New Review'

    expect(current_path).to eq(new_book_review_path(book))
  end

  it 'can create a new review rating limited 1-5' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    review_title = "Enjoyed it"
    user_name = "Me"
    rating = 5
    review_text = "Fabulous book loved every minute"

    visit new_book_review_path(book)

    fill_in :review_title, with: review_title
    fill_in :review_user, with: user_name
    select("#{rating}", :from => 'review_rating')
    fill_in :review_review_text, with: review_text
    click_button "Create Review"

    expect(current_path).to eq(book_path(book))
    expect(User.last.name).to eq(user_name)

    within "#review-#{Review.last.id}" do
      expect(page).to have_content(user_name)
      expect(page).to have_content(review_text)
      expect(page).to have_content("Rating: #{rating}")
      expect(page).to have_content(review_title)
    end
  end

  it 'should ensure user name is in title case' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    review_title = "Enjoyed it"
    user_name = "me too"
    user_name_titlecase = "Me Too"
    review_text = "Fabulous book loved every minute"
    rating = 3

    visit new_book_review_path(book)

    fill_in :review_title, with: review_title
    fill_in :review_user, with: user_name
    select("#{rating}", :from => 'review_rating')
    fill_in :review_review_text, with: review_text
    click_button "Create Review"

    expect(current_path).to eq(book_path(book))
    expect(User.last.name).to eq(user_name_titlecase)

    within "#review-#{Review.last.id}" do
      expect(page).to have_content(user_name_titlecase)
      expect(page).to have_content(review_text)
      expect(page).to have_content("Rating: #{rating}")
      expect(page).to have_content(review_title)
    end
  end

  it 'should ensure user name is unique' do
    book = Book.create(title: "Book 1", pages: 1, publishing_year: 2001)
    user = User.create(name: "Me Too")
    review_title = "Enjoyed it"
    user_name = "Me Too"
    rating = 2
    review_text = "Fabulous book loved every minute"

    visit new_book_review_path(book)

    fill_in :review_title, with: review_title
    fill_in :review_user, with: user_name
    select("#{rating}", :from => 'review_rating')
    fill_in :review_review_text, with: review_text
    click_button "Create Review"

    expect(current_path).to eq(book_path(book))
    expect(user.id).to eq(User.last.id)

    within "#review-#{Review.last.id}" do
      expect(page).to have_content(user_name)
      expect(page).to have_content(review_text)
      expect(page).to have_content("Rating: #{rating}")
      expect(page).to have_content(review_title)
    end
  end
end
