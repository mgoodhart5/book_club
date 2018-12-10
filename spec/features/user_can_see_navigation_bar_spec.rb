require 'rails_helper'

describe 'As a visitor to our app' do
  it 'can see and use a navigation bar' do
    visit books_path
    
    within "#navigation" do
      click_link "Home" 
    end
    expect(current_path).to eq(root_path)
    
    within "#navigation" do
      click_link "Books"
    end
    expect(current_path).to eq(books_path)
  end
end