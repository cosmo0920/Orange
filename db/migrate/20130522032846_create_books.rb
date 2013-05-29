class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
			t.string :title, null: false
			t.text :description,  null: false
			t.string :isbn,  limit: 13, null: false
      t.timestamps
    end
  end
end
