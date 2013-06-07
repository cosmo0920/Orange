# -*- coding: utf-8 -*-
shared_context "amazon_api_mock" do
  before do
    Amazon.any_instance.stub(:book_title) { "列車本" }
    Amazon.any_instance.stub(:book_image_url) { 'http://ecx.images-amazon.com/images/I/51Gibg-iYTL._SL75_.jpg' }
  end
end
