# -*- coding: utf-8 -*-
class Book < ActiveRecord::Base
  paginates_per 10
  validates :isbn, isbn_format: true , uniqueness: true
  validates :title, presence: true, on: :update
  # Internet ExplorerではGETで2048文字を超えるURLがエラーになるため
  #validates :image_url, length: { maximum: 2048 }
  before_create :amazon_title
  before_create :amazon_image_url

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
  def amazon
    @amazon ||= Amazon.new(isbn, isbn_type)
  end

  def amazon_title
    self.title = amazon.book_title
  end

  def amazon_image_url
    self.image_url = amazon.book_image_url
  end
end
