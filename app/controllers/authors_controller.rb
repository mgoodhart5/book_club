class AuthorsController < ApplicationController 
  def show
    @author = Author.find(params[:id])
  end
  
  def destroy
    author = Author.find(params[:id])
    books = author.books
    books.each do |book|
      Book.destroy(book.id)
    end
    Author.destroy(params[:id])
    redirect_to books_path
  end
end