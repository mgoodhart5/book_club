class ReviewsController < ApplicationController
  
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  
  def create
    
  end
end