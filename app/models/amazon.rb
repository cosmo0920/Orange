class Amazon
  def initialize(isbn, isbn_type)
    @isbn = isbn
    @isbn_type = isbn_type

    @config = YAML.load_file(Rails.root.join("config" , "amazon.yml"))
    @client = A2z::Client.new(country: :jp, key: @config['key'], secret: @config['secret'], tag: @config['tag'])
  end

  def book_title
    return @book_title unless @book_title.blank?

    isbn, isbn_type = @isbn, @isbn_type #TODO: block内で利用できない.スコープを確認

    response = @client.item_lookup do
      category 'Books'
      id isbn
      id_type isbn_type
    end

    @book_title = response.item.title
    @book_title
  end

  def book_image_url
    return @book_image_url unless @book_image_url.blank?

    isbn, isbn_type = @isbn, @isbn_type #TODO: block内で利用できない.スコープを確認

    response = @client.item_lookup do
      category 'Books'
      response_group 'Images'
      id isbn
      id_type isbn_type
    end

    @book_image_url = response.item.small_image.url
    @book_image_url
  end
end
