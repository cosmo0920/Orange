class BooksController < ApplicationController
  def index
    @books = Book.all.page params[:page]
  end

  def new
    @books = Book.new
  end

  def create
    @book = Book.new(create_book_params)
    if @book.save
      redirect_to books_path, notice: 'success: add book'
    else
      render :new
    end
  end

  private
  def create_book_params
    params.require(:book).permit(:isbn)
  end
end
