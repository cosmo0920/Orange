class AddUniquenessConstraintIntoBooks < ActiveRecord::Migration
  def change
    add_index :books, :isbn, :unique=>true
  end
end
