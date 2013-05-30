require 'spec_helper'

describe BooksController do
	let!(:book) { FactoryGirl.create(:book) }
	before do
		visit books_path
	end

	it { page.should have_selector('body table tr') }
	it { page.should have_content(book.title) }
end
