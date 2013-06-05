class Book < ActiveRecord::Base
  paginates_per 10
  validates :isbn, isbn_format: true
  # Internet ExplorerではGETで2048文字を超えるURLがエラーになるため
  validates :image_url, length: { maximum: 2048 }
  before_validation :get_book_info

  def get_book_info
    amazon = Amazon.new
    self.title = amazon.book_title

    # config = YAML.load_file(Rails.root.join("config" , "amazon.yml"))
    # client = A2z::Client.new(country: :jp, key: config['key'], secret: config['secret'], tag: config['tag'])
    # response = client.item_lookup do
    #   category 'Books'
    #   id '9784274068669'
    #   id_type 'EAN'
    # end
    # self.description = "book description"
    # self.image_url = ""
  end
end
