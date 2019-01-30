class BooksController < ApplicationController

  def index
    if params[:sort]
      @books = Book.sort_by(params[:sort])
    else
      @books = Book.all
    end
    @sorted_books_rating = Book.sorted_books_rating
    @sorted_users_reviews = User.sorted_users_reviews
  end

  def show
    @book = Book.find(params[:id])
    @reviews_by_rating = @book.reviews_by_rating
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      redirect_to book_path(book)
    else
      render :edit
    end
  end

  def create
    split_authors = author_params[:name].split(",")
    multiple_authors = []
    split_authors.each do |author|
      multiple_authors << Author.find_or_create_by(name: author.strip)
    end
    book = Book.new(book_params)
    if book.save
      book.authors = multiple_authors
      redirect_to book_path(book.id)
    else
      redirect_to new_book_path
    end
  end

  def destroy
    Book.destroy(params[:id])
    redirect_to books_path
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
