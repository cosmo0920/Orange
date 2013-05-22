require 'spec_helper'

describe BooksController do
	it "adafsdafsdfasdf" do
		FactoryGirl.create(:book)
		visit books_path
		binding.pry
	end
end
