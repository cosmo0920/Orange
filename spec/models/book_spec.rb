require 'spec_helper'

describe Book do
  include_context "amazon_api_mock"

	describe "pagination" do
		before { FactoryGirl.create_list(:book,12) }

		context "page 1" do
			subject { Book.page(1) }
			it { subject.count.should eq 10 }
		end

		context "page 2" do
			subject { Book.page(2) }
			it { subject.count.should eq 2 }
		end
	end

  describe "validation" do
    describe "isbn_is_appropriate" do
      context "valid ISBN13" do
	  	  let(:book) { FactoryGirl.build(:book, isbn: "9784797363821") }
	  	  subject { book }
        it { subject.should be_valid }
      end

      context "vaild ISBN10" do
	  	  let(:book) { FactoryGirl.build(:book, isbn: "4894717115") }
	  	  subject { book }
        it { subject.should be_valid }
      end

      context "InValid ISBN" do
	  	  let(:book) { FactoryGirl.build(:book, isbn: Forgery::Basic.text(exactly: 12).to_s) }
	  	  subject { book }
        it { subject.should_not be_valid }
      end
    end
  end

  describe "#isbn_type" do
    context 'EAN' do
      let(:book) { FactoryGirl.build(:book, isbn: "9784797363821") }
      it { expect(book.isbn_type).to eq("EAN") }
    end

    context 'ISBN' do
	  	let(:book) { FactoryGirl.build(:book, isbn: "4894717115") }
      it { expect(book.isbn_type).to eq("ISBN") }
    end
  end
end
