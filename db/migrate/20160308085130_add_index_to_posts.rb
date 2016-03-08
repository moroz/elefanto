class AddIndexToPosts < ActiveRecord::Migration
  def change
    add_index :posts, :number
    add_index :posts, :url
    remove_index :posts, :title
    remove_index :posts, :user_id
    remove_column :posts, :user_id
  end
end
