class Book < ActiveRecord::Base
  paginates_per 10
  validate :length_isbn

  def length_isbn
    unless isbn.length == 10 || isbn.length == 13
      errors.add(:isbn, "ISBN length must be 10 or 13")
    end
  end
end
