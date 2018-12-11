class BooksController < ApplicationController

  def index
    if params[:rating] == 'asc'
      @books = Book.sorted_books_rating
    elsif params[:rating] == 'desc'
      @books = Book.sorted_books_rating.reverse
    elsif params[:pages] == 'asc'
      @books = Book.sorted_by_pages
    elsif params[:pages] == 'desc'
      @books = Book.sorted_by_pages.reverse
    elsif params[:reviews] == 'asc'
      @books = Book.sorted_by_review_amount
    elsif params[:reviews] == 'desc'
      @books = Book.sorted_by_review_amount.reverse
    else
      @books = Book.all
    end
    @sorted_books_rating = Book.sorted_books_rating
    @sorted_users_reviews = User.sorted_users_reviews
    
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    split_authors = author_params[:name].split(",")
    multiple_authors = []
    split_authors.each do |author|
      new_author = Author.new(name: author.strip)
      if new_author.save
        multiple_authors << new_author
      else
        multiple_authors << Author.find_by(name: author_params[:name])
      end
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
    book_authors = BookAuthor.where(book_id: params[:id])
    BookAuthor.delete(book_authors)
    Book.delete(params[:id])
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
