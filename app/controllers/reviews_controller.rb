class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user = User.new(user_params)
    unless user.save
      user = User.find_by(name: user_params[:name])
    end
    review = user.reviews.create(review_params)
    book.reviews << review
    redirect_to book_path(book)
  end

  def destroy
    review = Review.find(params[:id])
    user = review.user
    Review.destroy(review.id)
    redirect_to user_path(user)
  end

  private

  def user_params
    initial_user_params = params.require(:review).permit(:user)
    { name: initial_user_params[:user].titlecase }
  end

  def review_params
    params.require(:review).permit(:title, :rating, :review_text)
  end
end
