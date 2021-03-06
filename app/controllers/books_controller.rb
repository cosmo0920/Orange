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

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(update_book_params)
      redirect_to books_path, notice: 'update book'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'delete book'
  end

  def search
    redirect_to books_path, notice: "Not Found" and return if params[:title].blank?

    @books = Book.search(params[:title])
  end

  private
  def create_book_params
    params.require(:book).permit(:isbn)
  end

  def update_book_params
    params.require(:book).permit(:title, :image_url)
  end
end
