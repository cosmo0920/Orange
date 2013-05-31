class Book < ActiveRecord::Base
  paginates_per 10
  validates :isbn, isbn_format: true
  # Internet ExplorerではGETで2048文字を超えるURLがエラーになるため
  validates :image_url, length: { maximum: 2048 }
end
