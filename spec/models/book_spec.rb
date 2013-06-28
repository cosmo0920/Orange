# -*- coding: utf-8 -*-
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

  describe ".search" do
    context "when exact match title" do
      named_let(:search_title) { "列車本" }
      let!(:book) { FactoryGirl.create(:book, title: search_title) }
      subject { Book.search(search_title) }

      it { subject.first.title.should eq(search_title) }
    end

    context "when partialliy match title" do
      named_let(:search_title_partial) { "列車" }
      named_let(:search_title) { "列車本" }
      let!(:book) { FactoryGirl.create(:book, title: search_title) }
      subject { Book.search(search_title_partial) }

      it { subject.first.title.should eq(search_title) }
    end

    context "when no result" do
      named_let(:search_title_no_match) { "Rails" }
      named_let(:search_title) { "列車本" }
      named_let(:no_result) { Book.none }
      let!(:book) { FactoryGirl.create(:book, title: search_title) }
      subject { Book.search(search_title_no_match) }

      it { subject.should match_array(no_result) }
    end
  end
end
