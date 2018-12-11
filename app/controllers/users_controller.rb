class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if params[:rating] == 'asc'
      @reviews = @user.sort_reviews_chronologically
    else
      @reviews = @user.reviews
    end
  end
end
