require 'spec_helper'

describe BooksController do
	before do
		FactoryGirl.create(:book)
		visit books_path
	end

	it { page.should have_content 'Books#index' }
end
