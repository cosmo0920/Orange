require 'spec_helper'

describe Book do
	describe ".page" do
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

  describe "length_isbn" do
    context "Valid ISBN13 Length" do
		  let(:valid_isbn13_length) { FactoryGirl.attributes_for(:book, isbn: Forgery::Basic.text(exactly: 13)) }
		  subject { Book.new(valid_isbn13_length) }
      it { subject.valid?.should be_true }
    end

    context "Valid ISBN10 Length" do
		  let(:valid_isbn10_length) { FactoryGirl.attributes_for(:book, isbn: Forgery::Basic.text(exactly: 10)) }
		  subject { Book.new(valid_isbn10_length) }
      it { subject.valid?.should be_true }
    end

    context "InValid ISBN Length" do
		  let(:invalid_isbn_length) { FactoryGirl.attributes_for(:book, isbn: Forgery::Basic.text(exactly: 12)) }
		  subject { Book.new(invalid_isbn_length) }
      it { subject.valid?.should_not be_true }
    end
  end
end
