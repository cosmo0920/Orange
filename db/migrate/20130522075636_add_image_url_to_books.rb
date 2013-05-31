class AddImageUrlToBooks < ActiveRecord::Migration
  def change
		add_column :books, :image_url, :string, limit: 2048
  end
end
