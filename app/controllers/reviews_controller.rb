class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book_id])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user = User.find_or_create_by(user_params)
    if user.reviews.find do |review|
      review.book == book
      end
      redirect_to new_book_review_path(book)
    else
      review = user.reviews.create(review_params)
      book.reviews << review
      redirect_to book_path(book)
    end
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
