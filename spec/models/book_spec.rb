require 'spec_helper'

describe Book do
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
