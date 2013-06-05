class BooksController < ApplicationController
  CONFIG = YAML.load_file(Rails.root.join("config/amazon.yml"))
  def index
    @books = Book.all.page params[:page]
  end

  def new
    @books = Book.new
  end

  def create
    @book = Book.new(create_book_params)
    get_book_info
    if @book.save
      respond_to do |format|
        format.html { redirect_to books_path, notice: 'success: add book' }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_path, notice: 'error: add book' }
      end
    end
  end

  private
  def create_book_params
    params.require(:book).permit(:isbn)
  end

  def get_book_info
    client = A2z::Client.new(country: :jp, key: CONFIG['key'], secret: CONFIG['secret'], tag: CONFIG['tag'])
    response = client.item_lookup do
      category 'Books'
      id '9784274068669'
      id_type 'EAN'
    end
    @book.title = response.item.title
    @book.description = "book description"
    @book.image_url = ""
  end
end
