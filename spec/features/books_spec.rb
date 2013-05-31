require 'spec_helper'

describe BooksController do
  context "page should contain book title" do
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
      it { page.should have_css('nav.pagination') }
    end
    context "page should not have nav seletor when book.count <= 10" do
      let!(:book) { FactoryGirl.create_list(:book,10) }
      before do
        visit books_path
      end
      it { page.should_not have_css('nav.pagination') }
    end
    context "page should have submit button" do
      let!(:book) { FactoryGirl.create_list(:book,1) }
      before do
        visit new_book_path
      end
      it "should redirect_to books_path after click" do
        click_button("Create Book")
        current_path.should == books_path
      end
    end

  end
end
