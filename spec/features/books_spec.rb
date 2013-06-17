require 'spec_helper'

describe BooksController do
  include_context "amazon_api_mock"

  describe "page should contain book title and img" do
     let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
    end

    it { page.should have_css('#booklist') }
    it { page.find('#booklist').should have_content(book.title) }
    it { page.should have_css(".book_image") }
  end

  describe "paginator" do
    context "page should have nav seletor when book.count > 10" do
      let!(:books) { FactoryGirl.create_list(:book,12) }
      before do
        visit books_path
      end
      it { page.should have_css('nav.pagination') }
    end

    context "page should not have nav seletor when book.count <= 10" do
      let!(:books) { FactoryGirl.create_list(:book,10) }
      before do
        visit books_path
      end
      it { page.should_not have_css('nav.pagination') }
    end
  end

  describe "page should have submit button" do
    let(:isbn) { '9784274068669' }
    before do
      visit new_book_path
      fill_in 'book_isbn', with: isbn
      click_button("Add Book")
    end

    it "should redirect_to books_path after click" do
      current_path.should eq(books_path)
    end
  end

  describe "page should contain edit" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
    end

    it { page.should have_selector('a', :text => 'Edit') }
  end

  describe "page should contain edit result" do
    let!(:book) { FactoryGirl.create(:book) }
    let(:update_book) {
      FactoryGirl.build(:book,
                        title: "modified:#{book.title}",
                        image_url:"[update] #{book.image_url}")
    }

    before do
      visit edit_book_path(id: book.id)
      fill_in 'book_title', with: "modified:#{book.title}"
      fill_in 'book_image_url', with: "[update] #{book.image_url}"
      click_button("Update Book")
    end

    it { page.should have_content(update_book.title) }
    it { page.should have_image(update_book.image_url) }
  end

  describe "after click img, current_path == edit_book_path[:id]" do
    let!(:book) { FactoryGirl.create(:book) }
 
    before do
      visit books_path
      page.find(:css, '.book_image').click
    end
 
    it { current_path == edit_book_path(book.id) }
   end  
end
