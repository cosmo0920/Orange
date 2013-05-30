class Book < ActiveRecord::Base
  paginates_per 10
  validates :isbn, :isbn_format => true
end
