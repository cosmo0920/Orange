require 'spec_helper'

describe BooksController do

  describe "GET 'index'" do
		before do
      get 'index'
		end

    it { response.should be_success }
  end

end
