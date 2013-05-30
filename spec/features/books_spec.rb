require 'spec_helper'

describe BooksController do
	let!(:book) { FactoryGirl.create(:book) }
	before do
		visit books_path
	end

	it { page.should have_css('#booklist') }
	it { page.find('#booklist').should have_content(book.title) }
end
