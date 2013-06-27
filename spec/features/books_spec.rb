# -*- coding: utf-8 -*-
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

  describe "page should contain link_to edit_book_path" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
    end

    it { page.should have_selector('a', text: 'Edit') }
  end

  describe "page should contain edit result" do
    let(:book) { FactoryGirl.create(:book) }
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

    subject { page }

    it { should have_content(update_book.title) }
    it { should have_image(update_book.image_url) }
  end

  describe "after click img, current_path == edit_book_path[:id]" do
    let!(:book) { FactoryGirl.create(:book) }
 
    before do
      visit books_path
      page.find(:css, '.book_image').click
    end
 
    specify { current_path.should == edit_book_path(book.id) }
  end

  describe "page should contain delete" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
    end

    it { page.should have_selector('a', :text => 'Delete') }
  end

  describe "after click delete linck should redirect to books_path" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
      click_link('Delete')
    end

    specify { current_path.should eq(books_path) }
  end

  describe "after click search button should go to search_path" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
      fill_in 'title', with: "列車本"
      click_button('search')
    end

    specify { current_path.should eq(search_path) }
  end

  describe "search page should contain" do
    let!(:book) { FactoryGirl.create(:book) }

    before do
      visit books_path
      fill_in 'title', with: "列車本"
      click_button('search')
    end

    subject { page }
    it { should have_selector('h3', :text => 'Search Result') }
    it { should have_content(book.title) }
    it { should have_image(book.image_url) }
  end
end
