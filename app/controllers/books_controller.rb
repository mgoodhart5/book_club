class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    author = Author.create(name: author_params[:authors])
    book = author.books.create(book_params)
    redirect_to "/books/#{book.id}"
  end

  private

  def author_params
    params.require(:book).permit(:authors)
  end

  def book_params
    params.require(:book).permit(:title, :pages, :publishing_year)
  end
end
