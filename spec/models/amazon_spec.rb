require 'spec_helper'

unless ENV['CI']
  describe Amazon do
    let(:isbn) { '9784274068669' }
    let(:isbn_type) { 'EAN' }
    let(:amazon) {  Amazon.new(isbn, isbn_type) }

    describe "#book_title" do
      it { expect(amazon.book_title).to match(/Rails/) }
    end

    describe "#book_image_url" do
      it { expect(amazon.book_image_url).to eq('http://ecx.images-amazon.com/images/I/51Gibg-iYTL._SL75_.jpg') }
    end
  end
end
