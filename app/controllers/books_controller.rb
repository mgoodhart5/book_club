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
    new_author = Author.new(author_params)
    if new_author.save
      author = new_author
    else
      author = Author.find_by(name: author_params[:name])
    end
    book = Book.new(book_params)
    if book.save
      author.books << book
      redirect_to book_path(book.id)
    else
      redirect_to new_book_path
    end
  end

  private

  def author_params
    initial_author_params = params.require(:book).permit(:authors)
    {name: initial_author_params[:authors].titlecase}
  end

  def book_params
    initial_params = params.require(:book).permit(:title, :pages, :publishing_year)
    {title: initial_params[:title].titlecase, pages: initial_params[:pages], publishing_year: initial_params[:publishing_year] }
  end
end
