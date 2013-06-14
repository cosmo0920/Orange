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

      it "redirects to books_path" do
        post :create, book: book
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit_book_path" do
    let!(:books) { FactoryGirl.create(:book) }
    before do
      get :edit, id: 1
    end

    it { response.should be_success }
  end

  describe "update book" do
    let!(:books) { FactoryGirl.create(:book) }
    before do
      get :edit, id: 1
    end

    it "POST books_path with valid params" do
      post :update, id: 1, book: {title: 'title', image_url: 'test.png' }
      response.should redirect_to(books_path)
    end

    it "POST books_path with invalid params" do
      expect {
        post(:update, id: 1, book: {})
      }.to raise_error ActionController::ParameterMissing
    end
  end
end
