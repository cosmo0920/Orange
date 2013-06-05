require 'spec_helper'

describe BooksController do
  include_context "amazon_api_mock"

  describe "page should contain book title" do
    let(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
    end

    pending { page.should have_css('#booklist') }
    pending { page.find('#booklist').should have_content(book.title) }
  end

  describe "paginator" do
    context "page should have nav seletor when book.count > 10" do
      let!(:books) { FactoryGirl.create_list(:book,12) }
      before do
        visit books_path
      end
      pending { page.should have_css('nav.pagination') }
    end

    context "page should not have nav seletor when book.count <= 10" do
      let!(:books) { FactoryGirl.create_list(:book,10) }
      before do
        visit books_path
      end
      pending { page.should_not have_css('nav.pagination') }
    end
  end

  describe "page should have submit button" do
    let(:book) { FactoryGirl.create(:book) }

    before do
      visit new_book_path
      click_button("Create Book")
    end

    pending "should redirect_to books_path after click" do
      current_path.should == books_path
    end
  end
end
