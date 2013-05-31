class BooksController < ApplicationController
  def index
    @books = Book.all.page params[:page]
  end

  def new
    @books = Book.new
  end

  def create
    redirect_to books_path
  end
end
