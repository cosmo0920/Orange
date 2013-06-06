class Amazon
  def initialize(isbn, isbn_type)
    @isbn = isbn
    @isbn_type = isbn_type

    @config = YAML.load_file(Rails.root.join("config" , "amazon.yml"))
    @client = A2z::Client.new(country: :jp, key: @config['key'], secret: @config['secret'], tag: @config['tag'])
  end

  def book_title
    @book_title ||= book_title_lookup(@client, @isbn, @isbn_type)
  end

  def book_image_url
    @book_image_url ||= book_image_url_lookup(@client, @isbn, @isbn_type)
  end

  private
  def book_title_lookup(client, isbn, isbn_type)
    response = client.item_lookup do
      category 'Books'
      id isbn
      id_type isbn_type
    end

    response.item.title
  end

  def book_image_url_lookup(client, isbn, isbn_type)
    response = client.item_lookup do
      category 'Books'
      response_group 'Images'
      id isbn
      id_type isbn_type
    end

    response.item.small_image.url
  end
end
