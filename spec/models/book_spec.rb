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
end
