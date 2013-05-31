require 'spec_helper'

describe BooksController do

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
    let!(:books) { FactoryGirl.create(:book) }
    before do
      get :new
    end
    it { response.should be_success }

  end
end
