require 'spec_helper'

describe BooksController do
  context "page should contains book title" do
    let!(:book) { FactoryGirl.create(:book) }
    before do
      visit books_path
    end

    it { page.should have_css('#booklist') }
    it { page.find('#booklist').should have_content(book.title) }
  end
  context "paginator" do
    context "page should have nav seletor when book.count > 10" do
      let!(:book) { FactoryGirl.create_list(:book,12) }
      before do
        visit books_path
      end
      it { page.should have_selector('nav') }
    end
    context "page should not have nav seletor when book.count <= 10" do
      let!(:book) { FactoryGirl.create_list(:book,10) }
      before do
        visit books_path
      end
      it { page.should_not have_selector('nav') }
    end
  end
end
