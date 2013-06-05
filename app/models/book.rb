class Book < ActiveRecord::Base
  paginates_per 10
  validates :isbn, isbn_format: true
  # Internet ExplorerではGETで2048文字を超えるURLがエラーになるため
  #validates :image_url, length: { maximum: 2048 }
  before_save :get_book_info

  def isbn_type
    case isbn.try(:size)
    when 10
      "ISBN"
    when 13
      "EAN"
    else
      nil
    end
  end

  private
  def get_book_info #TODO: 名前を変更する
    amazon = Amazon.new(isbn, isbn_type)
    self.title = amazon.book_title
    self.image_url = amazon.book_image_url
    self.description = ""
  end
end
