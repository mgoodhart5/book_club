class ReviewsController < ApplicationController
  
  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end
  
  def create
    book = Book.find(params[:book_id])
    user = User.create(user_params)
    review = user.reviews.create(review_params)
    book.reviews << review
    
    redirect_to book_path(book)
  end
  
  private
  
  def user_params
    initial_user_params = params.require(:review).permit(:user)
    {name: initial_user_params[:user]}
  end
  
  def review_params
    params.require(:review).permit(:title, :rating, :review_text)
  end
end