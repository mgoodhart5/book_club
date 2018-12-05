require 'rails_helper'

describe 'as a visitor to the book index page' do
  it 'should let me navigate to a new book page' do

    visit books_path

    click_link "Add New Book"

    expect(current_path).to eq(new_book_path)
  end
end
