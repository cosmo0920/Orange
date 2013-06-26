# -*- coding: utf-8 -*-
require 'spec_helper'

describe BooksController do
  include_context "amazon_api_mock"

  describe "GET 'index'" do
		let!(:books) { FactoryGirl.create_list(:book, 2) }

		before do
      get 'index'
		end

    it { assigns(:books).should eq books }
  end

  describe "GET 'index' when Book.count == 12" do
    let!(:books) { FactoryGirl.create_list(:book, 12) }
    context "visit page 1" do
      before do
        get 'index'
      end
      it { response.should be_success }
      it { assigns(:books).count.should eq 10 }
    end
      
    context "visit page 2" do
      before do
        get 'index', {page: 2}
      end
      it { response.should be_success }
      it { assigns(:books).count.should eq 2 }
    end
  end

  describe "GET new_book_path" do
    let!(:book) { FactoryGirl.create(:book) }
    before do
      get :new
    end
    it { response.should be_success }
  end

  describe "POST /books" do
    context "valid params" do
      let(:book) { FactoryGirl.attributes_for(:book) }
      it "creates a new book" do
        expect { post :create, book: book }.to change{ Book.count }.by(1)
      end

      it "redirects to books_path" do
        post :create, book: book
        response.should redirect_to(books_path)
      end
    end

    context "invalid params" do
      let(:book) { FactoryGirl.attributes_for(:book, isbn: nil) }
      it "creates a new book" do
        expect { post :create, book: book }.to change{ Book.count }.by(0)
      end

      it "redirects to edit_book_path" do
        post :create, book: book
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit_book_path" do
    let(:book) { FactoryGirl.create(:book) }
    before do
      get :edit, id: book.id
    end

    it { response.should be_success }
  end

  describe "PATCH /books/1" do
    let!(:book) { FactoryGirl.create(:book) }

    context "valid params" do
      let(:edited_book) { FactoryGirl.attributes_for(:book) }
      before { patch :update, id: book.id, book: edited_book }
      it { response.should redirect_to(books_path) }
    end

    context "invalid params" do
      let(:edited_book) { FactoryGirl.attributes_for(:book, title: nil) }
      before { patch :update, id: book.id, book: edited_book }
      it { expect(response).to render_template(:edit) }
    end
  end

  describe "DELETE /books/1" do
    let(:book) { FactoryGirl.create(:book) }
    subject { delete :destroy, id: book.id }

    it { response.should be_success }
    it { subject.should redirect_to(books_path) }
  end

  describe "DELETE /books/1 should be Book#count -1" do
    let!(:book) { FactoryGirl.create(:book) }

    it { expect { delete :destroy, id: book.id }.to change(Book, :count).by(-1) }
  end

  describe "POST /books/search/#format"do
    named_let(:search_book_title) { '列車本' }
    context "when book found" do
      let(:book) { FactoryGirl.create(:book, title: search_book_title) }
      subject { post :search, title: search_book_title }

      it { response.should be_success }
    end

    context "when book not found" do
      let(:book) { FactoryGirl.create(:book) }
      subject { post :search, title: nil }

      it { response.should be_success }
      it { subject.should redirect_to(books_path) }
    end
  end
end
