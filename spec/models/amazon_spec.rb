require 'spec_helper'

unless ENV['CI']
  describe Amazon do
    let(:isbn) { '9784274068669' }
    let(:isbn_type) { 'EAN' }
    let(:amazon) {  Amazon.new(isbn, isbn_type) }
    named_let(:image_url) { 'http://ecx.images-amazon.com/images/I/51Gibg-iYTL._SL75_.jpg' }

    describe "#book_title" do
      it { expect(amazon.book_title).to match(/Rails/) }
    end

    describe "#book_image_url" do
      it { expect(amazon.book_image_url).to eq(image_url) }
    end
  end
end
